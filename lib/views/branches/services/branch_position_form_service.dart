import 'dart:convert';

import 'package:agents_app/models/branch/receive_request.dart';
import 'package:agents_app/services/base_service.dart';
import 'package:agents_app/services/crud_service.dart';
import 'package:agents_app/services/toast_service.dart';
import 'package:http/http.dart' as http;

class BranchPositionFormService extends BaseService
    implements CrudService<BranchReceiveRequestModel> {
  @override
  Future<List<BranchReceiveRequestModel>> getAll(dynamic value) async {
    throw UnimplementedError('getAll method not implemented');
  }

  @override
  Future<BranchReceiveRequestModel> getById(String id) async {
    //! Implement the logic to fetch a presence record by ID
    throw UnimplementedError('getById method not implemented');
  }

  @override
  Future<bool> create(BranchReceiveRequestModel item) async {
    final response = await http.post(
      Uri.parse("$baseUrl/branch/documents"),
      headers: buildHeaders(),
      body: jsonEncode(item.toJson()),
    );

    print("Response status: ${response.body}");

    if (response.statusCode == 200) {
      ToastService.success(
        title: "Sucursal",
        subTitle: "Sucursal creada correctamente",
      );
      return true;
    } else {
      ToastService.error(
        title: "Sucursal",
        subTitle: "Error al crear sucursal",
      );
      throw Exception('Error al crear sucursal');
    }
  }

  @override
  Future<bool> update(String id, BranchReceiveRequestModel item) async {
    // Implement the logic to update an existing presence record
    throw UnimplementedError('update method not implemented');
  }

  @override
  Future<bool> delete(String id) async {
    // Implement the logic to delete a presence record
    throw UnimplementedError('delete method not implemented');
  }
}
