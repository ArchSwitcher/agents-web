import 'dart:convert';

import 'package:agents_app/controllers/globals.dart';
import 'package:agents_app/models/client/clients_model.dart';
import 'package:agents_app/services/config.dart';
import 'package:agents_app/services/toast_service.dart';
import 'package:http/http.dart' as http;
import 'package:get/get.dart';

class ClientService {


  Map<String, String> _buildHeaders() {
    final authController = Get.find<SessionController>();
    return {
      'Authorization': 'bearer ${authController.getToken}',
      'Content-Type': 'application/json',
    };
  }

  Future<bool> newClient(ClientModel client) async {
    try {
      final response = await http.post(
        Uri.parse("${Config.endPointBaseUrl}/client/createClient"),
        headers: _buildHeaders(),
        body: jsonEncode({
          'name': client.name,
          'email': client.email,
          'phone': client.phone,
          'url': client.url,
          'groupId': client.group.id,
          'adminId': '1', // Assuming adminId is always 1 for now database should be updated
        }),
      );

      if (response.statusCode == 200) {
        ToastService.success(
            title: "Cliente creado", subTitle: "cliente creado con éxito.");
        return true;
      } else {
        print('Error: Código ${response.statusCode}');
        ToastService.error(
            title: "Cliente no creado",
            subTitle: "Por favor verifique que el cliente no este creado.");
        return false;
      }
    } catch (e) {
      ToastService.error(
          title: "Cliente no creado",
          subTitle: "Algo salio mal con la creación.");
      return false;
    }
  }

  Future<List<ClientModel>> fetchClients() async {
    final response = await http.get(Uri.parse('${Config.endPointBaseUrl}/client/getClients'),
        headers: _buildHeaders());

    if (response.statusCode == 200) {
      final decoded = json.decode(response.body);
      print("Response body: ${response.body}");
      final List<dynamic> data = decoded['data'];
      print("Data---------: $data");
      return data.map((json) => ClientModel.fromJson(json)).toList();
    } else {
      ToastService.warning(
          title: "No hay clientes", subTitle: "No existe ningún cliente aun.");
      throw Exception('Error al cargar clientes');
    }
  }

  Future<bool> updateClient(ClientModel client) async {
    try {
      print("objects: ${client.toJson()}");

      final response = await http.put(
        Uri.parse("${Config.endPointBaseUrl}/client/${client.id}"),
        headers: _buildHeaders(),
        body: jsonEncode({
          'name': client.name,
          'email': client.email,
          'phone': client.phone,
          'url': client.url,
          'groupId': client.group.id,
          'adminId': '1', // Assuming adminId is always 1 for now database should be updated
        }),
      );

      if (response.statusCode == 200) {
        ToastService.success(
          title: "Ciente actualizado",
          subTitle: "Cliente actualizado con éxito.",
        );
        return true;
      } else {
        print('Error: Código ${response.statusCode}');
        ToastService.error(
          title: "Error al actualizar",
          subTitle: "Verifica que el cliente exista.",
        );
        return false;
      }
    } catch (e) {
      ToastService.error(
        title: "Error de red",
        subTitle: "Algo salió mal al actualizar.",
      );
      return false;
    }
  }

  Future<bool> deleteClient(String id) async {
    try {
      final response = await http.delete(
        Uri.parse("${Config.endPointBaseUrl}/client/$id"),
        headers: _buildHeaders(),
      );

      if (response.statusCode == 200) {
        ToastService.success(
          title: "Cliente eliminado",
          subTitle: "Cliente eliminado correctamente.",
        );
        return true;
      } else {
        print('Error: Código ${response.statusCode}');
        ToastService.error(
          title: "Error al eliminar",
          subTitle: "El cliente no se pudo eliminar.",
        );
        return false;
      }
    } catch (e) {
      ToastService.error(
        title: "Error de red",
        subTitle: "Algo salió mal al eliminar.",
      );
      return false;
    }
  }
}
