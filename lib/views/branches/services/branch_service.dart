import 'dart:convert';

import 'package:agents_app/models/branch/branch_index_model.dart';
import 'package:agents_app/services/base_service.dart';
import 'package:agents_app/services/crud_service.dart';
import 'package:http/http.dart' as http;

abstract class BranchService extends BaseService
    implements CrudService<BranchModel> {

  @override
  Future<List<BranchModel>> getAll() async {
    final response = await http.get(
      Uri.parse('$baseUrl/branch'),
      headers: buildHeaders(),
    );

    if (response.statusCode == 200) {
      final decoded = json.decode(response.body);
      final List data = decoded['data'];
      return data.map((json) => BranchModel.fromJson(json)).toList();
    } else {
      throw Exception('Error al cargar sucursales');
    }
  }

  @override
  Future<BranchModel> getById(String id) async {
    final response = await http.get(
      Uri.parse('$baseUrl/branch/$id'),
      headers: buildHeaders(),
    );

    if (response.statusCode == 200) {
      final data = json.decode(response.body)['data'];
      return BranchModel.fromJson(data);
    } else {
      throw Exception('Sucursal no encontrada');
    }
  }

  @override
  Future<bool> create(BranchModel item) async {
    final response = await http.post(
      Uri.parse("$baseUrl/branch/createBranch"),
      headers: buildHeaders(),
      body: jsonEncode(item.toJson()),
    );

    if (response.statusCode == 200) {
      return true;
    } else {
      throw Exception('Error al crear sucursal');
    }
  }

  @override
  Future<bool> update(String id, BranchModel item) async {
    final response = await http.put(
      Uri.parse("$baseUrl/branch/updateBranch/$id"),
      headers: buildHeaders(),
      body: jsonEncode(item.toJson()),
    );

    if (response.statusCode == 200) {
      return true;
    } else {
      throw Exception('Error al actualizar sucursal');
    }
  }

  @override
  Future<bool> delete(String id) async {
    final response = await http.delete(
      Uri.parse("$baseUrl/branch/deleteBranch/$id"),
      headers: buildHeaders(),
    );

    if (response.statusCode == 200) {
      return true;
    } else {
      throw Exception('Error al eliminar sucursal');
    }
  }
}
