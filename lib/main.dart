import 'package:finplan24/app/app.dart';
import 'package:finplan24/app/app_bloc_observer.dart';
import 'package:finplan24/data/data.dart';
import 'package:finplan24/domain/domain.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:realm/realm.dart';

void main() {
  WidgetsFlutterBinding.ensureInitialized();

  Bloc.observer = const AppBlocObserver();

  final config = Configuration.local([
    OperationDto.schema,
    Category.schema,
    SubCategory.schema,
  ]);
  final realm = Realm(config);

  final localStorage = RealmOperationLocalStorage(realm);

  final operationsRepository = OperationsRepository(localStorage);
  final categoriesRepository = RealmRepository<Category>(realm);
  final subCategoriesRepository = RealmRepository<SubCategory>(realm);

  runApp(
    MultiRepositoryProvider(
      providers: [
        RepositoryProvider.value(
          value: operationsRepository,
        ),
        RepositoryProvider.value(
          value: categoriesRepository,
        ),
        RepositoryProvider.value(
          value: subCategoriesRepository,
        ),
      ],
      child: FinPlan24App(),
    ),
  );
}
