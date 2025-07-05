import 'dart:convert';

import 'package:agents_app/models/common/dropdown_option_model.dart';
import 'package:agents_app/models/common/employee_list_model.dart';
import 'package:agents_app/services/base_service.dart';
import 'package:http/http.dart' as http;

class EmployeeDropdownService extends BaseService {
  Future<List<DropDownOption>> fetchEmployees(String type) async {
   try {
      final response =
        await http.get(Uri.parse('$baseUrl/common/getEmployeeByType?type=$type'));

    if (response.statusCode == 200) {
      final decoded = json.decode(response.body);
      final List data = decoded['data'];
      final employeeList =
          data.map((json) => EmployeeModel.fromJson(json)).toList();
      return employeeList
          .map((e) => DropDownOption(
              id: e.id.toString(),
              label: '${e.person.firstName} ${e.person.lastName}'))
          .toList();
    } else {
      return [];
    }
   } catch (e) {
     print("Error fetching employees: $e");
     return [];
   }
  }
}
