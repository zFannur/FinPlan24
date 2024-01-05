import 'package:finplan24/data/data.dart';
import 'package:finplan24/domain/domain.dart';

class Converter {
  static Operation fromDto(OperationDto dto) {
    return Operation(
      id: dto.id,
      type: const TypeConverter().fromJson(dto.type),
      category: dto.category,
      sum: dto.sum,
      subCategory: dto.subCategory,
      note: dto.note,
    );
  }
  static OperationDto toDto(Operation operation) {
    return OperationDto(
      operation.id,
      const TypeConverter().toJson(operation.type),
      operation.category,
      operation.sum,
      operation.subCategory,
      operation.note,
    );
  }
}
