import 'package:finplan24/domain/domain.dart';
import 'package:intl/intl.dart';

enum OperationViewFilter { all, activeOnly, completedOnly }

extension OperationViewFilterX on OperationViewFilter {
  bool apply(Operation operation) {
    switch (this) {
      case OperationViewFilter.all:
        return true;
      case OperationViewFilter.activeOnly:
        return true;
      case OperationViewFilter.completedOnly:
        return true;
    }
  }

  Iterable<Operation> applyAll(Iterable<Operation> operation) {
    return operation.where(apply);
  }
}

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

  static List<OperationsFiltered> sortByDay(List<Operation> operations) {
    // Сортировка списка операций по дате
    operations.sort((a, b) => b.date.compareTo(a.date));

// Группировка операций по дням
    var groupedOperations = <String, List<Operation>>{};
    for (var operation in operations) {
      String formattedDate = DateFormat('yyyy-MM-dd').format(operation.date);
      if (!groupedOperations.containsKey(formattedDate)) {
        groupedOperations[formattedDate] = [];
      }
      groupedOperations[formattedDate]!.add(operation);
    }

// Создание списка OperationsFiltered с операциями для каждого дня
    List<OperationsFiltered> filteredOperationsList = [];
    groupedOperations.forEach((dateString, operations) {
      var date = DateFormat('yyyy-MM-dd').parse(dateString);
      var sumIncome = operations.where((o) => o.type == Type.income).fold(0, (a, b) => a + b.sum);
      var sumExpense = operations.where((o) => o.type == Type.expense).fold(0, (a, b) => a + b.sum);

      filteredOperationsList.add(OperationsFiltered(
        date: date,
        sumIncome: sumIncome,
        sumExpense: sumExpense,
        operationsPerDay: operations,
      ));
    });

    return filteredOperationsList;
  }
}
