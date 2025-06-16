abstract class CrudService<T> {
  Future<List<T>> getAll();
  Future<T> getById(String id);
  Future<bool> create(T item);
  Future<bool> update(String id, T item);
  Future<bool> delete(String id);
}
