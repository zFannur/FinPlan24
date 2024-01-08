import 'package:auto_route/annotations.dart';
import 'package:finplan24/app/app.dart';
import 'package:finplan24/presentation/feature/settings/settings.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

@RoutePage()
class CategoriesEditScreen extends StatelessWidget {
  const CategoriesEditScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final categoriesCubit = context.read<CategoriesCubit>();
    return Scaffold(
      appBar: const AppAppBar(
        name: 'Категории',
        withSettings: false,
        withArrowBack: true,
      ),
      body: BlocBuilder<CategoriesCubit, CategoriesState>(
        builder: (context, state) {
          if (state.categories.isEmpty && state.subCategories.isEmpty) {
            if (state.status == CategoriesStatus.loading) {
              return const AppLoader();
            } else if (state.status != CategoriesStatus.success) {
              return const SizedBox();
            } else {
              return Center(
                child: Text(
                  'нет категорий',
                  style: Theme
                      .of(context)
                      .textTheme
                      .bodySmall,
                ),
              );
            }
          }

          final child = <Widget>[
            CategoryListWidget(
              list: state.categoriesName,
              name: 'Категории',
            ),
            CategoryListWidget(
              list: state.subCategoriesName,
              name: 'Подкатегории',
            ),
          ];

          return ListView(
            children: child,
          );
        },
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () async {
          await showDialog<void>(
            context: context,
            builder: (context) => const AppCategoryDialog(),
          );
          categoriesCubit.getAllCategories();
        },
        child: const Icon(
          Icons.add,
          color: AppColors.orange,
        ),
      ),
    );
  }
}

class CategoryListWidget extends StatelessWidget {
  const CategoryListWidget({
    required this.name,
    required this.list,
    super.key,
  });

  final String name;
  final List<String> list;

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Container(
          padding: AppPadding.all8,
          color: AppColors.greyDark,
          width: double.infinity,
          height: 50,
          child: Text(
            name,
            style: AppTextStyle.bold24,
          ),
        ),
        Column(
          children: List.generate(
            list.length,
                (index) {
              final item = list[index];
              return Container(
                margin: AppPadding.top8,
                padding: AppPadding.horizontal16,
                color: AppColors.grey,
                width: double.infinity,
                height: 40,
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Text(
                      item,
                      style: AppTextStyle.mediumBlack20,
                    ),
                    IconButton(
                      onPressed: () {
                        context
                            .read<CategoriesCubit>()
                            .deleteCategories(name: item);
                      },
                      icon: const Icon(
                        Icons.delete,
                        color: AppColors.red,
                      ),
                    ),
                  ],
                ),
              );
            },
          ),
        ),
      ],
    );
  }
}
