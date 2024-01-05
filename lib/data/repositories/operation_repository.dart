import 'package:finplan24/data/data.dart';
import 'package:finplan24/domain/domain.dart';

class OperationsRepository implements OperationsRepositoryInterface {
  OperationsRepository(OperationLocalStorageInterface localStorage)
      : _localStorage = localStorage;

  final OperationLocalStorageInterface _localStorage;

  @override
  Stream<List<Operation>> getOperations() {
    return _localStorage.getOperations().map((list) {
      return list.map<Operation>(Converter.fromDto).toList();
    });
  }

  @override
  Future<List<Operation>> searchOperations(String searchWord) {
    return _localStorage
        .searchOperations(searchWord)
        .then((list) => list.map<Operation>(Converter.fromDto).toList());
  }

  @override
  Future<void> addOperation(Operation operation) {
    return _localStorage.addOperation(Converter.toDto(operation));
  }

  @override
  Future<void> updateOperation(Operation operation) {
    return _localStorage.updateOperation(Converter.toDto(operation));
  }

  @override
  Future<void> deleteOperation(Operation operation) {
    return _localStorage.deleteOperation(Converter.toDto(operation));
  }
}
