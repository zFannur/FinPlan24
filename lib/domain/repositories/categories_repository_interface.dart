import 'package:realm/realm.dart';

abstract interface class IGenericCategoriesRepository<T extends RealmObject> {
  void add(T item);
  void addAll(List<T> item);
  void update(T item);
  void delete(String item);
  void clear();
  List<T> getAll();
}
