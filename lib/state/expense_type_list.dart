import 'package:flutter/material.dart';
import 'package:mancon_app/models/expense_type.dart';

class ExpenseTypeList with ChangeNotifier {
  List<ExpenseType> _expenseTypes = [];

  List<ExpenseType> allExpenseTypes() {
    return _expenseTypes.toList();
  }

  void setExpenseTypes(List<ExpenseType> expenses) {
    _expenseTypes = expenses;
    notifyListeners();
  }

  ExpenseType getExpenseTypeById(int typeId) {
    return _expenseTypes.firstWhere((element) => element.id == typeId);
  }
}
