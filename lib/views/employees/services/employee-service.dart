import 'dart:convert';

import 'package:agents_app/models/employee/employee_model.dart';
import 'package:agents_app/services/base_service.dart';
import 'package:agents_app/services/crud_service.dart';
import 'package:agents_app/services/toast_service.dart';
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
        ToastService.warning(title: "Empleados", subTitle: "No se encontraron empleados");
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


  Future<bool> replaceTempEmployeePosition(String positionId, String employeeId, String? oldEmployeeId) async {
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


  @override
  Future<EmployeeModel> getById(String id) async {
    // Implement logic to fetch an employee by ID
    // Example:
    throw UnimplementedError('getById method not implemented');
  }

  @override
  Future<bool> create(EmployeeModel item) async {
    // Implement logic to create a new employee
    // Example:
    return true;
  }

  @override
  Future<bool> update(String id, EmployeeModel item) async {
    // Implement logic to update an existing employee
    // Example:
    return true;
  }

  @override
  Future<bool> delete(String id) async {
    // Implement logic to delete an employee by ID
    // Example:
    return true;
  }
}
