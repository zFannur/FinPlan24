import 'package:auto_route/auto_route.dart';
import 'package:finplan24/app/app.dart';
import 'package:finplan24/domain/domain.dart';
import 'package:finplan24/presentation/feature/operation/bloc/operation_bloc.dart';
import 'package:finplan24/presentation/feature/settings/settings.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

@RoutePage()
class SettingsScreen extends StatelessWidget {
  const SettingsScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final categoryCubit = context.read<CategoriesCubit>();
    final route = context.router;
    return Scaffold(
      appBar: const AppAppBar(
        name: 'Настройки',
        withSettings: false,
        withArrowBack: true,
        withAccount: true,
      ),
      body: Center(
        child: Column(
          children: [
            AppButton(
                isFixedSize: false,
                onPressed: () {
                  categoryCubit.getAllCategories();
                  route.push(const CategoriesEditRoute());
                },
                child: const Text(
                  'Редактировать категории',
                  textAlign: TextAlign.center,
                  style: AppTextStyle.bold14,
                )),
            const ImportExportWidget(),
          ],
        ),
      ),
    );
  }
}

class ImportExportWidget extends StatelessWidget {
  const ImportExportWidget({super.key});

  @override
  Widget build(BuildContext context) {
    final operations = context.read<OperationBloc>().state.operations;
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceEvenly,
      children: [
        AppButton(
          isFixedSize: false,
          onPressed: () {
            context.read<SettingsCubit>().saveToCsv(operations);
          },
          child: const Text(
            'Сохранить данные',
            textAlign: TextAlign.center,
            style: AppTextStyle.bold14,
          ),
        ),
        AppButton(
          isFixedSize: false,
          onPressed: () async {
            final navigator = Navigator.of(context);
            final data =
                await context.read<SettingsCubit>().loadCsvFromStorage();
            await navigator.push(
              MaterialPageRoute<_PreloadDataScreen>(
                builder: (context) => _PreloadDataScreen(data: data),
              ),
            );
          },
          child: const Text(
            'Загрузить данные',
            textAlign: TextAlign.center,
            style: AppTextStyle.bold14,
          ),
        ),
      ],
    );
  }
}

class _PreloadDataScreen extends StatelessWidget {
  const _PreloadDataScreen({required this.data});
  final List<Operation> data;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: const AppAppBar(
        name: 'Содержание',
        withSettings: false,
      ),
      body: ListView.builder(
        itemCount: data.length,
        itemBuilder: (BuildContext context, int index) {
          return Card(
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              children: [
                Text(
                  data[index].sum.toString(),
                  style: AppTextStyle.medium14,
                ),
                Text(
                  data[index].category,
                  style: AppTextStyle.medium14,
                ),
                Text(
                  data[index].subCategory,
                  style: AppTextStyle.medium14,
                ),
              ],
            ),
          );
        },
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          context.read<SettingsCubit>().saveData(data);
          context.pushRoute(const HomeRoute());
        },
        child: const Icon(
          Icons.save,
          color: AppColors.orange,
        ),
      ),
    );
  }
}
