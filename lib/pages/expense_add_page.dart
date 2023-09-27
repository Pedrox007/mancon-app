import 'package:flutter/material.dart';
import 'package:currency_text_input_formatter/currency_text_input_formatter.dart';
import 'package:mancon_app/models/expense.dart';
import 'package:mancon_app/models/expense_type.dart';
import 'package:mancon_app/models/user.dart';
import 'package:mancon_app/state/expense_list.dart';
import 'package:mancon_app/state/logged_user.dart';
import 'package:mancon_app/utils/format_to_money.dart';
import 'package:mancon_app/utils/mocked_data.dart';
import 'package:mancon_app/widgets/button.dart';
import 'package:mancon_app/widgets/input.dart';
import 'package:mancon_app/widgets/select_input.dart';
import 'package:provider/provider.dart';

class ExpenseAddPage extends StatefulWidget {
  const ExpenseAddPage({super.key});

  @override
  State<ExpenseAddPage> createState() => _ExpenseAddPageState();
}

class _ExpenseAddPageState extends State<ExpenseAddPage> {
  TextEditingController descriptionEC = TextEditingController();
  TextEditingController unitPriceEC = TextEditingController();
  double unitPriceValue = 0;
  TextEditingController quantityEC = TextEditingController();
  double quantityValue = 0;
  TextEditingController shippingPriceEC = TextEditingController();
  double shippingPriceValue = 0;
  List<ExpenseType>? expensesList;
  int? typeId;

  @override
  void initState() {
    super.initState();

    expensesList = MockData().expensesType;
    unitPriceEC.addListener(() {
      setState(() {
        unitPriceValue = double.parse(
            unitPriceEC.text == "" ? "0" : unitPriceEC.text.substring(3));
      });
    });
    quantityEC.addListener(() {
      setState(() {
        quantityValue =
            double.parse(quantityEC.text == "" ? "0" : quantityEC.text);
      });
    });
    shippingPriceEC.addListener(() {
      setState(() {
        shippingPriceValue = double.parse(shippingPriceEC.text == ""
            ? "0"
            : shippingPriceEC.text.substring(3));
      });
    });
  }

  String getTotalPrice() {
    double value = unitPriceValue * quantityValue + shippingPriceValue;

    return formatToMoney(value);
  }

  void saveExpense() {
    User loggedUser = Provider.of<LoggedUser>(context, listen: false).user!;
    Expense newExpense = Expense(
        typeId: typeId!,
        description: descriptionEC.text,
        owner: loggedUser.id!,
        quantity: quantityValue,
        unitPrice: unitPriceValue,
        shippingPrice: shippingPriceValue);

    Provider.of<ExpenseList>(context, listen: false).addExpense(newExpense);
  }

  @override
  Widget build(BuildContext context) {
    typeId = ModalRoute.of(context)?.settings.arguments as int;

    return Scaffold(
      appBar: AppBar(
        centerTitle: true,
        backgroundColor: Theme.of(context).colorScheme.primary,
        title: const Text(
          "Adicionar gasto",
          style: TextStyle(fontFamily: "inter", fontSize: 18),
        ),
      ),
      body: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.symmetric(vertical: 25, horizontal: 10),
          child: Column(
            mainAxisSize: MainAxisSize.max,
            children: [
              SelectInput(
                label: "Tipo",
                selection: typeId,
                options: expensesList!.map((element) {
                  return DropdownMenuEntry(
                      label: element.name, value: element.id!);
                }).toList(),
              ),
              Padding(
                padding: const EdgeInsets.only(top: 20),
                child: Input(
                  label: "Descrição",
                  type: TextInputType.text,
                  controller: descriptionEC,
                ),
              ),
              Padding(
                padding: const EdgeInsets.only(top: 20),
                child: Input(
                  label: "Preço unitário",
                  type: const TextInputType.numberWithOptions(decimal: true),
                  controller: unitPriceEC,
                  inputFormatters: [
                    CurrencyTextInputFormatter(decimalDigits: 2, symbol: "R\$ ")
                  ],
                ),
              ),
              Padding(
                padding: const EdgeInsets.only(top: 20),
                child: Input(
                  label: "Quantidade",
                  type: const TextInputType.numberWithOptions(decimal: true),
                  controller: quantityEC,
                ),
              ),
              Padding(
                padding: const EdgeInsets.only(top: 20),
                child: Input(
                  label: "Frete",
                  type: const TextInputType.numberWithOptions(decimal: true),
                  controller: shippingPriceEC,
                  inputFormatters: [
                    CurrencyTextInputFormatter(decimalDigits: 2, symbol: "R\$ ")
                  ],
                ),
              ),
              const Padding(
                padding: EdgeInsets.only(top: 65),
                child: Text("Total gasto",
                    style: TextStyle(fontFamily: "inter", fontSize: 25)),
              ),
              Padding(
                padding: const EdgeInsets.only(top: 10),
                child: Text("R\$ ${getTotalPrice()}",
                    style: const TextStyle(fontFamily: "inter", fontSize: 35)),
              ),
              Padding(
                padding: const EdgeInsets.only(top: 65),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Button(
                      label: "Cancelar",
                      onPressed: () {
                        Navigator.pop(context);
                      },
                      secondary: true,
                      width: 150,
                    ),
                    Button(
                      label: "Confirmar",
                      onPressed: () {
                        saveExpense();
                        Navigator.pop(context);
                      },
                      width: 150,
                    )
                  ],
                ),
              )
            ],
          ),
        ),
      ),
    );
  }
}
