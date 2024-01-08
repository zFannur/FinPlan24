import 'dart:convert';
import 'dart:io';

import 'package:bloc/bloc.dart';
import 'package:csv/csv.dart';
import 'package:equatable/equatable.dart';
import 'package:file_picker/file_picker.dart';
import 'package:finplan24/domain/domain.dart';
import 'package:intl/intl.dart';
import 'package:path_provider/path_provider.dart';

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

  Future<void> saveData(List<Operation> operations, {bool delete = true}) async {
    return operationsRepository.addFromFile(operations, delete: delete);
  }
}
