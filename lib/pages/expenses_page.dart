import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'package:mancon_app/models/expense.dart';
import 'package:mancon_app/models/expense_type.dart';
import 'package:mancon_app/services/expense_service.dart';
import 'package:mancon_app/state/expense_list.dart';
import 'package:mancon_app/utils/format_to_money.dart';
import 'package:mancon_app/widgets/confirmation_dialog.dart';
import 'package:mancon_app/widgets/expenses_expansion_panel.dart';
import 'package:mancon_app/widgets/notification_message.dart';
import 'package:provider/provider.dart';

class ExpensesPage extends StatefulWidget {
  const ExpensesPage({super.key});

  @override
  State<ExpensesPage> createState() => _ExpensesPageState();
}

class _ExpensesPageState extends State<ExpensesPage> {
  void confirmDeletion(Expense expense) async {
    int id = expense.id!;
    String description = expense.description;
    double totalPrice = expense.totalPrice!;

    if (await showDialog(
      context: context,
      builder: (BuildContext context) {
        return ConfirmationDialog(
            title: "Remover gasto",
            message:
                "Você tem certeza que deseja remover o gasto '$description' de ${formatToMoney(totalPrice)}?",
            cancelAction: () {
              Navigator.of(context).pop(false);
            },
            confirmAction: () {
              Navigator.of(context).pop(true);
            });
      },
    )) {
      http.Response response = await ExpenseService().deleteExpense(id: id);

      if (response.statusCode == 204) {
        Provider.of<ExpenseList>(
          context,
          listen: false,
        ).removeExpenseById(id);
        NotificationMessage().showNotification(
          message:
              "O gasto '$description' de ${formatToMoney(totalPrice)} foi removido.",
          context: context,
        );
      } else {
        NotificationMessage().showNotification(
          message:
              "Erro! Não foi possível remover o gasto '${expense.description}' de ${formatToMoney(expense.totalPrice!)}.",
          context: context,
          error: true,
        );
      }
    }
  }

  @override
  Widget build(BuildContext context) {
    ExpenseType type =
        ModalRoute.of(context)?.settings.arguments as ExpenseType;

    return Scaffold(
      appBar: AppBar(
        centerTitle: true,
        backgroundColor: Theme.of(context).colorScheme.primary,
        title: Stack(
          children: [
            Padding(
              padding: const EdgeInsets.only(right: 50),
              child: Image.asset(
                "assets/images/${type.imageName}",
                scale: 15,
              ),
            ),
            Padding(
              padding: const EdgeInsets.only(left: 50, top: 8),
              child: Text(
                type.name,
                style: const TextStyle(fontFamily: "inter", fontSize: 18),
              ),
            )
          ],
        ),
      ),
      body: Container(
        padding: const EdgeInsets.all(10),
        child: Column(
          mainAxisSize: MainAxisSize.max,
          children: [
            Padding(
              padding: const EdgeInsets.all(25),
              child: Center(
                child: Text(
                  formatToMoney(
                    Provider.of<ExpenseList>(context, listen: true)
                        .getAmmountByExpenseType(type.id!),
                  ),
                  style: const TextStyle(
                    fontFamily: "Inter",
                    fontSize: 30,
                  ),
                ),
              ),
            ),
            ExpensesExpansionPanel(
                expensesList: Provider.of<ExpenseList>(context, listen: true)
                    .getExpensesByType(type.id!),
                onDeletion: confirmDeletion,
                onEdition: (Expense expense) {
                  Navigator.pushNamed(
                    context,
                    "/expense-edit",
                    arguments: expense,
                  );
                })
          ],
        ),
      ),
      floatingActionButton: FloatingActionButton(
        backgroundColor: Theme.of(context).colorScheme.primary,
        elevation: 5,
        onPressed: () {
          Navigator.pushNamed(context, "/expense-add", arguments: type.id);
        },
        child: Icon(
          Icons.add,
          size: 35,
          color: Theme.of(context).colorScheme.secondary,
        ),
      ),
    );
  }
}
