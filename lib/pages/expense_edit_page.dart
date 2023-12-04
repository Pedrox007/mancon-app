// ignore_for_file: use_build_context_synchronously

import 'dart:convert';
import 'dart:io';

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
import 'package:mancon_app/widgets/file_input.dart';
import 'package:mancon_app/widgets/input.dart';
import 'package:mancon_app/utils/notification_message.dart';
import 'package:mancon_app/widgets/select_input.dart';
import 'package:provider/provider.dart';

class ExpenseEditPage extends StatefulWidget {
  const ExpenseEditPage({super.key});

  @override
  State<ExpenseEditPage> createState() => _ExpenseEditPageState();
}

class _ExpenseEditPageState extends State<ExpenseEditPage> {
  TextEditingController descriptionEC = TextEditingController();
  TextEditingController unitPriceEC = TextEditingController();
  double unitPriceValue = 0;
  TextEditingController quantityEC = TextEditingController();
  double quantityValue = 0;
  TextEditingController shippingPriceEC = TextEditingController();
  double shippingPriceValue = 0;
  List<ExpenseType>? expenseTypesList;
  int? typeId;
  int? expenseId;
  File? file;
  String? fileCurrentUrl;
  String? fileType;
  String? fileId;
  bool fileEdited = false;

  @override
  void initState() {
    super.initState();

    expenseTypesList =
        Provider.of<ExpenseTypeList>(context, listen: false).allExpenseTypes();
    unitPriceEC.addListener(() {
      setState(() {
        unitPriceValue = double.parse(
          unitPriceEC.text == ""
              ? "0"
              : unitPriceEC.text
                  .substring(3)
                  .replaceAll(".", "")
                  .replaceAll(",", "."),
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
        shippingPriceValue = double.parse(
          shippingPriceEC.text == ""
              ? "0"
              : shippingPriceEC.text
                  .substring(3)
                  .replaceAll(".", "")
                  .replaceAll(",", "."),
        );
      });
    });
  }

  @override
  void didChangeDependencies() {
    super.didChangeDependencies();

    Expense expense = ModalRoute.of(context)?.settings.arguments as Expense;
    setState(() {
      descriptionEC.text = expense.description;
      unitPriceEC.text = formatToMoney(expense.unitPrice);
      quantityEC.text = expense.quantity.toString();
      shippingPriceEC.text = formatToMoney(expense.shippingPrice);
      typeId = expense.typeId;
      expenseId = expense.id;
      fileId = expense.voucherFileId;
      fileType = expense.voucherFileType;
      fileCurrentUrl = expense.voucherFileURL;
    });
  }

  String getTotalPrice() {
    double value = unitPriceValue * quantityValue + shippingPriceValue;

    return formatToMoney(value);
  }

  void onFileSelected(File selectedFile, String type) {
    file = selectedFile;
    fileType = type;
    fileEdited = true;
  }

  void onFileRemoved() {
    file = null;
    fileType = null;
    fileEdited = true;
  }

  void saveExpense() async {
    User loggedUser = Provider.of<LoggedUser>(context, listen: false).user!;
    Expense expenseToCreate = Expense(
      typeId: typeId!,
      description: descriptionEC.text,
      owner: loggedUser.id!,
      quantity: quantityValue,
      unitPrice: unitPriceValue,
      shippingPrice: shippingPriceValue,
    );

    http.Response response = await ExpenseService().editExpense(
      expense: expenseToCreate.toMap(),
      voucherFile: file,
      voucherFileId: fileId,
      voucherFileType: fileType,
      voucherFileEdited: fileEdited,
      voucherCurrentFileUrl: fileCurrentUrl,
      id: expenseId!,
    );

    if (response.statusCode == 200) {
      Expense expenseEdited = Expense.fromMap(jsonDecode(response.body));
      Provider.of<ExpenseList>(
        context,
        listen: false,
      ).updateExpense(expenseEdited);
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
    return Scaffold(
      appBar: AppBar(
        centerTitle: true,
        backgroundColor: Theme.of(context).colorScheme.primary,
        title: Text(
          "Editar gasto",
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
              const Padding(
                padding: EdgeInsets.only(top: 10),
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
                padding: const EdgeInsets.only(top: 30),
                child: SelectInput(
                  label: "Tipo",
                  selection: typeId,
                  options: expenseTypesList!.map((element) {
                    return DropdownMenuEntry(
                      label: element.name,
                      value: element.id!,
                    );
                  }).toList(),
                ),
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
              Padding(
                padding: const EdgeInsets.only(top: 20),
                child: FileInput(
                  onSelected: onFileSelected,
                  onRemoved: onFileRemoved,
                  fileAlreadyAttached: fileId != null ? true : false,
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
