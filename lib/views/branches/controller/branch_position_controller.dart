import 'package:agents_app/controllers/loader_controller.dart';
import 'package:agents_app/models/position/position_model.dart';
import 'package:agents_app/views/positions/services/position_services.dart';
import 'package:get/get.dart';

class BranchPositionController extends GetxController {
  PositionServices positionService = PositionServices();
  LoaderController loaderController = Get.put(LoaderController());

  final RxList<PositionModel> positions = <PositionModel>[].obs;
  final RxBool isLoading = true.obs;

  @override
  void onInit() {
    super.onInit();
    // fetchPositions();
  }

  Future<void> fetchPositions() async {
    try {
      loaderController.show();
      isLoading.value = true;
      final response = await positionService.getAllPositionsByBranchId("19");
      if (response.isNotEmpty) {
        positions.assignAll(response);
      }
    } catch (e) {
      // Handle error
      print("Error fetching positions: $e");
    } finally {
      loaderController.hide();
      isLoading.value = false;

      update();
    }
  }
}
