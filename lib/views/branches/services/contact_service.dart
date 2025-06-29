import 'dart:convert';

import 'package:agents_app/models/branch/contact_model.dart';
import 'package:agents_app/services/base_service.dart';
import 'package:agents_app/services/crud_service.dart';
import 'package:agents_app/services/toast_service.dart';
import 'package:http/http.dart' as http;


class BranchContactService extends BaseService implements CrudService<BranchContactModel> { 
  @override
  Future<List<BranchContactModel>> getAll(dynamic value) async {
       final response = await http.get(
      Uri.parse('$baseUrl/branch-contact/getBranchContact'),
      headers: buildHeaders(),
    );

    try {
      if (response.statusCode == 200) {
      final decoded = json.decode(response.body);
      final List data = decoded['data'];
      return data.map((json) => BranchContactModel.fromJson(json)).toList();
    } else {
      throw Exception('Error al cargar contactos de sucursales');
    }
    } catch (e) {
      print("objects: error ---- $e");
      throw Exception('Error al cargar contactos de sucursales: $e');
    }
  }

  @override
  Future<BranchContactModel> getById(String id) async {
    // Implement the logic to fetch a branch by ID
    throw UnimplementedError('getById method not implemented');
  }

  @override
  Future<bool> create(BranchContactModel item) async {
     final response = await http.post(
      Uri.parse("$baseUrl/branch-contact/createBranchContact"),
      headers: buildHeaders(),
      body: jsonEncode(item.toJson()),
    );

    print("objects: response ---- ${item.toJson()}");

    if (response.statusCode == 200) {
    
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
  Future<bool> update(String id, dynamic item) async {
    // Implement the logic to update an existing branch
    throw UnimplementedError('update method not implemented');
  }

  @override
  Future<bool> delete(String id) async {
    // Implement the logic to delete a branch by ID
    throw UnimplementedError('delete method not implemented');
  }

}