import 'package:equatable/equatable.dart';
import 'package:finplan24/domain/domain.dart';
import 'package:json_annotation/json_annotation.dart';
import 'package:uuid/uuid.dart';

part 'plan.g.dart';

@JsonSerializable()
class Plan extends Equatable {
  Plan({
    required this.date,
    required this.type,
    required this.category,
    required this.sum,
    required this.note,
    String? id,
  }) : id = id ?? const Uuid().v4();

  final String id;
  @TypeConverter()
  final Type type;
  final String category;
  final int sum;
  final DateTime date;
  final String note;

  Plan copyWith({
    String? id,
    Type? type,
    String? category,
    int? sum,
    DateTime? date,
    String? note,
  }) {
    return Plan(
      id: id ?? this.id,
      type: type ?? this.type,
      category: category ?? this.category,
      sum: sum ?? this.sum,
      date: date ?? this.date,
      note: note ?? this.note,
    );
  }

  static Plan fromJson(Map<String, dynamic> json) => _$PlanFromJson(json);

  Map<String, dynamic> toJson() => _$PlanToJson(this);

  @override
  List<Object> get props => [id, type, category, sum, date, note];
}