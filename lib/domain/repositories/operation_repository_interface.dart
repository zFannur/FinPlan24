import 'package:finplan24/domain/domain.dart';

abstract interface class OperationsRepositoryInterface {
  Stream<List<Operation>> getOperations();
  Future<List<Operation>> searchOperations(String searchWord);
  Future<void> addOperation(Operation operation);
  Future<void> updateOperation(Operation operation);
  Future<void> deleteOperation(Operation operation);
}
