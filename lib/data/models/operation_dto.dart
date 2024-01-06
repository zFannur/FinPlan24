import 'package:realm/realm.dart';

part 'operation_dto.g.dart';

@RealmModel()
class _OperationDto {
  @PrimaryKey()
  late String id;
  late DateTime date;
  late String type;
  late String category;
  late int sum;
  late String subCategory;
  late String note;
}
