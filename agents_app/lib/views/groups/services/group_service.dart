import 'dart:convert';
import 'package:agents_app/services/config.dart';
import 'package:http/http.dart' as http;

class GroupService {
  static Future<bool?> newGroup(int userId) async {
    try {
      final response = await http
          .get(Uri.parse("${Config.endPointBaseUrl}/agents/by-user/${userId}"));

      if (response.statusCode == 200) {
        //final jsonMap = jsonDecode(response.body);
        return true;
      } else {
        print('Error: Código ${response.statusCode}');
        return null;
      }
    } catch (e) {
      print('Error al obtener datos de agentes: $e');
      return null;
    }
  }
}
