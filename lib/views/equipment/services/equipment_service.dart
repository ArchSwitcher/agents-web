import 'dart:convert';

import 'package:agents_app/models/equipment/equipment_asigment_model.dart';
import 'package:agents_app/services/base_service.dart';
import 'package:agents_app/services/crud_service.dart';
import 'package:http/http.dart' as http;

class EquipmentService extends BaseService
    implements CrudService<EquipmentModel> {
  @override
  Future<List<EquipmentModel>> getAll(dynamic value) async {

    final response = await http.get(
      Uri.parse('$baseUrl/equipment/equipment?page=1&limit=99999'),
      headers: buildHeaders(),
    );
    // print("objects: response ---- ${response.statusCode}");
    try {
      if (response.statusCode == 200) {
        final decoded = json.decode(response.body);
        final List data = decoded['data'];
        return data
            .map((json) => EquipmentModel.fromJson(json))
            .toList();
      } else {
        return [];
      }
    } catch (e) {
      print("objects: error ---- ${e.toString()}");
      throw Exception('Error al cargar sucursales: $e');
    }
  }

  @override
  Future<EquipmentModel> getById(String id) async {
    // Implement the logic to fetch a specific equipment assignment by ID
    throw UnimplementedError("getById method not implemented");
  }

  @override
  Future<bool> create(EquipmentModel data) async {
    // Implement the logic to create a new equipment assignment
    throw UnimplementedError("create method not implemented");
  }

  @override
  Future<bool> update(String id, dynamic data) async {
    // Implement the logic to update an existing equipment assignment
    throw UnimplementedError("update method not implemented");
  }

  @override
  Future<bool> delete(String id) async {
    // Implement the logic to delete an equipment assignment by ID
    throw UnimplementedError("delete method not implemented");
  }
}
