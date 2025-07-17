import 'dart:convert';
import 'package:agents_app/controllers/globals.dart';
import 'package:agents_app/models/group/groups_model.dart';
import 'package:agents_app/services/config.dart';
import 'package:agents_app/services/toast_service.dart';
import 'package:get/get.dart';
import 'package:http/http.dart' as http;

class GroupService implements ToastService {
  static Future<bool> newGroup(String name) async {
    final authController = Get.find<SessionController>();
    try {
      final response = await http.post(
        Uri.parse("${Config.endPointBaseUrl}/group/createGroups"),
        headers: {
          'Authorization': 'bearer ${authController.getToken}',
          'Content-Type': 'application/json',
        },
        body: jsonEncode({'name': name}),
      );

      if (response.statusCode == 200) {
        ToastService.success(
            title: "Grupo creado", subTitle: "Grupo creado con éxito.");
        return true;
      } else {
        print('Error: Código ${response.statusCode}');
        ToastService.error(
            title: "Grupo no creado",
            subTitle: "Por favor verifique que el grupo no este creado.");
        return false;
      }
    } catch (e) {
      ToastService.error(
          title: "Grupo no creado",
          subTitle: "Algo salio mal con la creación.");
      return false;
    }
  }

  static Future<List<GroupsModel>> fetchGroups() async {
    final authController = Get.find<SessionController>();
    final response =
        await http.get(Uri.parse('${Config.endPointBaseUrl}/group/getGroups?page=1&limit=99999'), headers: {
      'Authorization': 'bearer ${authController.getToken}',
      'Content-Type': 'application/json',
    });

    if (response.statusCode == 200) {
      final decoded = json.decode(response.body);
      final List<dynamic> data = decoded['data'];
      return data.map((json) => GroupsModel.fromJson(json)).toList();
    } else {
      ToastService.warning(
          title: "No hay grupos", subTitle: "No existe ningún grupo aun.");
      throw Exception('Error al cargar grupos');
    }
  }

  static Future<bool> updateGroup(String id, String name) async {
    final authController = Get.find<SessionController>();
    try {
      final response = await http.put(
        Uri.parse("${Config.endPointBaseUrl}/group/$id"),
        headers: {
          'Authorization': 'bearer ${authController.getToken}',
          'Content-Type': 'application/json',
        },
        body: jsonEncode({'name': name}),
      );

      if (response.statusCode == 200) {
        ToastService.success(
          title: "Grupo actualizado",
          subTitle: "Grupo actualizado con éxito.",
        );
        return true;
      } else {
        print('Error: Código ${response.statusCode}');
        ToastService.error(
          title: "Error al actualizar",
          subTitle: "Verifica que el grupo exista.",
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

  static Future<bool> deleteGroup(String id) async {
    final authController = Get.find<SessionController>();
    try {
      final response = await http.delete(
        Uri.parse("${Config.endPointBaseUrl}/group/$id"),
        headers: {
          'Authorization': 'bearer ${authController.getToken}',
          'Content-Type': 'application/json',
        },
      );

      if (response.statusCode == 200) {
        ToastService.success(
          title: "Grupo eliminado",
          subTitle: "Grupo eliminado correctamente.",
        );
        return true;
      } else {
        print('Error: Código ${response.statusCode}');
        ToastService.error(
          title: "Error al eliminar",
          subTitle: "El grupo no se pudo eliminar.",
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
