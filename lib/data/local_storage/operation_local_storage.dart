import 'dart:async';
import 'package:finplan24/data/data.dart';

import 'package:realm/realm.dart';
import 'package:rxdart/rxdart.dart';

class RealmOperationLocalStorage implements OperationLocalStorageInterface {
  RealmOperationLocalStorage(Realm realm) : _realm = realm {
    _init();
  }

  final Realm _realm;

  final _operationStreamController =
      BehaviorSubject<List<OperationDto>>.seeded(const []);

  List<OperationDto>? _getValue() => _realm.all<OperationDto>().toList();

  void _setValue(OperationDto operationDto, {bool? update}) {
    _realm.write(() => _realm.add(operationDto, update: update ?? false));
  }

  void _deleteValue(OperationDto operationDto) {
    _realm.write(() {
        // Ищем операцию по ее id
        var operation = _realm.find<OperationDto>(operationDto.id);

        // Проверяем, что операция с таким id существует
        if (operation != null) {
          // Удаляем операцию из базы данных
          _realm.delete(operation);
        }
    });
  }

  void _init() {
    final operationsDto = _getValue() ?? const [];
    _operationStreamController.add(operationsDto);
  }

  @override
  Stream<List<OperationDto>> getOperations() =>
      _operationStreamController.asBroadcastStream();

  @override
  Future<List<OperationDto>> searchOperations(String searchWord) async {
    final searchList = _realm
        .query<OperationDto>(
          "type == '$searchWord' OR category == '$searchWord' OR sum == '$searchWord' OR subCategory == '$searchWord'",
        )
        .toList();

    if (searchList.isEmpty) {
      throw OperationNotFoundException();
    } else {
      return searchList;
    }
  }

  @override
  Future<void> addOperation(OperationDto operationDto) async {
    final operations = [..._operationStreamController.value, operationDto];
    _operationStreamController.add(operations);
    return _setValue(operationDto);
  }

  @override
  Future<void> updateOperation(OperationDto operationDto) async {
    final operations = [..._operationStreamController.value];

    final operationIndex =
        operations.indexWhere((item) => item.id == operationDto.id);
    operations[operationIndex] = operationDto;

    _operationStreamController.add(operations);
    return _setValue(operationDto, update: true);
  }

  @override
  Future<void> deleteOperation(OperationDto operationDto) async {
    final operations = [..._operationStreamController.value]
      ..removeWhere((item) => item.id == operationDto.id);

    _operationStreamController.add(operations);
    return _deleteValue(operationDto);
  }
}
