import 'package:agents_app/controllers/loader_controller.dart';
import 'package:agents_app/models/common/dropdown_option_model.dart';
import 'package:agents_app/models/employee/employee_model.dart';
import 'package:agents_app/views/employees/services/employee-service.dart';
import 'package:flutter/widgets.dart';
import 'package:get/get.dart';

class EmployeeController extends GetxController {
  EmployeeService employeeService = EmployeeService();
  LoaderController loaderController = Get.put(LoaderController());

  final RxList<EmployeeModel> employees = <EmployeeModel>[].obs;
  final RxList<EmployeeModel> employeesTemp = <EmployeeModel>[].obs;

  final RxBool isLoadingInactiveEmployees = false.obs;

  final Rx<DropDownOption> employeeTemp = DropDownOption(id: '', label: '').obs;

  TextEditingController searchNameController = TextEditingController();

  Future<void> fetchEmployees() async {
    loaderController.show();
    final result = await employeeService.getAll(null);
    print("object----%% $result ${result.length}");
    result
        .map((e) => {
              print("object ${e.firstName}"),
            })
        .toList();
    employees.value = result;
    loaderController.hide();
  }

  Future<void> searchEmployees() async {
    try {
      loaderController.show();
      final result = await employeeService.searchEmployee(
          searchNameController.text);
      print("object----%% $result ${result.length}");
      employees.value = result;
    } catch (e) {
      print("Error searching employees: $e");
    } finally {
      loaderController.hide();
    }
  }

  Future<void> fetchInactiveEmployees() async {
    try {
      isLoadingInactiveEmployees.value = true;
      final result = await employeeService.getInactiveEmployees(null);
      print("object----%%0-0-98 $result ${result.length}");
      employeesTemp.value = result;
    } catch (e) {
      print("Error fetching inactive employees: $e");
    } finally {
      isLoadingInactiveEmployees.value = false;
    }
  }

  // replaceTempEmployeePosition
  Future<void> replaceTempEmployeePosition(
      String positionId, String employeeId, String? oldEmployeeId) async {
    try {
      loaderController.show();
      await employeeService.replaceTempEmployeePosition(positionId, employeeId, oldEmployeeId);
      print("objects: Employee position replaced successfully");
    } catch (e) {
      print('Error replacing employee position: $e');
    } finally {
      loaderController.hide();
    }
  }

  // Example method to remove an employee
  void removeEmployee(EmployeeModel employee) {
    employees.remove(employee);
  }
}
