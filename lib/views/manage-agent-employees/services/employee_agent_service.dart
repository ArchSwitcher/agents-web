
import 'package:agents_app/models/employee/employee_model.dart';
import 'package:agents_app/services/base_service.dart';
import 'package:agents_app/services/crud_service.dart';


class EmployeeAgentService extends BaseService implements CrudService<dynamic> {
  @override
  Future<bool> create(dynamic model) async {
    throw UnimplementedError('create method is not implemented');
  }

  @override
  Future<EmployeeModel> getById(String id) async {
    throw UnimplementedError('read method is not implemented');
  }

  @override
  Future<List<EmployeeModel>> getAll(dynamic value) async {
    throw UnimplementedError('getAll method is not implemented');
  }

  @override
  Future<bool> update(String id, dynamic model) async {
    throw UnimplementedError('update method is not implemented');
  }

  @override
  Future<bool> delete(String id) async {
    throw UnimplementedError('delete method is not implemented');
  }
}
