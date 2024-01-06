import 'package:auto_route/auto_route.dart';
import 'package:finplan24/app/app.dart';
import 'package:finplan24/domain/domain.dart';
import 'package:finplan24/presentation/feature/operation/bloc/operation_bloc.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class OperationsPerDay extends StatelessWidget {
  const OperationsPerDay({
    required this.operationsFiltered,
    super.key,
  });

  final OperationsFiltered operationsFiltered;

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Container(
          padding: AppPadding.v10h20,
          color: AppColors.greyDark,
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceAround,
            children: [
              Row(
                children: [
                  Text(
                    '${operationsFiltered.date.day}',
                    style: AppTextStyle.bold24,
                  ),
                  const SizedBox(width: 8),
                  Text(
                    '${operationsFiltered.date.month}.${operationsFiltered.date.year}  ${operationsFiltered.date.getWeekDayString()}',
                    style: AppTextStyle.medium14,
                  ),
                ],
              ),
              Text(
                '+${operationsFiltered.sumIncome}',
                style: AppTextStyle.boldGreen14,
              ),
              Text(
                '-${operationsFiltered.sumExpense}',
                style: AppTextStyle.boldRed14,
              ),
            ],
          ),
        ),
        Column(
          children: List.generate(operationsFiltered.operationsPerDay.length,
              (index) {
            final TextStyle style14 =
                operationsFiltered.operationsPerDay[index].type == Type.expense
                    ? AppTextStyle.mediumRed14
                    : AppTextStyle.mediumGreen14;

            final TextStyle style20 =
                operationsFiltered.operationsPerDay[index].type == Type.expense
                    ? AppTextStyle.mediumRed20
                    : AppTextStyle.mediumGreen20;
            return Column(
              children: [
                InkWell(
                  onTap: () {
                    context.pushRoute(
                      OperationDetailRoute(
                        operation: operationsFiltered.operationsPerDay[index],
                        buttonIcon: Icons.edit,
                        onTap: (operation) {
                          context
                              .read<OperationBloc>()
                              .add(OperationUpdated(operation));

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
                        onDelete: (operation) {
                          context
                              .read<OperationBloc>()
                              .add(OperationDeleted(operation));
                          context.popRoute();
                        },
                        title: 'Редактирование',
                      ),
                    );
                  },
                  child: Container(
                    padding: AppPadding.all8,
                    color: operationsFiltered.operationsPerDay[index].type ==
                            Type.expense
                        ? AppColors.redShade100
                        : AppColors.greenShade100,
                    child: Row(
                      crossAxisAlignment: CrossAxisAlignment.center,
                      children: [
                        Expanded(
                          flex: 2,
                          child: Column(
                            children: [
                              Text(
                                operationsFiltered
                                    .operationsPerDay[index].subCategory,
                                style: style14,
                              ),
                              Visibility(
                                visible: operationsFiltered
                                    .operationsPerDay[index].note.isNotEmpty,
                                child: Text(
                                  operationsFiltered
                                      .operationsPerDay[index].note,
                                  style: style14,
                                ),
                              ),
                            ],
                          ),
                        ),
                        Expanded(
                          flex: 3,
                          child: Text(
                            operationsFiltered.operationsPerDay[index].category,
                            style: style20,
                          ),
                        ),
                        Expanded(
                          flex: 1,
                          child: Text(
                            '${operationsFiltered.operationsPerDay[index].sum}',
                            style: style20,
                          ),
                        ),
                      ],
                    ),
                  ),
                ),
                Visibility(
                  visible: index == operationsFiltered.operationsPerDay.length
                      ? false
                      : true,
                  child: const Divider(height: 1, color: AppColors.black),
                ),
              ],
            );
          }),
        ),
      ],
    );
  }
}

extension DateTimeExtension on DateTime {
  String getWeekDayString() {
    switch (weekday) {
      case 1:
        return 'Пн';
      case 2:
        return 'Вт';
      case 3:
        return 'Ср';
      case 4:
        return 'Чт';
      case 5:
        return 'Пт';
      case 6:
        return 'Сб';
      case 7:
        return 'Вс';
      default:
        return 'Ошибка';
    }
  }
}
