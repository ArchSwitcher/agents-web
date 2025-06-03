import 'package:http/http.dart' as http;
import 'dart:convert';

import '../models/agent_model.dart';

class AgentService {
  // Cambia esta URL a la correcta según tu IP/localhost
  static const String _baseUrl = 'http://192.168.100.36';

  static Future<AgentData?> fetchAgentData(int userId) async {
    try {
      final response =
          await http.get(Uri.parse("${_baseUrl}/agents/by-user/${userId}"));

      if (response.statusCode == 200) {
        final jsonMap = jsonDecode(response.body);
        return AgentData.fromJson(jsonMap);
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
