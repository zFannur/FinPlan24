import 'package:equatable/equatable.dart';
import 'package:finplan24/domain/domain.dart';
import 'package:json_annotation/json_annotation.dart';
import 'package:uuid/uuid.dart';

part 'operation.g.dart';

@JsonSerializable()
class Operation extends Equatable {
  Operation({
    required this.type,
    required this.date,
    required this.category,
    required this.sum,
    required this.subCategory,
    required this.note,
    String? id,
  }) : id = id ?? const Uuid().v4();

  final String id;
  final DateTime date;
  @TypeConverter()
  final Type type;
  final String category;
  final int sum;
  final String subCategory;
  final String note;

  Operation copyWith({
    String? id,
    DateTime? date,
    Type? type,
    String? category,
    int? sum,
    String? subCategory,
    String? note,
  }) {
    return Operation(
      id: id ?? this.id,
      date: date ?? this.date,
      type: type ?? this.type,
      category: category ?? this.category,
      sum: sum ?? this.sum,
      subCategory: subCategory ?? this.subCategory,
      note: note ?? this.note,
    );
  }

  static Operation fromJson(Map<String, dynamic> json) =>
      _$OperationFromJson(json);

  Map<String, dynamic> toJson() => _$OperationToJson(this);

  @override
  List<Object> get props => [id, type, category, sum, subCategory, note];
}
