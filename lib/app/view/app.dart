import 'package:finplan24/app/app.dart';
import 'package:finplan24/data/data.dart';
import 'package:finplan24/domain/domain.dart';
import 'package:finplan24/l10n/l10n.dart';
import 'package:finplan24/presentation/feature/operation/operation.dart';
import 'package:finplan24/presentation/feature/settings/settings.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class FinPlan24App extends StatelessWidget {
  FinPlan24App({
    super.key,
  });

  final _appRouter = AppRouter();

  @override
  Widget build(BuildContext context) {
    return MultiBlocProvider(
      providers: [
        BlocProvider(
          create: (context) => OperationBloc(
            operationsRepository: context.read<OperationsRepository>(),
          )..add(const OperationSubscriptionRequested()),
        ),
        BlocProvider(
          create: (context) =>
              SettingsCubit(context.read<OperationsRepository>()),
        ),
        BlocProvider(
          create: (context) => CategoriesCubit(
            categoriesRepository: context.read<RealmRepository<Category>>(),
            subCategoriesRepository:
                context.read<RealmRepository<SubCategory>>(),
          ),
        ),
      ],
      child: MaterialApp.router(
        localizationsDelegates: AppLocalizations.localizationsDelegates,
        supportedLocales: AppLocalizations.supportedLocales,
        theme: mainThemeData,
        debugShowCheckedModeBanner: false,
        routerConfig: _appRouter.config(),
      ),
    );
  }
}
