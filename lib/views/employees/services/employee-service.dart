import 'dart:convert';

import 'package:agents_app/controllers/globals.dart';
import 'package:agents_app/models/employee/employee_model.dart';
import 'package:agents_app/services/base_service.dart';
import 'package:agents_app/services/crud_service.dart';
import 'package:agents_app/services/toast_service.dart';
import 'package:get/get.dart';
import 'package:http/http.dart' as http;

class EmployeeService extends BaseService
    implements CrudService<EmployeeModel> {
  @override
  Future<List<EmployeeModel>> getAll(dynamic value) async {
    final response = await http.get(
      Uri.parse('$baseUrl/employee'),
      headers: buildHeaders(),
    );

    try {
      if (response.statusCode == 200) {
        final decoded = json.decode(response.body);
        final List data = decoded['data'];
        return data.map((json) => EmployeeModel.fromJson(json)).toList();
      } else {
        ToastService.warning(
            title: "Empleados", subTitle: "No se encontraron empleados");
        return [];
      }
    } catch (e) {
      print("objects: error ---- $e");
      throw Exception('Error al cargar sucursales: $e');
    }
  }

  Future<List<EmployeeModel>> getInactiveEmployees(dynamic value) async {
    final response = await http.get(
      Uri.parse('$baseUrl/employee/getInactiveEmployee'),
      headers: buildHeaders(),
    );

    try {
      if (response.statusCode == 200) {
        final decoded = json.decode(response.body);
        final List data = decoded['data'];
        return data.map((json) => EmployeeModel.fromJson(json)).toList();
      } else {
        throw Exception('Error al cargar sucursales');
      }
    } catch (e) {
      print("objects: error ---- $e");
      throw Exception('Error al cargar sucursales: $e');
    }
  }

  Future<List<EmployeeModel>> getEmployeesWithPosition(dynamic value) async {
    final response = await http.get(
      Uri.parse('$baseUrl/employee/getEmployeePosition'),
      headers: buildHeaders(),
    );

    try {
      if (response.statusCode == 200) {
        final decoded = json.decode(response.body);
        final List data = decoded['data'];
        return data.map((json) => EmployeeModel.fromJson(json)).toList();
      } else {
        throw Exception('Error al cargar sucursales');
      }
    } catch (e) {
      print("objects: error ---- $e");
      throw Exception('Error al cargar sucursales: $e');
    }
  }

  Future<bool> replaceTempEmployeePosition(
      String positionId, String employeeId, String? oldEmployeeId) async {
    final response = await http.post(
      Uri.parse('$baseUrl/employee/replaceEmployee'),
      headers: buildHeaders(),
      body: json.encode({
        'oldEmployeeId': oldEmployeeId,
        'employeeId': employeeId,
        'positionId': positionId,
        "dayId": DateTime.now().weekday.toString(),
        "motive": "Reemplazo de empleado temporal",
      }),
    );

    print("objects: response ---- ${DateTime.now().weekday.toString()}");
    print("objects: oldEmployeeId ---- ${oldEmployeeId.toString()}");
    print("objects: newEmployeeId ---- ${employeeId.toString()}");
    print("objects: positionId ---- ${positionId.toString()}");

    try {
      if (response.statusCode == 200) {
        final decoded = json.decode(response.body);
        return decoded['success'] ?? false;
      } else {
        throw Exception('Error al reemplazar empleado temporal');
      }
    } catch (e) {
      print("objects: error ---- $e");
      throw Exception('Error al reemplazar empleado temporal: $e');
    }
  }

  Future<List<EmployeeModel>> searchEmployee(
      String fullName, String workerStatus) async {
    String query = "employee/search";
    if (fullName.isNotEmpty) {
      query += "?fullName=$fullName";
    }
    if (workerStatus.isNotEmpty) {
      query += fullName.isNotEmpty
          ? "&workerStatus=$workerStatus"
          : "?workerStatus=$workerStatus";
    }

    print("Searching employees with query: $query");

    final response = await http.get(
      Uri.parse('$baseUrl/$query'),
      headers: buildHeaders(),
    );

    try {
      if (response.statusCode == 200) {
        final decoded = json.decode(response.body);
        final List data = decoded['data'];
        return data.map((json) => EmployeeModel.fromJson(json)).toList();
      } else {
        ToastService.warning(
            title: "Búsqueda empleados",
            subTitle: "No se encontraron empleados");
        return [];
      }
    } catch (e) {
      print("objects: error ---- $e");
      throw Exception('Error al cargar sucursales: $e');
    }
  }

  Future<bool> changeEmployeeStatus(String employeeId, String comment, String newStatus) async {
    final authController = Get.find<SessionController>();

    final response = await http.put(
      Uri.parse('$baseUrl/employee/change-employee-status'),
      headers: buildHeaders(),
      body: jsonEncode({
        "id": employeeId,
        "comment": comment,
        "user": authController.getUserId,
        "newStatus": newStatus,
      }),
    );

    if (response.statusCode == 200) {
      return true;
    } else {
      ToastService.error(
        title: "Empleado",
        subTitle: "Error al cambiar estado del empleado",
      );
      throw Exception('Error al cambiar estado del empleado');
    }
  }

  @override
  Future<EmployeeModel> getById(String id) async {
    final response = await http.get(
      Uri.parse("$baseUrl/employee/employee/$id"),
      headers: buildHeaders(),
    );

    if (response.statusCode == 200) {
      final body = jsonDecode(response.body);
      return EmployeeModel.fromJson(body['data']);
    } else {
      ToastService.error(
        title: "Empleado",
        subTitle: "Error al obtener Empleado",
      );
      throw Exception('Error al obtener Empleado');
    }
  }

  @override
  Future<bool> create(EmployeeModel model) async {
    final response = await http.post(
      Uri.parse("$baseUrl/employee/createEmployee"),
      headers: buildHeaders(),
      body: jsonEncode(model.toJson()),
    );

    print("objects: response employee ##### ${model.toJson()}");

    if (response.statusCode == 200) {
      return true;
    } else {
      // ToastService.error(
      //   title: "Empleado",
      //   subTitle: "Error al crear Empleado",
      // );
      throw Exception('Error al crear Empleado');
    }
  }

  @override
  Future<bool> update(String id, EmployeeModel item) async {
    final response = await http.put(
      Uri.parse("$baseUrl/employee/updateEmployee/$id"),
      headers: buildHeaders(),
      body: jsonEncode(item.toJson()),
    );
    print("UPDATE ID 👁️: $id");
    print("objects: UPDATE 🦁 employee ##### ${item.toJson().toString()}");

    if (response.statusCode == 200) {
      return true;
    } else {
      // ToastService.error(
      //   title: "Empleado",
      //   subTitle: "Error al actualizar Empleado",
      // );
      throw Exception('Error al actualizar Empleado');
    }
  }

  @override
  Future<bool> delete(String id) async {
    // Implement logic to delete an employee by ID
    // Example:
    return true;
  }
}
