import 'package:realm/realm.dart';

part 'plan_dto.g.dart';

@RealmModel()
class _PlanDto {
  @PrimaryKey()
  late String id;
  late String type;
  late String category;
  late int sum;
  late DateTime date;
  late String note;
}