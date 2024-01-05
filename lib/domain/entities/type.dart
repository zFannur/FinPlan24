import 'package:json_annotation/json_annotation.dart';

enum Type {
  expense,
  income,
}

class TypeConverter extends JsonConverter<Type, String> {
  const TypeConverter();

  @override
  Type fromJson(String json) {
    return json == 'expense' ? Type.expense : Type.income;
  }

  @override
  String toJson(Type type) {
    return type.toString();
  }
}
