import 'package:flutter/material.dart';
import 'package:mancon_app/models/expense_type.dart';
import 'package:mancon_app/state/expense_list.dart';
import 'package:mancon_app/widgets/expenses_expansion_panel.dart';
import 'package:provider/provider.dart';

class ExpensesPage extends StatefulWidget {
  const ExpensesPage({super.key});

  @override
  State<ExpensesPage> createState() => _ExpensesPageState();
}

class _ExpensesPageState extends State<ExpensesPage> {
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
                style: const TextStyle(fontFamily: "inter", fontSize: 15),
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
                    "R\$ ${Provider.of<ExpenseList>(context, listen: true).getAmmountByExpenseType(type.id!)}",
                    style: const TextStyle(
                      fontFamily: "Inter",
                      fontSize: 30,
                    )),
              ),
            ),
            ExpensesExpansionPanel(
                expensesList: Provider.of<ExpenseList>(context, listen: true)
                    .getExpensesByType(type.id!))
          ],
        ),
      ),
      floatingActionButton: FloatingActionButton(
        backgroundColor: Theme.of(context).colorScheme.primary,
        elevation: 5,
        onPressed: () {},
        child: const Icon(Icons.add, size: 35),
      ),
    );
  }
}
