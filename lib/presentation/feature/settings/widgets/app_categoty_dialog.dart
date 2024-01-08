import 'package:auto_route/auto_route.dart';
import 'package:finplan24/app/app.dart';
import 'package:finplan24/domain/domain.dart';
import 'package:finplan24/presentation/feature/operation/bloc/operation_bloc.dart';
import 'package:finplan24/presentation/feature/settings/settings.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class AppCategoryDialog extends StatefulWidget {
  const AppCategoryDialog({
    super.key,
  });

  @override
  State<AppCategoryDialog> createState() => _AppCategoryDialogState();
}

class _AppCategoryDialogState extends State<AppCategoryDialog> {
  Set<String> selectedCategories = {};
  final TextEditingController controllerName = TextEditingController();
  final GlobalKey<FormState> formKey = GlobalKey();
  CategoryType type = CategoryType.category;

  @override
  void initState() {
    final operations = context.read<OperationBloc>().state.operations;
    context.read<CategoriesCubit>().getUnloadedCategories(operations);
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return SimpleDialog(
      backgroundColor: AppColors.greyDark,
      children: [
        Padding(
          padding: AppPadding.all16,
          child: Column(
            children: [
              DropdownButton<CategoryType>(
                alignment: Alignment.center,
                value: type,
                icon: const Icon(
                  Icons.arrow_drop_down,
                  color: AppColors.orange,
                ),
                elevation: 16,
                style: AppTextStyle.bold24,
                dropdownColor: AppColors.greyDark,
                underline: Container(
                  width: double.infinity,
                  height: 2,
                  color: AppColors.orange,
                ),
                onChanged: (value) {
                  if (value != null) {
                    setState(() {
                      type = value;
                    });
                  }
                },
                items: CategoryType.values
                    .map<DropdownMenuItem<CategoryType>>((value) {
                  return DropdownMenuItem<CategoryType>(
                    value: value,
                    child: Text(value.toStr()),
                  );
                }).toList(),
              ),
              Form(
                key: formKey,
                child: Padding(
                  padding: AppPadding.top8,
                  child: AppTextField(
                    labelText: 'Название',
                    controller: controllerName,
                  ),
                ),
              ),
              Padding(
                padding: AppPadding.top8,
                child: SizedBox(
                  height: MediaQuery.of(context).size.height / 2,
                  child: BlocBuilder<CategoriesCubit, CategoriesState>(
                    builder: (context, state) {
                      if (state.unloadedCategories.isEmpty) {
                        if (state.status == CategoriesStatus.loading) {
                          return const AppLoader();
                        } else if (state.status != CategoriesStatus.success) {
                          return const SizedBox();
                        } else {
                          return Center(
                            child: Text(
                              'нет категорий',
                              style: Theme.of(context).textTheme.bodySmall,
                            ),
                          );
                        }
                      }

                      final unloadedCategories = state.unloadedCategories;
                      return SingleChildScrollView(
                        padding: const EdgeInsets.symmetric(horizontal: 5),
                        child: Wrap(
                          children: List.generate(
                            unloadedCategories.length,
                            (index) {
                              return Padding(
                                padding:
                                    const EdgeInsets.symmetric(horizontal: 5),
                                child: AppButton(
                                  isFixedSize: false,
                                  backgroundColor: selectedCategories
                                          .contains(unloadedCategories[index])
                                      ? AppColors.grey
                                      : AppColors.greyDark,
                                  onPressed: () {
                                    if (selectedCategories
                                        .contains(unloadedCategories[index])) {
                                      selectedCategories
                                          .remove(unloadedCategories[index]);
                                    } else {
                                      selectedCategories
                                          .add(unloadedCategories[index]);
                                    }
                                    setState(() {});
                                  },
                                  child: Text(
                                    unloadedCategories[index],
                                    style: AppTextStyle.medium14,
                                  ),
                                ),
                              );
                            },
                          ),
                        ),
                      );
                    },
                  ),
                ),
              ),
              Padding(
                padding: AppPadding.top8,
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    AppButton(
                      onPressed: () {
                        context.read<CategoriesCubit>().getAllCategories();
                        context.popRoute();
                      },
                      child: const Text(
                        'Назад',
                        style: AppTextStyle.bold14,
                      ),
                    ),
                    AppButton(
                      onPressed: () {
                        if (selectedCategories.isNotEmpty) {
                          context.read<CategoriesCubit>().addAll(
                              list: selectedCategories.toList(), type: type);
                          selectedCategories = {};
                          context.popRoute();
                        }
                        if (formKey.currentState?.validate() == true) {
                          context.read<CategoriesCubit>().addCategories(
                                category: controllerName.text,
                                type: type,
                              );
                          //context.read<CategoriesCubit>().getAllCategories();
                          context.popRoute();
                        }
                      },
                      child: const Text(
                        'Добавить',
                        style: AppTextStyle.bold14,
                      ),
                    ),
                  ],
                ),
              ),
            ],
          ),
        ),
      ],
    );
  }
}

extension on CategoryType {
  String toStr() {
    switch (this) {
      case CategoryType.category:
        return 'Категории';
      case CategoryType.subCategory:
        return 'Подкатегории';
      default:
        throw Exception(['Ошибка преобразования данных']);
    }
  }
}
