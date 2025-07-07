// import 'package:agents_app/models/branch/receive_request.dart';
// import 'dart:convert';

import 'dart:convert';

import 'package:agents_app/controllers/loader_controller.dart';
import 'package:agents_app/models/branch/receive_request.dart';
// import 'package:agents_app/models/branch/receive_request.dart';
import 'package:agents_app/models/document/document_model.dart';
import 'package:agents_app/models/position/position_model.dart';
import 'package:agents_app/services/upload_file.dart';
import 'package:agents_app/views/branches/services/branch_position_form_service.dart';
import 'package:agents_app/views/positions/services/position_services.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:signature/signature.dart';

class BranchPositionFormController extends GetxController {
  PositionServices positionService = PositionServices();
  LoaderController loaderController = LoaderController();
  BranchPositionFormService branchPositionFormService =
      BranchPositionFormService();
  UploadFileService uploadFileService = UploadFileService();

  RxBool isLoading = true.obs;

  final RxList<PositionModel> positions = <PositionModel>[].obs;

  //form fields

  TextEditingController startTimeController = TextEditingController();
  TextEditingController endTimeController = TextEditingController();
  TextEditingController agencyController = TextEditingController();
  RxBool requiresEvacuation = false.obs;
  TextEditingController lugarPlaceController = TextEditingController();

  List<Rx<DocumentModel>> agentsController = [];
  Rx<DocumentModel> letterController =
      DocumentModel(id: "", name: "", needUpdate: false, base64: "", link: '')
          .obs;
  Rx<DocumentModel> equipmentController =
      DocumentModel(id: "", name: "", needUpdate: false, base64: "", link: '')
          .obs;
  Rx<DocumentModel> groupAgentsController =
      DocumentModel(id: "", name: "", needUpdate: false, base64: "", link: '')
          .obs;
  Rx<DocumentModel> receiverController =
      DocumentModel(id: "", name: "", needUpdate: false, base64: "", link: '')
          .obs;

  void initializeAgentControllers(List<PositionModel> positions) {
    agentsController = positions
        .map((_) => Rx<DocumentModel>(DocumentModel(
            id: "", name: "", needUpdate: false, base64: "", link: '')))
        .toList();
  }

  RxList<String> checkListEquipment = <String>[].obs;
  TextEditingController responsibleController = TextEditingController();
  TextEditingController receiverControllerText = TextEditingController();
  RxInt currentRating = 0.obs;

  final SignatureController signatureController = SignatureController(
    penStrokeWidth: 5,
    penColor: Colors.red,
    exportBackgroundColor: Colors.blue,
  );

  // get signature async => await signatureController.toPngBytes();

  final List<String> equipmentItems = [
    'Uniforme completo (Camisa y Pantalón)',
    'Suéter',
    'Gorra',
    'Botas',
    'Chapa',
    'Chaleco blindado',
    'Cinturón',
    'Tonfa completa',
    'Batón retráctil',
    'Gorgorito',
    'Grilletes',
    'Linterna',
    'Teléfono y cargador',
    'Tablilla',
    'Libreta',
    'Lapicero',
    'Poncho de agua',
    'Botas de hule',
  ];
  final RxList<RxBool> isCheckedList = <RxBool>[].obs;

  void clearControllers() {
    startTimeController.clear();
    endTimeController.clear();
    agencyController.clear();
    lugarPlaceController.clear();
    requiresEvacuation.value = false;
    agentsController.forEach((controller) {
      controller.value = DocumentModel(
        id: "",
        name: "",
        needUpdate: false,
        base64: "",
        link: '',
      );
    });
    letterController.value = DocumentModel(
      id: "",
      name: "",
      needUpdate: false,
      base64: "",
      link: '',
    );
    equipmentController.value = DocumentModel(
      id: "",
      name: "",
      needUpdate: false,
      base64: "",
      link: '',
    );
    groupAgentsController.value = DocumentModel(
      id: "",
      name: "",
      needUpdate: false,
      base64: "",
      link: '',
    );
    currentRating.value = 0;
    signatureController.clear();
    responsibleController.clear();
    receiverControllerText.clear();
    currentRating.value = 0;
    isCheckedList.forEach((item) => item.value = false);
  }

  Future<void> fetchPositions() async {
    try {
      //get arguments
      final branchId = Get.arguments['branchId'];
      print("Fetching positions for branchId: $branchId");
      positions.clear();
      loaderController.show();
      isLoading.value = true;
      final response =
          await positionService.getAllPositionsByBranchId(branchId);

      positions.assignAll(response);
    } catch (e) {
      // Handle error
      print("Error fetching positions: $e");
    } finally {
      loaderController.hide();
      isLoading.value = false;

      update();
    }
  }

  Future<void> saveBranchPosition() async {
    final branchId = Get.arguments['branchId'];
    print("branchid: $branchId");

    print("int.parse(servicePointsController.text) ${currentRating.value}");
    print("int.parse(branchId) ${int.parse(branchId)}");


    final equipment = await uploadFileService.uploadPhotoWebFromBase64(
        base64String: equipmentController.value.base64!,
        fileName: 'equipment.png',
        mimeType: 'image/png',
        folder: 'position/$branchId');

    print("Equipment photo link: $equipment");

    final letter = await uploadFileService.uploadPhotoWebFromBase64(
        base64String: letterController.value.base64!,
        fileName: 'letter.png',
        mimeType: 'image/png',
        folder: 'position/$branchId');
    
    print("Letter photo link: $letter");

    final groupAgents = await uploadFileService.uploadPhotoWebFromBase64(
        base64String: groupAgentsController.value.base64!,
        fileName: 'group_agents.png',
        mimeType: 'image/png',
        folder: 'position/$branchId');

    print("Group agents photo link: $groupAgents");

    // signature
    final signature = await signatureController.toPngBytes();
    String base64SignatureString = base64Encode(signature!);
    final receiver = await uploadFileService.uploadPhotoWebFromBase64(
        base64String: base64SignatureString,
        fileName: 'receiver.png',
        mimeType: 'image/png',
        folder: 'position/$branchId');

    print("Receiver photo link: $receiver");
    // agents photos

    equipmentController.value.updateLink(equipment!);
    letterController.value.updateLink(letter!);
    groupAgentsController.value.updateLink(groupAgents!);
    receiverController.value.updateLink(receiver!);
    // update with agents photos

    await Future.forEach<Rx<DocumentModel>>(agentsController, (e) async {
      final link = await uploadFileService.uploadPhotoWebFromBase64(
        base64String: e.value.base64!,
        fileName: '${e.value.name}.png',
        mimeType: 'image/png',
        folder: 'position/$branchId',
      );
      e.value.updateLink(link!);
    });
    agentsController.forEach((e) {
      print("Agent photo link: ${e.value.link}");
    });
    print("Letter photo link: ${letterController.value.link}");
    print("Equipment photo link: ${equipmentController.value.link}");
    print("Group agents photo link: ${groupAgentsController.value.link}");
    print("Signature photo link: ${receiverController.value.link}");

    final selectedEquipment = <String>[];
    for (int i = 0; i < isCheckedList.length; i++) {
      if (isCheckedList[i].value) {
        selectedEquipment.add(equipmentItems[i]);
      }
    }

    try {
      final position = BranchReceiveRequestModel(
        startTime: startTimeController.text,
        endTime: endTimeController.text,
        agency: agencyController.text,
        requiresEvacuation: requiresEvacuation.value,
        translationLand: lugarPlaceController.text,
        agentsPhotos: agentsController.map((e) => e.value).toList(),
        letterPhoto: letterController.value,
        equipmentPhoto: equipmentController.value,
        groupAgentsPhoto: groupAgentsController.value,
        receiverPhoto: receiverController.value,
        responsible: responsibleController.text,
        receiver: receiverControllerText.text,
        servicePoints: currentRating.value,
        branchId: int.parse(branchId),
        checklistEquipment: selectedEquipment.join(', '),
      );

      await branchPositionFormService.create(position);
      // clearControllers();
      // Get.back(result: true);
    } catch (e) {
      print("Error saving branch position: $e");
    }
  }

  @override
  void onInit() {
    super.onInit();
    isCheckedList.assignAll(
      List.generate(equipmentItems.length, (_) => false.obs),
    );
  }
}
