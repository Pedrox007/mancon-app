import 'package:flutter/material.dart';
import 'package:flutter_slidable/flutter_slidable.dart';
import 'package:mancon_app/models/expense.dart';
import 'package:mancon_app/utils/format_to_money.dart';
import 'package:mancon_app/widgets/line_card.dart';

class ExpensesExpansionPanel extends StatelessWidget {
  final List expensesList;

  final void Function(Expense) onDeletion;

  const ExpensesExpansionPanel(
      {super.key, required this.expensesList, required this.onDeletion});

  @override
  Widget build(BuildContext context) {
    return Expanded(
      child: ListView.separated(
        separatorBuilder: (context, index) => const SizedBox(
          height: 13,
        ),
        itemCount: expensesList.length,
        itemBuilder: (context, i) {
          return Slidable(
            key: Key(i.toString()),
            startActionPane: ActionPane(
              extentRatio: 0.3,
              motion: const BehindMotion(),
              children: [
                SlidableAction(
                  spacing: 12,
                  onPressed: (BuildContext context) {
                    onDeletion(expensesList[i]);
                  },
                  backgroundColor: Theme.of(context).colorScheme.error,
                  icon: Icons.delete,
                  label: "Remover",
                  borderRadius: const BorderRadius.only(
                    topLeft: Radius.circular(10),
                    bottomLeft: Radius.circular(10),
                    topRight: Radius.circular(10),
                    bottomRight: Radius.circular(10),
                  ),
                  padding: const EdgeInsets.all(8),
                )
              ],
            ),
            endActionPane: ActionPane(
              extentRatio: 0.3,
              motion: const BehindMotion(),
              children: [
                SlidableAction(
                  spacing: 12,
                  onPressed: (context) {
                    print("item para editar");
                  },
                  backgroundColor: Theme.of(context).colorScheme.primary,
                  icon: Icons.edit,
                  label: "Editar",
                  foregroundColor: Theme.of(context).colorScheme.secondary,
                  borderRadius: const BorderRadius.all(Radius.circular(10)),
                  padding: const EdgeInsets.all(8),
                )
              ],
            ),
            child: LineCard(
              child: ExpansionTile(
                title: Row(
                  children: [
                    Text(
                      expensesList[i].description,
                      style: const TextStyle(fontFamily: "inter", fontSize: 18),
                    ),
                    const Spacer(),
                    Text(
                      formatToMoney(expensesList[i].totalPrice!),
                      style: const TextStyle(fontFamily: "inter", fontSize: 18),
                    )
                  ],
                ),
                children: [
                  ListTile(
                    subtitle: Column(
                      children: [
                        Padding(
                          padding: const EdgeInsets.only(bottom: 8),
                          child: Row(
                            children: [
                              const Text(
                                "Preço unitário",
                                style: TextStyle(
                                  fontFamily: "inter",
                                  fontSize: 12,
                                ),
                              ),
                              const Spacer(),
                              Text(
                                formatToMoney(
                                  expensesList[i].unitPrice,
                                ),
                                style: const TextStyle(
                                  fontFamily: "inter",
                                  fontSize: 12,
                                ),
                              )
                            ],
                          ),
                        ),
                        Padding(
                          padding: const EdgeInsets.only(bottom: 8),
                          child: Row(
                            children: [
                              const Text(
                                "Quantidade",
                                style: TextStyle(
                                  fontFamily: "inter",
                                  fontSize: 12,
                                ),
                              ),
                              const Spacer(),
                              Text(
                                expensesList[i].quantity.toString(),
                                style: const TextStyle(
                                  fontFamily: "inter",
                                  fontSize: 12,
                                ),
                              )
                            ],
                          ),
                        ),
                        Padding(
                          padding: const EdgeInsets.only(bottom: 8),
                          child: Row(
                            children: [
                              const Text(
                                "Frete",
                                style: TextStyle(
                                  fontFamily: "inter",
                                  fontSize: 12,
                                ),
                              ),
                              const Spacer(),
                              Text(
                                formatToMoney(
                                  expensesList[i].shippingPrice,
                                ),
                                style: const TextStyle(
                                  fontFamily: "inter",
                                  fontSize: 12,
                                ),
                              )
                            ],
                          ),
                        ),
                      ],
                    ),
                  )
                ],
              ),
            ),
          );
        },
      ),
    );
  }
}
