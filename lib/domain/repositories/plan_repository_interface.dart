import 'package:finplan24/domain/domain.dart';

abstract interface class PlansRepository {
  Stream<Future<List<Plan>>> getPlans();
  Future<void> addPlan(Plan plan);
  Future<void> updatePlan(Plan plan);
  Future<void> deletePlan(String planId);
}
