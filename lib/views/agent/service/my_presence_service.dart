import 'package:agents_app/models/presence/presence_model.dart';
import 'package:agents_app/services/base_service.dart';
import 'package:agents_app/services/crud_service.dart';

class MyPresenceService extends BaseService
 implements CrudService<PresenceModel>  {
  @override
  Future<List<PresenceModel>> getAll(dynamic value) {
    // TODO: implement getAll
    throw UnimplementedError();
  }

  @override
  Future<PresenceModel> getById(String id) {
    // TODO: implement getById
    throw UnimplementedError();
  }

  @override
  Future<bool> create(PresenceModel model) {
    // TODO: implement create
    throw UnimplementedError();
  }

  @override
  Future<bool> update(String id, PresenceModel model) {
    // TODO: implement update
    throw UnimplementedError();
  }

  @override
  Future<bool> delete(String id) {
    // TODO: implement delete
    throw UnimplementedError();
  }
}
