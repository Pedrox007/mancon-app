import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:currency_text_input_formatter/currency_text_input_formatter.dart';
import 'package:flutter/services.dart';
import 'package:http/http.dart' as http;
import 'package:mancon_app/models/expense.dart';
import 'package:mancon_app/models/expense_type.dart';
import 'package:mancon_app/models/user.dart';
import 'package:mancon_app/services/expense_service.dart';
import 'package:mancon_app/state/expense_list.dart';
import 'package:mancon_app/state/expense_type_list.dart';
import 'package:mancon_app/state/logged_user.dart';
import 'package:mancon_app/utils/format_to_money.dart';
import 'package:mancon_app/widgets/button.dart';
import 'package:mancon_app/widgets/input.dart';
import 'package:mancon_app/widgets/notification_message.dart';
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

    expensesList =
        Provider.of<ExpenseTypeList>(context, listen: false).allExpenseTypes();
    unitPriceEC.addListener(() {
      setState(() {
        unitPriceValue = double.parse(
          unitPriceEC.text == ""
              ? "0"
              : unitPriceEC.text.substring(3).replaceAll(",", ""),
        );
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
            : shippingPriceEC.text.substring(3).replaceAll(",", ""));
      });
    });
  }

  String getTotalPrice() {
    double value = unitPriceValue * quantityValue + shippingPriceValue;

    return formatToMoney(value);
  }

  void saveExpense() async {
    User loggedUser = Provider.of<LoggedUser>(context, listen: false).user!;
    Expense expenseToCreate = Expense(
        typeId: typeId!,
        description: descriptionEC.text,
        owner: loggedUser.id!,
        quantity: quantityValue,
        unitPrice: unitPriceValue,
        shippingPrice: shippingPriceValue);

    http.Response response =
        await ExpenseService().createExpense(expense: expenseToCreate.toMap());

    if (response.statusCode == 201) {
      Expense newExpense = Expense.fromMap(jsonDecode(response.body));
      Provider.of<ExpenseList>(
        context,
        listen: false,
      ).addExpense(newExpense);
      Navigator.pop(context);
    } else {
      NotificationMessage().showNotification(
        message: "Erro! Não foi possível salvar o novo gasto.",
        context: context,
        error: true,
      );
    }
  }

  @override
  Widget build(BuildContext context) {
    typeId = ModalRoute.of(context)?.settings.arguments as int;

    return Scaffold(
      appBar: AppBar(
        centerTitle: true,
        backgroundColor: Theme.of(context).colorScheme.primary,
        title: Text(
          "Adicionar gasto",
          style: TextStyle(
              fontFamily: "inter",
              fontSize: 18,
              color: Theme.of(context).colorScheme.secondary),
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
                    label: element.name,
                    value: element.id!,
                  );
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
                    FilteringTextInputFormatter.allow(RegExp("[0-9a-zA-Z]")),
                    CurrencyTextInputFormatter(
                      locale: "pt_BR",
                      decimalDigits: 2,
                      symbol: "R\$ ",
                    ),
                  ],
                ),
              ),
              Padding(
                padding: const EdgeInsets.only(top: 20),
                child: Input(
                  label: "Quantidade",
                  type: const TextInputType.numberWithOptions(decimal: true),
                  controller: quantityEC,
                  inputFormatters: [
                    FilteringTextInputFormatter.allow(
                      RegExp(r"[0-9]+[.]{0,1}[0-9]*"),
                    ),
                  ],
                ),
              ),
              Padding(
                padding: const EdgeInsets.only(top: 20),
                child: Input(
                  label: "Frete",
                  type: const TextInputType.numberWithOptions(decimal: true),
                  controller: shippingPriceEC,
                  inputFormatters: [
                    FilteringTextInputFormatter.allow(RegExp("[0-9a-zA-Z]")),
                    CurrencyTextInputFormatter(
                      locale: "pt_BR",
                      decimalDigits: 2,
                      symbol: "R\$ ",
                    ),
                  ],
                ),
              ),
              const Padding(
                padding: EdgeInsets.only(top: 65),
                child: Text(
                  "Total gasto",
                  style: TextStyle(fontFamily: "inter", fontSize: 25),
                ),
              ),
              Padding(
                padding: const EdgeInsets.only(top: 10),
                child: Text(
                  getTotalPrice(),
                  style: const TextStyle(fontFamily: "inter", fontSize: 35),
                ),
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
