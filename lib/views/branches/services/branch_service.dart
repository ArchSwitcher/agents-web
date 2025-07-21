import 'dart:convert';

import 'package:agents_app/models/branch/branch_index_model.dart';
import 'package:agents_app/services/base_service.dart';
import 'package:agents_app/services/crud_service.dart';
import 'package:agents_app/services/toast_service.dart';
import 'package:http/http.dart' as http;

class BranchService extends BaseService implements CrudService<BranchModel> {
  @override
  Future<List<BranchModel>> getAll(dynamic value) async {
    final response = await http.get(
      Uri.parse('$baseUrl/branch?page=1&limit=100'),
      headers: buildHeaders(),
    );

    try {
      if (response.statusCode == 200) {
        final decoded = json.decode(response.body);
        final List data = decoded['branches'];
        print("objects: data BRANCH---- ${decoded["branches"]}");
        return data.map((json) => BranchModel.fromJson(json)).toList();
      } else {
        throw Exception('Error al cargar sucursales');
      }
    } catch (e) {
      print("objects: error ---- ${e.toString()}");
      throw Exception('Error al cargar sucursales: $e');
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
      ToastService.error(
        title: "Sucursal",
        subTitle: "Error al cargar sucursal",
      );
      throw Exception('Sucursal no encontrada');
    }
  }

  @override
  Future<bool> create(BranchModel item) async {
    final response = await http.post(
      Uri.parse("$baseUrl/branch"),
      headers: buildHeaders(),
      body: jsonEncode(item.toJson()),
    );

    print("objects: response ---- ${item.toJson()}");

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
  Future<bool> update(String id, BranchModel item) async {
    try {
      print("objects: response $id ---- ${jsonEncode(item.toJson())}");
      final response = await http.put(
        Uri.parse("$baseUrl/branch/$id"),
        headers: buildHeaders(),
        body: jsonEncode(item.toJson()),
      );
      print("objects: response ${response.statusCode} ");

      if (response.statusCode == 200) {
        ToastService.success(
          title: "Sucursal",
          subTitle: "Sucursal actualizada correctamente",
        );
        return true;
      } else if (response.statusCode == 409) {
        ToastService.error(
          title: "Turnos",
          subTitle: "El turno ya esta asociado a un agente",
        );
        throw Exception(
            "Verifique que el turno no esta asociado a un agente para poder eliminarlo");
      } else {
        ToastService.error(
          title: "Sucursal",
          subTitle: "Error al actualizar sucursal",
        );
        throw Exception('Error al actualizar sucursal');
      }
    } catch (e) {
      print("objects: error ---- $e");
      return false;
    }
  }

  @override
  Future<bool> delete(String id) async {
    final response = await http.delete(
      Uri.parse("$baseUrl/branch/deleteBranch/$id"),
      headers: buildHeaders(),
    );

    if (response.statusCode == 200) {
      ToastService.success(
        title: "Sucursal",
        subTitle: "Sucursal eliminada correctamente",
      );
      return true;
    } else {
      ToastService.error(
        title: "Sucursal",
        subTitle: "Error al eliminar sucursal",
      );
      throw Exception('Error al eliminar sucursal');
    }
  }

  Future<List<BranchModel>> getAllPagination(String page, String limit) async {
    final response = await http.get(
      Uri.parse('$baseUrl/branch?page=$page&limit=9999'),
      headers: buildHeaders(),
    );

    try {
      if (response.statusCode == 200) {
        final decoded = json.decode(response.body);
        final List data = decoded['branches'];
        print("objects: data BRANCH---- ${decoded["branches"]}");
        return data.map((json) => BranchModel.fromJson(json)).toList();
      } else {
        throw Exception('Error al cargar sucursales');
      }
    } catch (e) {
      print("objects: error ---- ${e.toString()}");
      throw Exception('Error al cargar sucursales: $e');
    }
  }

  Future<List<BranchModel>> searchByKeyword(String? branchName, String? clientName, String? groupName) async {

    final response = await http.get(
      Uri.parse('$baseUrl/branch/searchBranch?branchName=${branchName ?? ''}&clientName=${clientName ?? ''}&groupName=${groupName ?? ''}'),
      headers: buildHeaders(),
    );

    try {
      if (response.statusCode == 200) {
        final decoded = json.decode(response.body);
        final List data = decoded['branches'];
        print("objects: data BRANCH---- ${decoded["branches"]}");
        return data.map((json) => BranchModel.fromJson(json)).toList();
      } else {
        throw Exception('Error al cargar sucursales');
      }
    } catch (e) {
      print("objects: error ---- ${e.toString()}");
      throw Exception('Error al cargar sucursales: $e');
    }
  }
}
