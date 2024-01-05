import 'package:finplan24/data/data.dart';

abstract interface class PlansLocalStorageInterface {
  Stream<Future<List<PlanDto>>> getPlans();
  Future<List<PlanDto>> searchPlans();
  Future<void> addPlan(PlanDto plan);
  Future<void> updatePlan(PlanDto plan);
  Future<void> deletePlan(String planId);
}