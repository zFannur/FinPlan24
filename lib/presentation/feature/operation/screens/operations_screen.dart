import 'package:auto_route/auto_route.dart';
import 'package:finplan24/app/app.dart';
import 'package:finplan24/presentation/feature/operation/operation.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

@RoutePage()
class OperationScreen extends StatelessWidget {
  const OperationScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: const OperationsBuilder(),
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          context.pushRoute(
            OperationDetailRoute(
              buttonIcon: Icons.add,
              onTap: (operation) {
                context
                    .read<OperationBloc>().add(OperationAdded(operation));
                // context.read<CategoriesCubit>().add(
                //       name: operationEntity.category,
                //       categoryType: CategoryType.category,
                //     );
                // context.read<CategoriesCubit>().add(
                //       name: operationEntity.category,
                //       categoryType: CategoryType.underCategory,
                //     );
                context.popRoute();
              },
              title: 'Добавить',
              onDelete: (operation) {
                context
                    .read<OperationBloc>()
                    .add(OperationDeleted(operation));
                context.popRoute();
              },
            ),
          );
        },
        child: AppIcons.add,
      ),
    );
  }
}
