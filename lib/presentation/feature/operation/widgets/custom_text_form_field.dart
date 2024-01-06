import 'package:auto_route/auto_route.dart';
import 'package:finplan24/app/app.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class CustomTextFormField extends StatelessWidget {
  const CustomTextFormField({
    required this.hintText,
    required this.labelText,
    required this.controller,
    super.key,
    this.validator,
  });

  final String hintText;
  final String labelText;
  final TextEditingController controller;
  final String? Function(String? value)? validator;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: AppPadding.v10h40,
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
              controller: controller,
              validator: validator,
              labelText: labelText,
              onTap: () {
                //context.read<CategoriesCubit>().getCategories(categoriesKey);
                _showBottomSheet(context);
              },
            ),
          ),
        ],
      ),
    );
  }

  void _showBottomSheet(BuildContext context) {
    showModalBottomSheet(
      useSafeArea: true,
      backgroundColor: Colors.transparent,
      isScrollControlled: true,
      context: context,
      builder: (BuildContext context) {
        return Container(
          margin: const EdgeInsets.only(top: 60),
          decoration: const BoxDecoration(
            borderRadius: BorderRadius.only(
                topRight: Radius.circular(20), topLeft: Radius.circular(20)),
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
                padding: AppPadding.v10h20,
                child: AppTextField(
                  controller: controller,
                  labelText: labelText,
                  onChanged: (value) {
                    if (value.isEmpty) {
                      // context
                      //     .read<CategoriesCubit>()
                      //     .getCategories(categoriesKey);
                    } else {
                      // context
                      //     .read<CategoriesCubit>()
                      //     .searchCategories(categoriesKey, value);
                    }
                  },
                ),
              ),
              // BlocBuilder<CategoriesCubit, CategoriesState>(
              //   builder: (context, state) {
              //     return state.maybeWhen(
              //       loaded: (List<dynamic> list) => Expanded(
              //         child: SingleChildScrollView(
              //           padding: const EdgeInsets.symmetric(horizontal: 5),
              //           child: Wrap(
              //             children: List.generate(
              //               list.length,
              //               (index) {
              //                 return Padding(
              //                   padding:
              //                       const EdgeInsets.symmetric(horizontal: 5),
              //                   child: AppButton(
              //                     isFixedSize: false,
              //                     onPressed: () {
              //                       controller.text = list[index];
              //                       context.popRoute();
              //                     },
              //                     child: Text(
              //                       list[index],
              //                       style: AppTextStyle.medium14,
              //                     ),
              //                   ),
              //                 );
              //               },
              //             ),
              //           ),
              //         ),
              //       ),
              //       loading: () => const AppLoader(),
              //       error: (error) => Text(
              //         error.toString(),
              //         style: AppTextStyle.mediumRed20,
              //       ),
              //       orElse: () {
              //         return const Text(
              //           'Что то пошло не так',
              //           style: AppTextStyle.bold24,
              //         );
              //       },
              //     );
              //   },
              // ),
            ],
          ),
        );
      },
    );
  }
}

class SumFieldWidget extends StatelessWidget {
  const SumFieldWidget({
    Key? key,
    required this.hintText,
    required this.labelText,
    required this.controller,
    required this.validator,
  }) : super(key: key);
  final String hintText;
  final String labelText;
  final TextEditingController controller;
  final String? Function(String? value) validator;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: AppPadding.v10h40,
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
    Key? key,
    required this.hintText,
    required this.labelText,
    required this.controller,
    required this.validator,
  }) : super(key: key);
  final String hintText;
  final String labelText;
  final TextEditingController controller;
  final String? Function(String? value) validator;

  Future<DateTime> selectDate(BuildContext context) async {
    DateTime selectedDate = DateTime.now();
    final selected = await showDatePicker(
      context: context,
      initialDate: selectedDate,
      firstDate: DateTime(2000),
      lastDate: DateTime(2037),
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
      padding: AppPadding.v10h40,
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
                DateTime date = await selectDate(context);
                controller.text = date.toString();
              },
            ),
          ),
        ],
      ),
    );
  }
}
