import 'dart:convert';
import 'package:agents_app/models/client/clients_model.dart';
import 'package:agents_app/services/base_service.dart';
import 'package:agents_app/services/crud_service.dart';
import 'package:agents_app/services/toast_service.dart';
import 'package:http/http.dart' as http;

class ClientService extends BaseService implements CrudService<ClientModel> {
  @override
  Future<List<ClientModel>> getAll() async {
    final response = await http.get(
      Uri.parse('$baseUrl/client/getClients'),
      headers: buildHeaders(),
    );

    if (response.statusCode == 200) {
      final decoded = json.decode(response.body);
      final List data = decoded['data'];
      return data.map((json) => ClientModel.fromJson(json)).toList();
    } else {
      ToastService.warning(
          title: "No hay clientes", subTitle: "No existe ningún cliente aún.");
      throw Exception('Error al cargar clientes');
    }
  }

  @override
  Future<ClientModel> getById(String id) async {
    final response = await http.get(
      Uri.parse('$baseUrl/client/$id'),
      headers: buildHeaders(),
    );

    if (response.statusCode == 200) {
      final data = json.decode(response.body)['data'];
      return ClientModel.fromJson(data);
    } else {
      throw Exception('Cliente no encontrado');
    }
  }

  @override
  Future<bool> create(ClientModel client) async {
    final response = await http.post(
      Uri.parse("$baseUrl/client/createClient"),
      headers: buildHeaders(),
      body: jsonEncode(client.toJson()),
    );

    if (response.statusCode == 200) {
      ToastService.success(title: "Cliente creado", subTitle: "Éxito");
      return true;
    } else {
      ToastService.error(title: "Error", subTitle: "No se pudo crear");
      return false;
    }
  }

  @override
  Future<bool> update(String id, ClientModel client) async {
    final response = await http.put(
      Uri.parse('$baseUrl/client/$id'),
      headers: buildHeaders(),
      body: jsonEncode(client.toJson()),
    );

    if (response.statusCode == 200) {
      ToastService.success(title: "Actualizado", subTitle: "Cliente actualizado");
      return true;
    } else {
      ToastService.error(title: "Error", subTitle: "No se pudo actualizar");
      return false;
    }
  }

  @override
  Future<bool> delete(String id) async {
    final response = await http.delete(
      Uri.parse('$baseUrl/client/$id'),
      headers: buildHeaders(),
    );

    if (response.statusCode == 200) {
      ToastService.success(title: "Eliminado", subTitle: "Cliente eliminado");
      return true;
    } else {
      ToastService.error(title: "Error", subTitle: "No se pudo eliminar");
      return false;
    }
  }
}
