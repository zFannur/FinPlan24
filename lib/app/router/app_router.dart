import 'package:auto_route/auto_route.dart';
import 'package:finplan24/domain/domain.dart';
import 'package:finplan24/presentation/feature/home/screens/home_screen.dart';
import 'package:finplan24/presentation/feature/operation/operation.dart';
import 'package:finplan24/presentation/feature/plan/screens/plan_screen.dart';
import 'package:finplan24/presentation/feature/settings/settings.dart';
import 'package:flutter/material.dart';

part 'app_router.gr.dart';

@AutoRouterConfig()
class AppRouter extends _$AppRouter {

  @override
  List<AutoRoute> get routes => [
    AutoRoute(
      page: HomeRoute.page,
      path: '/',
      children: [
        AutoRoute(
          page: OperationRoute.page,
          path: 'operation',
        ),
        AutoRoute(
          page: PlanRoute.page,
          path: 'plan',
        ),
        // AutoRoute(
        //   page: FinanceStatisticRoute.page,
        //   path: 'finance_statistic',
        // ),
      ],
    ),

    AutoRoute(
      page: OperationDetailRoute.page,
      path: '/detail',
    ),
    AutoRoute(
      page: SettingsRoute.page,
      path: '/settings',
    ),
    AutoRoute(
      page: CategoriesEditRoute.page,
      path: '/categories',
    ),
  ];
}