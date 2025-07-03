import 'dart:convert';

import 'package:agents_app/services/base_service.dart';
import 'package:agents_app/services/crud_service.dart';
import 'package:agents_app/services/toast_service.dart';
import 'package:http/http.dart' as http;

class EmployeeAgentService extends BaseService implements CrudService<dynamic> {
  @override
  Future<bool> create(dynamic model) async {
    final response = await http.post(
      Uri.parse("$baseUrl/employee/createEmployee"),
      headers: buildHeaders(),
      body: jsonEncode(model.toJson()),
    );

    print("objects: response employee ##### ${model.toJson()}");

    if (response.statusCode == 200) {
      return true;
    } else {
      ToastService.error(
        title: "Empleado",
        subTitle: "Error al crear Empleado",
      );
      throw Exception('Error al crear Empleado');
    }
  }

  @override
  Future<dynamic> getById(String id) async {
    throw UnimplementedError('read method is not implemented');
  }

  @override
  Future<List<dynamic>> getAll(dynamic value) async {
    throw UnimplementedError('getAll method is not implemented');
  }

  @override
  Future<bool> update(String id, dynamic model) async {
    throw UnimplementedError('update method is not implemented');
  }

  @override
  Future<bool> delete(String id) async {
    throw UnimplementedError('delete method is not implemented');
  }
}
