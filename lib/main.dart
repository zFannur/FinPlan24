import 'dart:async';
import 'dart:developer';

import 'package:bloc/bloc.dart';
import 'package:finplan24/app/app.dart';
import 'package:finplan24/app/app_bloc_observer.dart';
import 'package:finplan24/data/local_storage/operation_local_storage.dart';
import 'package:finplan24/data/models/operation_dto.dart';
import 'package:finplan24/data/repositories/operation_repository.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:realm/realm.dart';

void main() {
  WidgetsFlutterBinding.ensureInitialized();

  Bloc.observer = const AppBlocObserver();

  var config = Configuration.local([OperationDto.schema]);
  var realm = Realm(config);

  final localStorage = RealmOperationLocalStorage(realm);

  final operationsRepository = OperationsRepository(localStorage);

  runApp(
    RepositoryProvider.value(
      value: operationsRepository,
      child: FinPlan24App(),
    ),
  );
}
