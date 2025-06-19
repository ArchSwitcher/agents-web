import 'dart:convert';

import 'package:agents_app/models/common/generic_list_model.dart';
import 'package:agents_app/services/base_service.dart';
import 'package:http/http.dart' as http;

class GenericListService extends BaseService {
  Future<List<GenericListModel>> getAll(String service) async {
    final response =
        await http.get(Uri.parse('$baseUrl/$service'), headers: buildHeaders());

    if (response.statusCode == 200) {
      final decoded = json.decode(response.body);
      final List data = decoded['data'];
      return data.map((json) => GenericListModel.fromJson(json)).toList();
    } else {
      throw Exception('Failed to load data');
    }
  }
}
