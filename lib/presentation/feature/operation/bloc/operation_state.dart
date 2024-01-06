part of 'operation_bloc.dart';

enum OperationStatus { initial, loading, success, failure }

final class OperationState extends Equatable {
  const OperationState({
    this.status = OperationStatus.initial,
    this.operations = const [],
    this.filter = OperationViewFilter.all,
    this.searchWord,
    this.error,
    this.foundOperations = const [],
  });

  final OperationStatus status;
  final List<Operation> operations;
  final OperationViewFilter filter;
  final String? searchWord;
  final String? error;
  final List<Operation> foundOperations;

  List<OperationsFiltered> get filteredOperations =>
      OperationsFiltered.sortByDay(operations);

  OperationState copyWith({
    OperationStatus Function()? status,
    List<Operation> Function()? operations,
    OperationViewFilter Function()? filter,
    String Function()? searchWord,
    String Function()? error,
    List<Operation> Function()? foundOperations,
  }) {
    return OperationState(
      status: status != null ? status() : this.status,
      operations: operations != null ? operations() : this.operations,
      filter: filter != null ? filter() : this.filter,
      searchWord: searchWord != null ? searchWord() : this.searchWord,
      error: error != null ? error() : this.error,
      foundOperations:
          foundOperations != null ? foundOperations() : this.foundOperations,
    );
  }

  @override
  List<Object?> get props => [
        status,
        operations,
        filter,
        searchWord,
        foundOperations,
      ];
}
