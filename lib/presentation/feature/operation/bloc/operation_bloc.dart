import 'dart:async';

import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:finplan24/domain/domain.dart';

part 'operation_event.dart';

part 'operation_state.dart';

class OperationBloc extends Bloc<OperationEvent, OperationState> {
  OperationBloc({
    required OperationsRepositoryInterface operationsRepository,
  })  : _operationsRepository = operationsRepository,
        super(const OperationState()) {
    on<OperationSubscriptionRequested>(_onSubscriptionRequested);
    on<OperationSearchRequested>(_onOperationSearchRequested);
    on<OperationAdded>(_onOperationAdded);
    on<OperationUpdated>(_onOperationUpdated);
    on<OperationDeleted>(_onOperationDeleted);
    on<OperationFilterChanged>(_onFilterChanged);

  }

  final OperationsRepositoryInterface _operationsRepository;

  Future<void> _onSubscriptionRequested(
    OperationSubscriptionRequested event,
    Emitter<OperationState> emit,
  ) async {
    emit(state.copyWith(status: () => OperationStatus.loading));

    await emit.forEach<List<Operation>>(
      _operationsRepository.getOperations(),
      onData: (operations) => state.copyWith(
        status: () => OperationStatus.success,
        operations: () => operations,
      ),
      onError: (error, __) => state.copyWith(
        status: () => OperationStatus.failure,
        error: () => error.toString(),
      ),
    );
  }

  Future<void> _onOperationSearchRequested(
    OperationSearchRequested event,
    Emitter<OperationState> emit,
  ) async {
    //await _operationsRepository.searchOperations(event.searchWord);
    emit(state.copyWith(searchWord: () => event.searchWord));
  }

  Future<void> _onOperationAdded(
    OperationAdded event,
    Emitter<OperationState> emit,
  ) async {
    await _operationsRepository.addOperation(event.operation);
  }

  Future<void> _onOperationUpdated(
    OperationUpdated event,
    Emitter<OperationState> emit,
  ) async {
    await _operationsRepository.updateOperation(event.operation);
  }

  Future<void> _onOperationDeleted(
    OperationDeleted event,
    Emitter<OperationState> emit,
  ) async {
    await _operationsRepository.deleteOperation(event.operation);
  }

  void _onFilterChanged(
    OperationFilterChanged event,
    Emitter<OperationState> emit,
  ) {
    emit(state.copyWith(filter: () => event.filter));
  }
}
