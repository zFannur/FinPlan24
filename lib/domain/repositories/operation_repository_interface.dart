import 'package:finplan24/domain/domain.dart';

abstract interface class OperationsRepository {
  Stream<Future<List<Operation>>> getOperations();
  Future<void> addOperation(Operation operation);
  Future<void> updateOperation(Operation operation);
  Future<void> deleteOperation(String operationId);
}
