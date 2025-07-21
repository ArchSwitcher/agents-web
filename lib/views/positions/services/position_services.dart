import 'dart:convert';

import 'package:agents_app/models/position/position_model.dart';
import 'package:agents_app/services/base_service.dart';
import 'package:agents_app/services/crud_service.dart';
import 'package:agents_app/services/toast_service.dart';
import 'package:http/http.dart' as http;

class PositionServices extends BaseService
    implements CrudService<PositionModel> {
  @override
  Future<List<PositionModel>> getAll(dynamic statusType) async {
    final response = await http.get(
      Uri.parse('$baseUrl/position/getPositionStatusTypeById/$statusType'),
      headers: buildHeaders(),
    );

    try {
      if (response.statusCode == 200) {
        final decoded = json.decode(response.body);
        final List data = decoded['data'];
        return data.map((json) => PositionModel.fromJson(json)).toList();
      } else {
        throw Exception('Error al cargar posiciones: ${response.statusCode}');
      }
    } catch (e) {
      print("objects: error ---- $e");
      throw Exception('Error al cargar posiciones: $e');
    }
  }

  @override
  Future<PositionModel> getById(String id) async {
    final response = await http.get(
      Uri.parse('$baseUrl/position/getOnePositionStatusTypeById/$id'), //missing
      headers: buildHeaders(),
    );

    print("getById position: response ---- ${response.body}");

    if (response.statusCode == 200) {
      final data = json.decode(response.body)['data'];
      return PositionModel.fromJson(data);
    } else {
      // ToastService.error(
      //   title: "Posición",
      //   subTitle: "Error al cargar posición",
      // );
      throw Exception('Posición no encontrada');
    }
  }

  @override
  Future<bool> create(PositionModel item) async {
    final response = await http.post(
      Uri.parse("$baseUrl/position/createPosition"),
      headers: buildHeaders(),
      body: jsonEncode(item.toJson()),
    );

    print("objects ----############ ---- ${item.toJson()}");

    if (response.statusCode == 200) {
      ToastService.success(
        title: "Posición",
        subTitle: "Posición creada correctamente",
      );
      return true;
    } else {
      ToastService.error(
        title: "Posición",
        subTitle: "Error al crear posición",
      );
      throw Exception('Error al crear posición');
    }
  }

  @override
  Future<bool> update(String id, PositionModel item) async {
    final response = await http.put(
      Uri.parse("$baseUrl/position/updatePosition/$id"), //missing
      headers: buildHeaders(),
      body: jsonEncode(item.toJson()),
    );

    if (response.statusCode == 200) {
      ToastService.success(
        title: "Posición",
        subTitle: "Posición actualizada correctamente",
      );
      return true;
    } else {
      ToastService.error(
        title: "Posición",
        subTitle: "Error al actualizar posición",
      );
      throw Exception('Error al actualizar posición');
    }
  }

  @override
  Future<bool> delete(String id) async {
    final response = await http.delete(
      Uri.parse("$baseUrl/position/deletePositionById/$id"),
      headers: buildHeaders(),
    );

    if (response.statusCode == 200) {
      ToastService.success(
        title: "Posición",
        subTitle: "Posición eliminada correctamente",
      );
      return true;
    } else {
      ToastService.error(
        title: "Posición",
        subTitle: "Error al eliminar posición",
      );
      throw Exception('Error al eliminar posición');
    }
  }

  Future<List<PositionModel>> getAllPositionsByBranchId(String branchId) async {
    final response = await http.get(
      Uri.parse('$baseUrl/position/getPositionsByBranch/$branchId'),
      headers: buildHeaders(),
    );

    print("objects: response ---- ${response.body}");

    if (response.statusCode == 200) {
      final decoded = json.decode(response.body);
      final List data = decoded['data'];
      return data.map((json) => PositionModel.fromJson(json)).toList();
    } else {
      print("objects: error ---- ${response.statusCode}");
      throw Exception('Error al cargar posiciones de la sucursal');
    }
  }

  Future<List<PositionModel>> getAllPositionsByAgentId(String agentId) async {
    final response = await http.get(
      Uri.parse('$baseUrl/position/getPositionsByEmployeeId/$agentId'),
      headers: buildHeaders(),
    );

    try {
      if (response.statusCode == 200) {
        final decoded = json.decode(response.body);
        final List data = decoded['data'];
        return data.map((json) => PositionModel.fromJson(json)).toList();
      } else {
        throw Exception('Error al cargar posiciones--: ${response.statusCode}');
      }
    } catch (e) {
      print("objects: error ---- $e");
      throw Exception('Error al cargar posiciones: $e');
    }
  }
}
