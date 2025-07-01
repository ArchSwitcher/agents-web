import 'dart:convert';

import 'package:agents_app/services/base_service.dart';
import 'package:http/http.dart' as http;

typedef FromJson<T> = T Function(Map<String, dynamic>);

class GenericListService extends BaseService {
  Future<List<T>> getAll<T>(String service, FromJson<T> fromJson) async {
    final response = await http.get(
      Uri.parse('$baseUrl/$service'),
      headers: buildHeaders(),
    );

    if (response.statusCode == 200) {
      final decoded = json.decode(response.body);
      final List data = decoded['data'];
      return data.map((json) => fromJson(json)).toList();
    } else {
      throw Exception('Failed to load data');
    }
  }
}

