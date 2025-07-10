import 'dart:convert';

import 'package:agents_app/models/presence/presence_model.dart';
import 'package:agents_app/services/base_service.dart';
import 'package:agents_app/services/crud_service.dart';
import 'package:http/http.dart' as http;


class PresenceService extends BaseService
    implements CrudService<PresenceModel> {
  @override
  Future<List<PresenceModel>> getAll(dynamic value) async {
    
    print("Fetching presence data for: $value");
    final response = await http.get(
      // employeeId/positionId
      Uri.parse('$baseUrl/employee/presence/$value'),
      headers: buildHeaders(),
    );

    try {
      if (response.statusCode == 200) {
        final decoded = json.decode(response.body);
        final List data = decoded['data'];
        return data.map((json) => PresenceModel.fromJson(json)).toList();
      } else {
        throw Exception('Error al cargar contactos de sucursales');
      }
    } catch (e) {
      print("objects: error ---- $e");
      throw Exception('Error al cargar contactos de sucursales: $e');
    }
  }

  @override
  Future<PresenceModel> getById(String id) async {
    // Implement the logic to fetch a presence record by ID
    throw UnimplementedError('getById method not implemented');
  }

  @override
  Future<bool> create(PresenceModel item) async {
    // Implement the logic to create a new presence record
    throw UnimplementedError('create method not implemented');
  }

  @override
  Future<bool> update(String id, PresenceModel item) async {
    // Implement the logic to update an existing presence record
    throw UnimplementedError('update method not implemented');
  }

  @override
  Future<bool> delete(String id) async {
    // Implement the logic to delete a presence record
    throw UnimplementedError('delete method not implemented');
  }
}
