// import 'package:agents_app/models/branch/receive_request.dart';
import 'dart:convert';

import 'package:agents_app/controllers/loader_controller.dart';
import 'package:agents_app/models/branch/receive_request.dart';
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
  TextEditingController servicePointsController = TextEditingController();
  RxInt currentRating = 0.obs;

  final SignatureController signatureController = SignatureController(
    penStrokeWidth: 5,
    penColor: Colors.red,
    exportBackgroundColor: Colors.blue,
  );

  get signature => signatureController.toPngBytes();

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
    servicePointsController.clear();
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
    // final file = await uploadFileService.base64ToFile(
    //     equipmentController.value.base64!, 'letter.png');

    // print("equipmentController value: ${equipmentController.value.base64}");

    final file = await uploadFileService.uploadPhotoWebFromBase64(
      base64String: equipmentController.value.base64!,
      fileName: 'equipment.png',
      mimeType: 'image/png',
      folder: 'position/$branchId'
    );

    

    // final photoUrl =
    //     await uploadFileService.uploadPhotoWeb(equipmentController.value.base64!, 'position/$branchId');
    // print("Photo URL: $photoUrl");

    // try {
    //   final position = BranchReceiveRequestModel(
    //     startTime: startTimeController.text,
    //     endTime: endTimeController.text,
    //     agency: agencyController.text,
    //     requiresEvacuation: requiresEvacuation.value,
    //     translationLand: lugarPlaceController.text,
    //     agentsPhotos: agentsController.map((e) => e.value).toList(),
    //     letterPhoto: letterController.value,
    //     equipmentPhoto: equipmentController.value,
    //     groupAgentsPhoto: groupAgentsController.value,
    //     receiverPhoto: signature,
    //     responsible: responsibleController.text,
    //     receiver: receiverControllerText.text,
    //     servicePoints: servicePointsController.text,
    //     branchId: branchId,
    //   );

    //   await branchPositionFormService.create(position);
    //   clearControllers();
    //   Get.back(result: true);
    // } catch (e) {
    //   print("Error saving branch position: $e");
    // }
  }

  @override
  void onInit() {
    super.onInit();
    isCheckedList.assignAll(
      List.generate(equipmentItems.length, (_) => false.obs),
    );
  }
}
