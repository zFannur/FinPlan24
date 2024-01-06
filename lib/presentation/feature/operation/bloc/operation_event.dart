part of 'operation_bloc.dart';

sealed class OperationEvent extends Equatable {
  const OperationEvent();

  @override
  List<Object> get props => [];
}

final class OperationSubscriptionRequested extends OperationEvent {
  const OperationSubscriptionRequested();
}

final class OperationSearchRequested extends OperationEvent {
  const OperationSearchRequested(this.searchWord);

  final String searchWord;

  @override
  List<Object> get props => [searchWord];
}

final class OperationDeleted extends OperationEvent {
  const OperationDeleted(this.operation);

  final Operation operation;

  @override
  List<Object> get props => [operation];
}

final class OperationUpdated extends OperationEvent {
  const OperationUpdated(this.operation);

  final Operation operation;

  @override
  List<Object> get props => [operation];
}

final class OperationAdded extends OperationEvent {
  const OperationAdded(this.operation);

  final Operation operation;

  @override
  List<Object> get props => [operation];
}

final class OperationFilterChanged extends OperationEvent {
  const OperationFilterChanged(this.filter);

  final OperationViewFilter filter;

  @override
  List<Object> get props => [filter];
}