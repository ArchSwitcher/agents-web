// import 'package:agents_app/models/branch/receive_request.dart';
import 'package:agents_app/controllers/loader_controller.dart';
import 'package:agents_app/models/document/document_model.dart';
import 'package:agents_app/models/position/position_model.dart';
import 'package:agents_app/views/positions/services/position_services.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class BranchPositionFormController extends GetxController {
  PositionServices positionService = PositionServices();
  LoaderController loaderController = Get.put(LoaderController());
  RxBool isLoading = true.obs;
  //
  final RxList<PositionModel> positions = <PositionModel>[].obs;

  //form fields

  TextEditingController startTimeController = TextEditingController();
  TextEditingController endTimeController = TextEditingController();
  TextEditingController agencyController = TextEditingController();
  RxBool requiresEvacuation = false.obs;
  TextEditingController lugarPlaceController = TextEditingController();

  RxList<DocumentModel> agentsController = <DocumentModel>[].obs;
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

  // RxList<ImageToUpload> agentsController = <ImageToUpload>[].obs;
  // Rx<ImageToUpload> letterController = ImageToUpload(base64: "", needUpdate: false, link: "").obs;
  // Rx<ImageToUpload> equipmentController = ImageToUpload(base64: "", needUpdate: false, link: "").obs;
  // Rx<ImageToUpload> groupAgentsController = ImageToUpload(base64: "", needUpdate: false, link: "").obs;
  // Rx<ImageToUpload> receiverController = ImageToUpload(base64: "", needUpdate: false, link: "").obs;

  RxList<String> checkListEquipment = <String>[].obs;
  TextEditingController responsibleController = TextEditingController();
  TextEditingController receiverControllerText = TextEditingController();
  TextEditingController servicePointsController = TextEditingController();

  void clearControllers() {
    startTimeController.clear();
    endTimeController.clear();
    agencyController.clear();
    lugarPlaceController.clear();
    requiresEvacuation.value = false;
  }

  Future<void> fetchPositions() async {
    try {
      //get arguments
      final branchId = Get.arguments['branchId'];
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

  @override
  void onInit() {
    super.onInit();
  }
}
