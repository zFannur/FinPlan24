import 'package:realm/realm.dart';

part 'categories.g.dart';

enum CategoryType {
  category,
  subCategory,
}

@RealmModel()
class _Category {
  @PrimaryKey()
  late String id; // Идентификатор категории

  late String name; // Название категории
}

@RealmModel()
class _SubCategory {
  @PrimaryKey()
  late String id; // Идентификатор субкатегории

  late String name; // Название субкатегории
  late _Category? category; // Ссылка на категорию
}
