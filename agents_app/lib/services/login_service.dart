import 'package:agents_app/models/session_model.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';

Future<UserData?> loginUser(String username, String password) async {
  final url = Uri.parse('http://192.168.100.36/auth/login'); // Reemplaza con tu IP local

  try {
    final response = await http.post(
      url,
      headers: {'Content-Type': 'application/json'},
      body: jsonEncode({'username': username, 'password': password}),
    );

    if (response.statusCode == 200) {
      final decodedJson = jsonDecode(response.body);
      print(decodedJson);
      final loginResponse = SessionResponse.fromJson(decodedJson);
      print(loginResponse);
      return loginResponse.data; // Retorna el UserData
    } else {
      return null;
    }
  } catch (e) {
    print('Error al conectarse con la API: $e');
    return null;
  }
}