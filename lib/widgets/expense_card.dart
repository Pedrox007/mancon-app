import 'package:flutter/material.dart';
import 'package:mancon_app/models/expense_type.dart';
import 'package:mancon_app/utils/format_to_money.dart';

class ExpenseCard extends StatelessWidget {
  final ExpenseType type;
  final double totalAmmount;

  const ExpenseCard(
      {super.key, required this.type, required this.totalAmmount});

  @override
  Widget build(BuildContext context) {
    return Card(
      child: GestureDetector(
        onTap: () {
          Navigator.pushNamed(context, "/expenses", arguments: type);
        },
        child: Container(
          decoration: BoxDecoration(
              color: Theme.of(context).colorScheme.background,
              borderRadius: const BorderRadius.all(Radius.circular(10)),
              border: Border.all(color: Theme.of(context).colorScheme.primary)),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.center,
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              CircleAvatar(
                backgroundColor: Theme.of(context).colorScheme.primaryContainer,
                radius: 25,
                child: Image.asset(
                  "assets/images/${type.imageName}",
                  scale: 15,
                ),
              ),
              const SizedBox(
                height: 10,
              ),
              Text(
                type.name,
                style: const TextStyle(fontFamily: "inter", fontSize: 15),
              ),
              const SizedBox(
                height: 10,
              ),
              Text(
                "R\$ ${formatToMoney(totalAmmount).toString()}",
                style: const TextStyle(fontFamily: "inter", fontSize: 20),
              )
            ],
          ),
        ),
      ),
    );
  }
}
