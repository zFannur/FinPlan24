import 'package:finplan24/domain/domain.dart';
import 'package:intl/intl.dart';

final class OperationViewFilter {
  const OperationViewFilter({
    this.type,
    this.category,
    this.sum,
    this.subCategory,
  });

  final Type? type;
  final String? category;
  final int? sum;
  final String? subCategory;

  OperationViewFilter copyWith({
    Type? type,
    String? category,
    int? sum,
    String? subCategory,
  }) {
    return OperationViewFilter(
      type: type ?? this.type,
      category: category ?? this.category,
      sum: sum ?? this.sum,
      subCategory: subCategory ?? this.subCategory,
    );
  }
}

// extension OperationViewFilterX on OperationViewFilter {
//   bool apply(Operation operation) {
//     switch (this) {
//       case OperationViewFilter.all:
//         return true;
//       case OperationViewFilter.activeOnly:
//         return true;
//       case OperationViewFilter.completedOnly:
//         return true;
//     }
//   }
//
//   Iterable<Operation> applyAll(Iterable<Operation> operation) {
//     return operation.where(apply);
//   }
// }

class OperationsFiltered {
  OperationsFiltered({
    required this.sumExpense,
    required this.sumIncome,
    required this.date,
    required this.operationsPerDay,
  });

  int sumExpense;
  int sumIncome;
  DateTime date;
  List<Operation> operationsPerDay;

  static int getSumIncome(
      List<Operation> operations,
      String? searchWord,
      ) {
    List<Operation> filteredOperations = _searchOperations(operations, searchWord);
    final sumIncome = filteredOperations
        .where((o) => o.type == Type.income)
        .fold(0, (a, b) => a + b.sum);
    return sumIncome;
  }

  static int getSumExpense(
      List<Operation> operations,
      String? searchWord,
      ) {
    List<Operation> filteredOperations = _searchOperations(operations, searchWord);
    final sumExpense = filteredOperations
        .where((o) => o.type == Type.expense)
        .fold(0, (a, b) => a + b.sum);
    return sumExpense;
  }

  static List<Operation> _searchOperations(
      List<Operation> operations,
      String? searchWord,
      ) {
    if (searchWord != null) {
      return operations
          .where(
            (element) =>
        element.category.contains(searchWord) ||
            element.sum.toString().contains(searchWord) ||
            element.subCategory.contains(searchWord),
      )
          .toList();
    } else {
      return operations;
    }
  }

  static List<OperationsFiltered> sortByDay(
    List<Operation> operations,
    String? searchWord,
  ) {
    List<Operation> filteredOperations = _searchOperations(operations, searchWord);

    // Сортировка списка операций по дате
    filteredOperations.sort((a, b) => b.date.compareTo(a.date));

// Группировка операций по дням
    var groupedOperations = <String, List<Operation>>{};
    for (final operation in filteredOperations) {
      final formattedDate = DateFormat('yyyy-MM-dd').format(operation.date);
      if (!groupedOperations.containsKey(formattedDate)) {
        groupedOperations[formattedDate] = [];
      }
      groupedOperations[formattedDate]!.add(operation);
    }

// Создание списка OperationsFiltered с операциями для каждого дня
    final filteredOperationsList = <OperationsFiltered>[];
    groupedOperations.forEach((dateString, filteredOperations) {
      final date = DateFormat('yyyy-MM-dd').parse(dateString);
      final sumIncome = filteredOperations
          .where((o) => o.type == Type.income)
          .fold(0, (a, b) => a + b.sum);
      final sumExpense = filteredOperations
          .where((o) => o.type == Type.expense)
          .fold(0, (a, b) => a + b.sum);

      filteredOperationsList.add(
        OperationsFiltered(
          date: date,
          sumIncome: sumIncome,
          sumExpense: sumExpense,
          operationsPerDay: filteredOperations,
        ),
      );
    });

    return filteredOperationsList;
  }
}
