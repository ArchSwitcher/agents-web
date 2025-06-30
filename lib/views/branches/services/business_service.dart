import 'dart:convert';

import 'package:agents_app/models/branch/business_model.dart';
import 'package:agents_app/services/base_service.dart';
import 'package:agents_app/services/crud_service.dart';
import 'package:agents_app/services/toast_service.dart';
import 'package:http/http.dart' as http;

class BranchBusinessService extends BaseService
    implements CrudService<BranchBusinessModel> {
  @override
  Future<List<BranchBusinessModel>> getAll(dynamic value) async {
    final response = await http.get(
      Uri.parse('$baseUrl/business/getBusinessName'),
      headers: buildHeaders(),
    );

    try {
      if (response.statusCode == 200) {
        final decoded = json.decode(response.body);
        final List data = decoded['data'];
        print("objects: response ---- $data");
        return data.map((json) => BranchBusinessModel.fromJson(json)).toList();
      } else {
        throw Exception('Error al cargar razón social de sucursales');
      }
    } catch (e) {
      print("objects: error ---- $e");
      throw Exception('Error al cargar razón social de sucursales: $e');
    }
  }

  @override
  Future<BranchBusinessModel> getById(String id) async {
    // Implement the logic to fetch a branch by ID
    throw UnimplementedError('getById method not implemented');
  }

  @override
  Future<bool> create(BranchBusinessModel item) async {
    final response = await http.post(
      Uri.parse("$baseUrl/business/createBusinessName"),
      headers: buildHeaders(),
      body: jsonEncode(item.toJson()),
    );

    print("objects: response ---- ${item.toJson()}");

    if (response.statusCode == 200) {
      return true;
    } else {
      ToastService.error(
        title: "Sucursal",
        subTitle: "Error al crear razón social",
      );
      throw Exception('Error al crear razón social');
    }
  }

  @override
  Future<bool> update(String id, BranchBusinessModel item) async {
    final response = await http.put(
      Uri.parse("$baseUrl/business/updateBusinessName/$id"),
      headers: buildHeaders(),
      body: jsonEncode(item.toJson()),
    );

    print("objects: response update $id ---- ${jsonEncode(item.toJson())}");

    if (response.statusCode == 200) {
      return true;
    } else {
      ToastService.error(
        title: "Sucursal",
        subTitle: "Error al actualizar razón social",
      );
      throw Exception('Error al actualizar razón social');
    }
  }

  @override
  Future<bool> delete(String id) async {
    final response = await http.delete(
      Uri.parse("$baseUrl/branch-contact/enabledBranchContact/$id"),
      body: jsonEncode({"status": 0}),
      headers: buildHeaders(),
    );

    if (response.statusCode == 200) {
      return true;
    } else {
      ToastService.error(
        title: "Sucursal",
        subTitle: "Error al eliminar razón social",
      );
      throw Exception('Error al eliminar razón social');
    }
  }
}
