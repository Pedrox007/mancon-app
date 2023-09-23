import 'package:mancon_app/models/expense.dart';
import 'package:mancon_app/models/expense_type.dart';
import 'package:mancon_app/models/user.dart';

class MockData {
  User user = User.fromMap({"id": 1, "username": "teste"});
  List<Expense> expenses = [
    Expense.fromMap({
      "id": 1,
      "typeId": 1,
      "description": "teste 1",
      "amount_spent": 100.0,
      "owner": 1
    }),
    Expense.fromMap({
      "id": 2,
      "typeId": 2,
      "description": "teste 2",
      "amount_spent": 100.0,
      "owner": 1
    }),
    Expense.fromMap({
      "id": 3,
      "typeId": 3,
      "description": "teste 3",
      "amount_spent": 100.0,
      "owner": 1
    }),
    Expense.fromMap({
      "id": 4,
      "typeId": 4,
      "description": "teste 4",
      "amount_spent": 100.0,
      "owner": 1
    }),
    Expense.fromMap({
      "id": 5,
      "typeId": 5,
      "description": "teste 5",
      "amount_spent": 100.0,
      "owner": 1
    }),
    Expense.fromMap({
      "id": 6,
      "typeId": 6,
      "description": "teste 6",
      "amount_spent": 100.0,
      "owner": 1
    }),
    Expense.fromMap({
      "id": 7,
      "typeId": 1,
      "description": "teste 7",
      "amount_spent": 100.0,
      "owner": 1
    }),
    Expense.fromMap({
      "id": 8,
      "typeId": 2,
      "description": "teste 8",
      "amount_spent": 100.0,
      "owner": 1
    })
  ];
  List<ExpenseType> expensesType = [
    ExpenseType.fromMap(
        {"id": 1, "name": "Alvenaria", "image_name": "alvenaria_logo.png"}),
    ExpenseType.fromMap({
      "id": 2,
      "name": "Elétrica/Dados",
      "image_name": "eletrica_dados_logo.png"
    }),
    ExpenseType.fromMap(
        {"id": 3, "name": "Hidráulica", "image_name": "hidraulica_logo.png"}),
    ExpenseType.fromMap(
        {"id": 4, "name": "Mão de Obra", "image_name": "mao_obra_logo.png"}),
    ExpenseType.fromMap(
        {"id": 5, "name": "Acabamento", "image_name": "acabamento_logo.png"}),
    ExpenseType.fromMap({
      "id": 6,
      "name": "Equipamentos",
      "image_name": "equipamentos_logo.png"
    }),
  ];
}
