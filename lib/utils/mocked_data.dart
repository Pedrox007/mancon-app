import 'package:mancon_app/models/expense.dart';
import 'package:mancon_app/models/expense_type.dart';
import 'package:mancon_app/models/user.dart';

class MockData {
  User user = User.fromMap({
    "id": 1,
    "username": "teste",
    "email": "teste@teste.com",
    "first_name": "Pedro",
    "last_name": "Vicente"
  });
  List<Expense> expenses = [
    Expense.fromMap({
      "id": 1,
      "type_id": 1,
      "description": "teste 1",
      "quantity": 1.0,
      "unit_price": 101.0,
      "shipping_price": 10.0,
      "owner": 1
    }),
    Expense.fromMap({
      "id": 2,
      "type_id": 2,
      "description": "teste 2",
      "quantity": 1.0,
      "unit_price": 102.0,
      "shipping_price": 10.0,
      "owner": 1
    }),
    Expense.fromMap({
      "id": 3,
      "type_id": 3,
      "description": "teste 3",
      "quantity": 4.0,
      "unit_price": 103.0,
      "shipping_price": 10.0,
      "owner": 1
    }),
    Expense.fromMap({
      "id": 4,
      "type_id": 4,
      "description": "teste 4",
      "quantity": 1.0,
      "unit_price": 104.0,
      "shipping_price": 10.0,
      "owner": 1
    }),
    Expense.fromMap({
      "id": 5,
      "type_id": 5,
      "description": "teste 5",
      "quantity": 1.0,
      "unit_price": 105.0,
      "owner": 1
    }),
    Expense.fromMap({
      "id": 6,
      "type_id": 6,
      "description": "teste 6",
      "quantity": 1.0,
      "unit_price": 106.0,
      "shipping_price": 0.0,
      "owner": 1
    }),
    Expense.fromMap({
      "id": 7,
      "type_id": 1,
      "description": "teste 7",
      "quantity": 1.0,
      "unit_price": 107.0,
      "shipping_price": 20.0,
      "owner": 1
    }),
    Expense.fromMap({
      "id": 8,
      "type_id": 2,
      "description": "teste 8",
      "quantity": 2.0,
      "unit_price": 108.0,
      "shipping_price": 10.0,
      "owner": 1
    }),
  ];
  List<ExpenseType> expensesType = [
    ExpenseType.fromMap({
      "id": 1,
      "name": "Alvenaria",
      "image_name": "alvenaria_logo.png",
    }),
    ExpenseType.fromMap({
      "id": 2,
      "name": "Elétrica/Dados",
      "image_name": "eletrica_dados_logo.png",
    }),
    ExpenseType.fromMap({
      "id": 3,
      "name": "Hidráulica",
      "image_name": "hidraulica_logo.png",
    }),
    ExpenseType.fromMap({
      "id": 4,
      "name": "Mão de Obra",
      "image_name": "mao_obra_logo.png",
    }),
    ExpenseType.fromMap({
      "id": 5,
      "name": "Acabamento",
      "image_name": "acabamento_logo.png",
    }),
    ExpenseType.fromMap({
      "id": 6,
      "name": "Equipamentos",
      "image_name": "equipamentos_logo.png",
    }),
  ];
}
