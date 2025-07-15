import 'package:agents_app/controllers/loader_controller.dart';
import 'package:agents_app/models/common/dropdown_option_model.dart';
import 'package:agents_app/models/presence/presence_model.dart';
import 'package:agents_app/views/branches/services/presence_service.dart';
import 'package:agents_app/views/employees/controller/employee_controller.dart';
import 'package:get/get.dart';

class PresenceController extends GetxController {
  PresenceService presenceService = PresenceService();
  LoaderController loaderController =
      Get.put<LoaderController>(LoaderController());  
  EmployeeController employeeController =
      Get.put<EmployeeController>(EmployeeController());

  final RxList<PresenceModel> presenceList = <PresenceModel>[].obs;



  @override
  void onInit() {
    super.onInit();    
  }

  Future<void> fetchPresenceData(String positionId, List<String> employeeIds) async {
    try {
      loaderController.show();
      

      final List<PresenceModel> presenceData = [];
      for (String employeeId in employeeIds) {
        final data = await presenceService.getAll("$employeeId/$positionId");
        print("objects: Fetched presence data for ${data.length}");
        presenceData.addAll(data);
      }
      

      presenceList.value = presenceData;
    } catch (e) {
      print('Error fetching presence data: $e');
    } finally {
      loaderController.hide();
    }
  }

  Future<void> fetchEmployeesTemp(int employeeId) async {
    try {
      loaderController.show();
      await employeeController.fetchInactiveEmployees();
    } catch (e) {
      print('Error fetching presence data by employee ID: $e');
    } finally {
      loaderController.hide();
    }
  }

  Future<void> replaceEmployeePosition(
      String positionId, String employeeId, String oldEmployeeId) async {
    try {
      loaderController.show();
      await employeeController.replaceTempEmployeePosition(positionId, employeeId, oldEmployeeId);
      print("objects: Employee position replaced successfully");
    } catch (e) {
      print('Error replacing employee position: $e');
    } finally {
      loaderController.hide();
    }
  }

  clearEmployeeTemp() {
    employeeController.employeeTemp.value = DropDownOption(id: '', label: '');
  }



}
