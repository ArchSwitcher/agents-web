import 'package:agents_app/controllers/loader_controller.dart';
import 'package:agents_app/models/presence/presence_model.dart';
import 'package:agents_app/views/branches/services/presence_service.dart';
import 'package:get/get.dart';

class PresenceController extends GetxController {
  PresenceService presenceService = PresenceService();
  LoaderController loaderController =
      Get.put<LoaderController>(LoaderController());

  final RxList<PresenceModel> presenceList = <PresenceModel>[].obs;

  @override
  void onInit() {
    super.onInit();
  }

  Future<void> fetchPresenceData() async {
    try {
      loaderController.show();
      final presenceData = await presenceService.getAll("11/18");
      print("objects: presenceData ---- ${presenceData.length} records ");
      presenceList.value = presenceData;
    } catch (e) {
      print('Error fetching presence data: $e');
    } finally {
      loaderController.hide();
    }
  }
}
