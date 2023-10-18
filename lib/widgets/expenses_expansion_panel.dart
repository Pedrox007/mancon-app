import 'package:flutter/material.dart';
import 'package:mancon_app/utils/format_to_money.dart';
import 'package:mancon_app/widgets/line_card.dart';

class ExpensesExpansionPanel extends StatelessWidget {
  final List expensesList;

  const ExpensesExpansionPanel({super.key, required this.expensesList});

  @override
  Widget build(BuildContext context) {
    return Expanded(
      child: ListView.builder(
        itemCount: expensesList.length,
        itemBuilder: (context, i) {
          return LineCard(
            child: ExpansionTile(
              title: Row(
                children: [
                  Text(
                    expensesList[i].description,
                    style: const TextStyle(fontFamily: "inter", fontSize: 18),
                  ),
                  const Spacer(),
                  Text(
                    "R\$ ${formatToMoney(expensesList[i].totalPrice!)}",
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
                              "R\$ ${formatToMoney(
                                expensesList[i].unitPrice,
                              )}",
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
                              "R\$ ${formatToMoney(
                                expensesList[i].shippingPrice,
                              )}",
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
          );
        },
      ),
    );
  }
}
