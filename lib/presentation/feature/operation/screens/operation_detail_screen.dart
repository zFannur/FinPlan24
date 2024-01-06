import 'package:auto_route/auto_route.dart';
import 'package:finplan24/app/app.dart';
import 'package:finplan24/domain/domain.dart';
import 'package:finplan24/presentation/feature/operation/operation.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

enum OperationType {
  date,
  type,
  form,
  note,
}

@RoutePage()
class OperationDetailScreen extends StatefulWidget {
  const OperationDetailScreen({
    required this.buttonIcon,
    required this.onTap,
    required this.title,
    required this.onDelete,
    super.key,
    this.operation,
  });

  final String title;
  final IconData buttonIcon;
  final void Function(Operation operation) onTap;
  final void Function(Operation operation) onDelete;
  final Operation? operation;

  @override
  State<OperationDetailScreen> createState() => _OperationDetailScreenState();
}

class _OperationDetailScreenState extends State<OperationDetailScreen> {
  final formKey = GlobalKey<FormState>();

  late Type type;
  final controllerDate = TextEditingController();
  final controllerCategory = TextEditingController();
  final controllerSum = TextEditingController();
  final controllerUnderCategory = TextEditingController();
  final controllerNote = TextEditingController();

  @override
  void initState() {
    //context.read<OperationCubit>().getOperation();
    controllerDate.text = widget.operation?.date.toString() ?? DateTime.now().toString();
    type = widget.operation?.type ?? Type.expense;
    if (widget.operation != null) {
      controllerCategory.text = widget.operation?.category ?? "";
      controllerSum.text = widget.operation?.sum.toString() ?? "";
      controllerUnderCategory.text = widget.operation?.subCategory ?? "";
      controllerNote.text = widget.operation?.note ?? "";
    }
    super.initState();
  }

  @override
  void dispose() {
    controllerDate.dispose();
    controllerCategory.dispose();
    controllerSum.dispose();
    controllerUnderCategory.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    //final categoriesCubit = context.read<CategoriesCubit>();
    return Scaffold(
      appBar: AppAppBar(name: widget.title),
      body: SingleChildScrollView(
        child: Column(
          children: [
            Form(
              key: formKey,
              child: Column(
                children: [
                  DataFieldWidget(
                    hintText: 'Дата *',
                    labelText: 'Дата операции',
                    controller: controllerDate,
                    validator: emptyValidator,
                  ),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Padding(
                        padding: const EdgeInsets.all(8.0),
                        child: InkWell(
                          onTap: () {
                            type = Type.expense;
                            setState(() {});
                          },
                          child: Container(
                            padding: const EdgeInsets.symmetric(
                                horizontal: 50, vertical: 16),
                            decoration: BoxDecoration(
                              color: type == Type.expense
                                  ? AppColors.redShade100
                                  : AppColors.greyDark,
                            ),
                            child: const Text(
                              "Расход",
                              style: AppTextStyle.boldRed14,
                            ),
                          ),
                        ),
                      ),
                      Padding(
                        padding: const EdgeInsets.all(8.0),
                        child: InkWell(
                          onTap: () {
                            type = Type.income;
                            setState(() {});
                          },
                          child: Container(
                            padding: const EdgeInsets.symmetric(
                                horizontal: 50, vertical: 16),
                            decoration: BoxDecoration(
                              color: type == Type.income
                                  ? AppColors.greenShade100
                                  : AppColors.greyDark,
                            ),
                            child: const Text(
                              "Доход",
                              style: AppTextStyle.boldGreen14,
                            ),
                          ),
                        ),
                      ),
                    ],
                  ),
                  CustomTextFormField(
                    hintText: 'Категория *',
                    labelText: 'Направление операции',
                    controller: controllerCategory,
                    validator: emptyValidator,
                  ),
                  SumFieldWidget(
                    hintText: 'Сумма *',
                    labelText: 'Сумма операции',
                    controller: controllerSum,
                    validator: emptyValidator,
                  ),
                  CustomTextFormField(
                    hintText: 'Подкатегория *',
                    labelText: 'Дополнительно об операции',
                    controller: controllerUnderCategory,
                    validator: emptyValidator,
                  ),
                ],
              ),
            ),
            CustomTextFormField(
              hintText: 'Примечание',
              labelText: 'Для чего?',
              controller: controllerNote,
            ),
          ],
        ),
      ),
      floatingActionButton: Row(
        mainAxisAlignment: MainAxisAlignment.end,
        children: [
          Visibility(
            visible: widget.operation != null,
            child: FloatingActionButton(
              heroTag: '1',
              onPressed: () => widget.onDelete(widget.operation!),
              child: const Icon(
                Icons.delete,
                color: AppColors.orange,
              ),
            ),
          ),
          const SizedBox(width: 16),
          FloatingActionButton(
            heroTag: '2',
            onPressed: () async {
              if (formKey.currentState?.validate() == true) {
                widget.onTap(Operation(
                  id: widget.operation?.id,
                  date: DateTime.tryParse(controllerDate.text) ?? DateTime.now(),
                  type: type,
                  category: controllerCategory.text,
                  sum: int.parse(controllerSum.text),
                  subCategory: controllerUnderCategory.text,
                  note: controllerNote.text,
                ));
              }
            },
            child: Icon(widget.buttonIcon, color: AppColors.orange),
          ),
        ],
      ),
    );
  }

  String? emptyValidator(String? value) {
    if (value?.isEmpty == true) {
      return "обязательное поле";
    }
    return null;
  }
}
