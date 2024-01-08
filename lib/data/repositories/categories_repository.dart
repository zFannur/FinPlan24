import 'package:finplan24/domain/domain.dart';
import 'package:realm/realm.dart';

class RealmRepository<T extends RealmObject>
    implements IGenericCategoriesRepository<T> {
  RealmRepository(Realm realm) : _realm = realm;

  final Realm _realm;

  @override
  void add(T item) {
    _realm.write(() {
      _realm.add(item);
    });
  }

  @override
  void update(T item) {
    _realm.write(() {
      _realm.add(item, update: true);
    });
  }

  @override
  void delete(String item) {
    _realm.write(() {
      // Ищем операцию по ее id
      final category = _realm.find<T>(item);

      // Проверяем, что операция с таким id существует
      if (category != null) {
        // Удаляем операцию из базы данных
        _realm.delete(category);
      }
    });
  }

  @override
  List<T> getAll() {
    return _realm.all<T>().toList();
  }

  @override
  void clear() {
    _realm.write(() {
      // Удаляем все объекты типа T из Realm
      _realm.deleteAll<T>();
    });
  }

  @override
  void addAll(List<T> item) {
    _realm.write(() {
      _realm.addAll(item);
    });
  }
}
