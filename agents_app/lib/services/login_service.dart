import 'package:http/http.dart' as http;
import 'dart:convert';

Future<bool> loginUser(String username, String password) async {
  final url = Uri.parse('http://192.168.100.36/auth/login'); // Reemplaza con tu IP local

  try {
    final response = await http.post(
      url,
      headers: {'Content-Type': 'application/json'},
      body: jsonEncode({'username': username, 'password': password}),
    );

    if (response.statusCode == 200) {
      // Puedes ajustar esta validación según la estructura de respuesta de tu API
      return true;
    } else {
      return false;
    }
  } catch (e) {
    print('Error al conectarse con la API: $e');
    return false;
  }
}