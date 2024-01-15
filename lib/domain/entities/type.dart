import 'package:json_annotation/json_annotation.dart';

enum Type {
  expense,
  income,
}

class TypeConverter extends JsonConverter<Type, String> {
  const TypeConverter();

  @override
  Type fromJson(String json) {
    final result = switch(json) {
      'expense' => Type.expense,
      'income' => Type.income,
      'Расход' => Type.expense,
      'Доход' => Type.income,
      String() => Type.expense,
    };
    return result;
  }

  @override
  String toJson(Type type) {
    return type.name;
  }
}
