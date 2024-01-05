import 'package:finplan24/domain/domain.dart';

abstract interface class PlansRepositoryInterface {
  Stream<Future<List<Plan>>> getPlans();
  Future<List<Plan>> searchOperations();
  Future<void> addPlan(Plan plan);
  Future<void> updatePlan(Plan plan);
  Future<void> deletePlan(String planId);
}
