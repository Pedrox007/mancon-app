import 'package:flutter/material.dart';
import 'package:mancon_app/models/expense.dart';
import 'package:mancon_app/utils/mocked_data.dart';

class ExpenseList with ChangeNotifier {
  List<Expense> _expenses = [];

  List<Expense> allExpenses() {
    return _expenses.toList();
  }

  List<Expense> expenseByType(int typeId) {
    return _expenses.where((element) => element.typeId == typeId).toList();
  }

  double getAmmountSum() {
    double sum = _expenses.fold(
        0,
        (previousValue, element) =>
            previousValue.toDouble() + element.amountSpent);

    return sum;
  }

  double getAmmountByExpenseType(int typeId) {
    double sum = _expenses.fold(
        0,
        (previousValue, element) =>
            previousValue.toDouble() + element.typeId == typeId
                ? element.amountSpent
                : 0);

    return sum;
  }

  void setMockedExpenses() {
    _expenses = MockData().expenses;
  }

  void addExpense(Expense expense) {
    _expenses.add(expense);
    notifyListeners();
  }

  void removeExpenseById(int id) {
    _expenses.removeWhere((element) => element.id == id);
    notifyListeners();
  }

  void updateExpense(Expense expense) {
    int index = _expenses.indexWhere((element) => element.id == expense.id);
    _expenses[index] = expense;
    notifyListeners();
  }
}
