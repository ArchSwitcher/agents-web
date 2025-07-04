import 'package:agents_app/controllers/loader_controller.dart';
import 'package:agents_app/models/employee/employee_model.dart';
import 'package:agents_app/views/employees/services/employee-service.dart';
import 'package:get/get.dart';

class EmployeeController extends GetxController {
  
  EmployeeService employeeService = EmployeeService();
  LoaderController loaderController = Get.put(LoaderController());

  final RxList<EmployeeModel> employees = <EmployeeModel>[].obs; 

  Future<void> fetchEmployees() async {
    loaderController.show();
    final result = await employeeService.getAll(null);
    print("object----%% $result ${result.length}");
    result.map((e) => {
      print("object ${e.firstName}"),
    }).toList();
    employees.value = result;
    loaderController.hide();
  }

  // Example method to remove an employee
  void removeEmployee(EmployeeModel employee) {
    employees.remove(employee);
  }
}