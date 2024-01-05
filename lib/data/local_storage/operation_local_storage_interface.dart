import 'package:finplan24/data/data.dart';

abstract interface class OperationLocalStorageInterface {
  Stream<List<OperationDto>> getOperations();
  Future<List<OperationDto>> searchOperations(String searchWord);
  Future<void> addOperation(OperationDto operation);
  Future<void> updateOperation(OperationDto operation);
  Future<void> deleteOperation(OperationDto operationDto);
}

class OperationNotFoundException implements Exception {}
