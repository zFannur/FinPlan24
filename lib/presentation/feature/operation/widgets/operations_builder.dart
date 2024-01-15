import 'package:finplan24/app/app.dart';
import 'package:finplan24/domain/domain.dart';
import 'package:finplan24/presentation/feature/operation/operation.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class OperationsBuilder extends StatelessWidget {
  const OperationsBuilder({super.key});

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Row(
          children: [
            IconButton(
                onPressed: () {
                  // TO:DO сделать фильтр по категориям
                },
                icon: const Icon(
                  Icons.filter_alt_rounded,
                  color: AppColors.orange,
                )),
            Expanded(
              child: Padding(
                padding: AppPadding.v8h40,
                child: AppTextField(
                  maxLines: 1,
                  labelText: 'Поиск',
                  onChanged: (query) {
                    context.read<OperationBloc>().add(
                          OperationSearchRequested(query),
                        );
                  },
                ),
              ),
            ),
          ],
        ),
        Expanded(
          child: BlocConsumer<OperationBloc, OperationState>(
            listener: (context, state) {
              // if (state.asyncSnapshot?.hasData == true) {
              //   AppSnackBar.showSnackBarWithMessage(
              //     context,
              //     state.asyncSnapshot?.data,
              //   );
              // }

              if (state.error?.isNotEmpty ?? false) {
                AppSnackBar.showSnackBarWithError(
                  context,
                  ErrorEntity(message: state.error ?? 'ошибка'),
                );
              }
            },
            builder: (context, state) {
              if (state.operations.isEmpty) {
                if (state.status == OperationStatus.loading) {
                  return const AppLoader();
                } else if (state.status != OperationStatus.success) {
                  return const SizedBox();
                } else {
                  return Center(
                    child: Text(
                      'нет операций',
                      style: Theme.of(context).textTheme.bodySmall,
                    ),
                  );
                }
              }

              return Column(
                children: [
                  Container(
                    padding: AppPadding.v8h20,
                    color: AppColors.greyDark,
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceAround,
                      children: [
                        const Text(
                          'Общая сумма',
                          style: AppTextStyle.bold24,
                        ),
                        Text(
                          '+ ${state.sumIncome}',
                          style: AppTextStyle.boldGreen14,
                        ),
                        Text(
                          '- ${state.sumExpense}',
                          style: AppTextStyle.boldRed14,
                        ),
                      ],
                    ),
                  ),
                  Expanded(
                    child: ListView.builder(
                        itemCount: state.filteredOperations.length,
                        itemBuilder: (BuildContext context, int index) {
                          return OperationsPerDay(
                            operationsFiltered: state.filteredOperations[index],
                          );
                        }),
                  ),
                ],
              );
            },
          ),
        ),
      ],
    );
  }
}

enum PageType { all, week, month, search }

class FilterTapBarWidget extends StatefulWidget {
  const FilterTapBarWidget({super.key});

  @override
  State<FilterTapBarWidget> createState() => _FilterTapBarWidgetState();
}

class _FilterTapBarWidgetState extends State<FilterTapBarWidget> {
  PageType _currentPage = PageType.all;

  void onSelectedPage(PageType type) {
    if (_currentPage == type) return;
    setState(() {
      _currentPage = type;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceEvenly,
      children: [
        CustomTextButton(
          isSelected: _currentPage == PageType.all ? true : false,
          name: 'Все',
          onTap: () {
            if (_currentPage == PageType.all) return;
            onSelectedPage(PageType.all);
            //context.read<OperationFilterCubit>().filterOperationByDay();
          },
        ),
        CustomTextButton(
          isSelected: _currentPage == PageType.week ? true : false,
          name: 'Неделя',
          onTap: () {
            onSelectedPage(PageType.week);
          },
        ),
        CustomTextButton(
          isSelected: _currentPage == PageType.month ? true : false,
          name: 'Месяц',
          onTap: () {
            onSelectedPage(PageType.month);
          },
        ),
        CustomTextButton(
          isSelected: _currentPage == PageType.search ? true : false,
          name: 'Поиск',
          onTap: () {
            onSelectedPage(PageType.search);
          },
        ),
      ],
    );
  }
}
