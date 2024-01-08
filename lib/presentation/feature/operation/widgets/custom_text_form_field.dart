import 'package:auto_route/auto_route.dart';
import 'package:finplan24/app/app.dart';
import 'package:finplan24/domain/domain.dart';
import 'package:finplan24/presentation/feature/settings/settings.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class DialogTextFormField extends StatelessWidget {
  const DialogTextFormField({
    required this.labelText,
    required this.controller,
    required this.type,
    super.key,
    this.validator,
  });

  final String labelText;
  final TextEditingController controller;
  final String? Function(String? value)? validator;
  final CategoryType type;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: AppPadding.v8h40,
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            type.toStr(),
            style: AppTextStyle.bold24,
          ),
          Padding(
            padding: AppPadding.top8,
            child: AppTextField(
              controller: controller,
              validator: validator,
              labelText: labelText,
              onTap: () {
                context.read<CategoriesCubit>().getAllCategories();
                _showBottomSheet(context);
              },
            ),
          ),
        ],
      ),
    );
  }

  void _showBottomSheet(BuildContext context) {
    showModalBottomSheet<void>(
      useSafeArea: true,
      backgroundColor: Colors.transparent,
      isScrollControlled: true,
      context: context,
      builder: (BuildContext context) {
        return Container(
          margin: const EdgeInsets.only(top: 60),
          decoration: const BoxDecoration(
            borderRadius: BorderRadius.only(
              topRight: Radius.circular(20),
              topLeft: Radius.circular(20),
            ),
            color: AppColors.black,
          ),
          child: Column(
            children: [
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                children: [
                  AppButton(
                    onPressed: () {
                      context.popRoute();
                    },
                    child: const Text(
                      'Назад',
                      style: AppTextStyle.bold14,
                    ),
                  ),
                  AppButton(
                    onPressed: () {
                      if (controller.text.isNotEmpty) {
                        context.read<CategoriesCubit>().addCategories(
                              category: controller.text,
                              type: type,
                            );
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
              Padding(
                padding: AppPadding.v8h20,
                child: AppTextField(
                  autofocus: true,
                  controller: controller,
                  labelText: type.toStr(),
                  onChanged: (value) {
                    if (value.isEmpty) {
                      context.read<CategoriesCubit>().getAllCategories();
                    } else {
                      context.read<CategoriesCubit>().searchCategories(value);
                    }
                  },
                ),
              ),
              BlocBuilder<CategoriesCubit, CategoriesState>(
                builder: (context, state) {
                  final isEmpty = type == CategoryType.category
                      ? state.categories.isEmpty
                      : state.subCategoriesName.isEmpty;

                  if (isEmpty) {
                    if (state.status == CategoriesStatus.loading) {
                      return const AppLoader();
                    } else if (state.status != CategoriesStatus.success) {
                      return const SizedBox();
                    } else {
                      return const Center(
                        child: Text(
                          'нет категорий',
                          style: AppTextStyle.bold24,
                        ),
                      );
                    }
                  }

                  final list = type == CategoryType.category
                      ? state.categoriesName
                      : state.subCategoriesName;
                  return Expanded(
                    child: SingleChildScrollView(
                      padding: const EdgeInsets.symmetric(horizontal: 5),
                      child: Wrap(
                        children: List.generate(
                          list.length,
                          (index) {
                            return Padding(
                              padding:
                                  const EdgeInsets.symmetric(horizontal: 5),
                              child: AppButton(
                                isFixedSize: false,
                                onPressed: () {
                                  controller.text = list[index];
                                  context.popRoute();
                                },
                                child: Text(
                                  list[index],
                                  style: AppTextStyle.medium14,
                                ),
                              ),
                            );
                          },
                        ),
                      ),
                    ),
                  );
                },
              ),
            ],
          ),
        );
      },
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

class SumFieldWidget extends StatelessWidget {
  const SumFieldWidget({
    required this.hintText,
    required this.labelText,
    required this.controller,
    required this.validator,
    super.key,
  });

  final String hintText;
  final String labelText;
  final TextEditingController controller;
  final String? Function(String? value) validator;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: AppPadding.v8h40,
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            hintText,
            style: AppTextStyle.bold24,
          ),
          Padding(
            padding: AppPadding.top8,
            child: AppTextField(
              keyboardType: TextInputType.number,
              controller: controller,
              validator: validator,
              labelText: labelText,
            ),
          ),
        ],
      ),
    );
  }
}

class DataFieldWidget extends StatelessWidget {
  const DataFieldWidget({
    required this.hintText,
    required this.labelText,
    required this.controller,
    required this.validator,
    super.key,
  });

  final String hintText;
  final String labelText;
  final TextEditingController controller;
  final String? Function(String? value) validator;

  Future<DateTime> selectDate(BuildContext context) async {
    var selectedDate = DateTime.now();
    final selected = await showDatePicker(
      context: context,
      initialDate: selectedDate,
      firstDate: DateTime(2000),
      lastDate: DateTime(2100),
    );

    if (selected != null && selected != selectedDate) {
      selectedDate = selected.copyWith(
        hour: DateTime.now().hour,
        minute: DateTime.now().minute,
        second: DateTime.now().second,
      );
    }
    return selectedDate;
  }

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: AppPadding.v8h40,
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            hintText,
            style: AppTextStyle.bold24,
          ),
          Padding(
            padding: AppPadding.top8,
            child: AppTextField(
              keyboardType: TextInputType.number,
              controller: controller,
              validator: validator,
              labelText: labelText,
              onTap: () async {
                final date = await selectDate(context);
                controller.text = date.toString();
              },
            ),
          ),
        ],
      ),
    );
  }
}
