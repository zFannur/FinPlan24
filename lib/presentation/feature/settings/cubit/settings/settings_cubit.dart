import 'dart:convert';
import 'dart:ffi';
import 'dart:io';

import 'package:bloc/bloc.dart';
import 'package:csv/csv.dart';
import 'package:equatable/equatable.dart';
import 'package:excel/excel.dart';
import 'package:file_picker/file_picker.dart';
import 'package:finplan24/domain/domain.dart';
import 'package:intl/intl.dart';
import 'package:path_provider/path_provider.dart';
import 'package:uuid/uuid.dart';

part 'settings_state.dart';

class SettingsCubit extends Cubit<SettingsState> {
  SettingsCubit(this.operationsRepository) : super(SettingsInitial());

  final OperationsRepositoryInterface operationsRepository;

  Future<List<Operation>> loadCsvFromStorage() async {
    final result = await FilePicker.platform.pickFiles(
      allowedExtensions: ['csv'],
      type: FileType.custom,
    );
    final path = result?.files.first.path;
    if (path != null) {
      final csvFile = File(path).openRead();
      final list = await csvFile
          .transform(utf8.decoder)
          .transform(const CsvToListConverter())
          .toList();

      //final dateFormat = DateFormat("yyyy-MM-dd");
      final dateFormat = DateFormat("MM/dd/yyyy");

      return List.generate(
        list.length,
        (index) => Operation(
          id: list[index][0].toString(),
          date: dateFormat.parse(list[index][1].toString()),
          type: const TypeConverter().fromJson(list[index][2].toString()),
          category: list[index][3].toString(),
          sum: int.parse(list[index][4].toString()),
          subCategory: list[index][5].toString(),
          note: list[index].length > 6 ? list[index][6].toString() : '',
        ),
      );
    } else {
      return [];
    }
  }

  Future<void> saveToCsv(List<Operation> operations) async {
    final data = List<List<String>>.generate(
      operations.length,
      (index) => [
        operations[index].id,
        operations[index].date.toString(),
        const TypeConverter().toJson(operations[index].type),
        operations[index].category,
        operations[index].sum.toString(),
        operations[index].subCategory,
        operations[index].note,
      ],
    );

    final csvData = const ListToCsvConverter().convert(data);

    final directory = (await getDownloadsDirectory())?.path ?? '';
    final path = '$directory/csv-${DateTime.now()}.csv';
    final file = File(path);
    await file.writeAsString(csvData);
    await file.create();
  }

  Future<void> saveData(List<Operation> operations,
      {bool delete = true}) async {
    return operationsRepository.addFromFile(operations, delete: delete);
  }

  Future<void> exportOperationsToExcel(List<Operation> operations) async {
    var excel = Excel.createExcel();
    var sheet = excel[excel.getDefaultSheet()!]; // Получаем первый лист

    // Заголовки для файла Excel
    var headers = [
      'ID',
      'Date',
      'Type',
      'Category',
      'Sum',
      'SubCategory',
      'Note'
    ];

    // Заполнение заголовков
    headers.asMap().forEach((index, header) => sheet.updateCell(
        CellIndex.indexByColumnRow(columnIndex: index, rowIndex: 0),
        TextCellValue(header)));

    // Заполнение данных
    for (int i = 0; i < operations.length; i++) {
      var operation = operations[i];
      sheet
        ..updateCell(
            CellIndex.indexByColumnRow(columnIndex: 0, rowIndex: i + 1),
            TextCellValue(operation.id))
        ..updateCell(
            CellIndex.indexByColumnRow(columnIndex: 1, rowIndex: i + 1),
            DateCellValue(
                year: operation.date.year,
                month: operation.date.month,
                day: operation.date.day),
            cellStyle: CellStyle(
              numberFormat: NumFormat.defaultDate,
            ))
        ..updateCell(
            CellIndex.indexByColumnRow(columnIndex: 2, rowIndex: i + 1),
            TextCellValue(const TypeConverter().toJson(operation.type)))
        ..updateCell(
            CellIndex.indexByColumnRow(columnIndex: 3, rowIndex: i + 1),
            TextCellValue(operation.category))
        ..updateCell(
            CellIndex.indexByColumnRow(columnIndex: 4, rowIndex: i + 1),
            IntCellValue(operation.sum),
            cellStyle: CellStyle(
              numberFormat: NumFormat.defaultNumeric,
            ))
        ..updateCell(
            CellIndex.indexByColumnRow(columnIndex: 5, rowIndex: i + 1),
            TextCellValue(operation.subCategory))
        ..updateCell(
            CellIndex.indexByColumnRow(columnIndex: 6, rowIndex: i + 1),
            TextCellValue(operation.note));
    }

    // Сохранение файла Excel
    var fileBytes = excel.save();
    final directory = (await getApplicationDocumentsDirectory())?.path ?? '';
    print(directory);
    final path = '$directory/csv-${DateTime.now()}.csv';
    File(path)
      ..createSync(recursive: true)
      ..writeAsBytesSync(fileBytes!);
  }

  // Импорт операций из Excel файла
  Future<List<Operation>> importOperationsFromExcel() async {
    // Использование FilePicker для выбора файла
    FilePickerResult? result = await FilePicker.platform.pickFiles(
      allowedExtensions: ['xlsx'],
      // Убедитесь, что указан правильный тип расширения
      type: FileType.custom,
    );

    if (result == null || result.files.single.path == null) {
      // Пользователь отменил выбор файла
      return [];
    }

    // Получение пути к выбранному файлу
    final path = result.files.single.path!;
    var file = File(path);
    var bytes = file.readAsBytesSync();
    var excel = Excel.decodeBytes(bytes);

    // Предполагаем, что первый лист является нужным листом
    var sheet = excel.sheets.values.first;

    List<Operation> operations = [];
    // Пропускаем первую строку с заголовками
    for (final row in sheet.rows.skip(1)) {
      // Проверяем что row содержит достаточное количество ячеек
      if (row[0]?.value.toString() != 'null') {
        // Добавляем новый объект Operation в список
        // Здесь используется "?? DateTime.now()" как запасной вариант, если дата отсутствует или некорректна
        final operation = Operation(
          id: row[0]?.value.toString() ?? const Uuid().v4(),
          // ID операции
          date: DateTime.tryParse(row[1]?.value.toString() ?? '') ??
              DateTime.now(),
          // Дата операции, с возможностью исправления неправильных данных
          type: const TypeConverter()
              .fromJson(row[2]?.value.toString() ?? 'expense'),
          category: row[3]?.value.toString() ?? '',
          sum: int.tryParse(row[4]?.value.toString() ?? '0') ?? 0,
          subCategory: row[5]?.value.toString() == 'null' ? '' : row[5]?.value.toString() ?? '',
          note: row[6]?.value.toString() == 'null' ? '' : row[6]?.value.toString() ?? '',
        );
        print(const TypeConverter()
            .fromJson(row[2]?.value.toString() ?? ''));
        print(row[2]?.value);
        operations.add(operation);
      } else {
        // Возможно, стоит залогировать ошибку или уведомить пользователя
      }
    }

    return operations;
  }
}
