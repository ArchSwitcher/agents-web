import 'package:agents_app/services/config.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';

import '../models/agent_model.dart';

class AgentService {
  
  static Future<AgentData?> fetchAgentData(int userId) async {
    try {
      final response =
          await http.get(Uri.parse("${Config.endPointBaseUrl}/agents/by-user/${userId}"));

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
