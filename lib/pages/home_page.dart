import 'dart:convert';

import 'package:custom_refresh_indicator/custom_refresh_indicator.dart';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'package:mancon_app/models/expense.dart';
import 'package:mancon_app/models/expense_type.dart';
import 'package:mancon_app/models/user.dart';
import 'package:mancon_app/services/expense_service.dart';
import 'package:mancon_app/services/expense_type_service.dart';
import 'package:mancon_app/state/expense_list.dart';
import 'package:mancon_app/state/expense_type_list.dart';
import 'package:mancon_app/state/logged_user.dart';
import 'package:mancon_app/utils/sliver_header_delegate.dart';
import 'package:mancon_app/widgets/expense_card.dart';
import 'package:mancon_app/widgets/notification_message.dart';
import 'package:provider/provider.dart';

class HomePage extends StatefulWidget {
  const HomePage({super.key});

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  final controller = ScrollController();
  double appBarHeight = 200.0;
  final List<ExpenseType> _expensesTypes = [];
  bool initialLoading = false;
  bool scrollLoading = false;

  @override
  void initState() {
    super.initState();
    WidgetsBinding.instance.addPostFrameCallback((timeStamp) async {
      setState(() {
        initialLoading = true;
      });
      await fetchExpenseTypes(context);
      await fetchExpenses(context);
      setState(() {
        initialLoading = false;
      });
    });
  }

  Future<void> fetchExpenses(BuildContext context) async {
    User loggedUser = Provider.of<LoggedUser>(context, listen: false).user!;
    http.Response expenseResponse = await ExpenseService().getExpenses(
      ownerId: loggedUser.id!,
    );

    if (expenseResponse.statusCode == 200) {
      var body = jsonDecode(expenseResponse.body);
      List<Expense> expenses = [];
      body.forEach((element) {
        expenses.add(Expense.fromMap(element));
      });

      Provider.of<ExpenseList>(context, listen: false).setExpenses(expenses);
    } else {
      NotificationMessage().showNotification(
        message: "Erro! Não foi possível capturar dados de de gastos.",
        context: context,
        error: true,
      );
    }
  }

  Future<void> fetchExpenseTypes(BuildContext context) async {
    if (_expensesTypes.isEmpty) {
      http.Response expenseTypeResponse =
          await ExpenseTypeService().getExpenseTypes();

      if (expenseTypeResponse.statusCode == 200) {
        var body = jsonDecode(expenseTypeResponse.body);

        body.forEach((element) {
          String name = utf8.decode(element["name"].runes.toList());
          String imagePath =
              "${name.replaceAll("/", "_").replaceAll(" ", "_")}.png"
                  .toLowerCase();

          ExpenseType expenseType = ExpenseType(
            id: element["id"],
            name: name,
            imageName: imagePath,
          );

          _expensesTypes.add(expenseType);
        });

        Provider.of<ExpenseTypeList>(context, listen: false)
            .setExpenseTypes(_expensesTypes);
      } else {
        NotificationMessage().showNotification(
          message: "Erro! Não foi possível capturar dados de tipos de gastos.",
          context: context,
          error: true,
        );
      }
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      floatingActionButton: FloatingActionButton(
        backgroundColor: Theme.of(context).colorScheme.primary,
        elevation: 5,
        onPressed: () {
          Navigator.pushNamed(context, "/user-details");
        },
        child: Icon(
          Icons.person_outlined,
          size: 35,
          color: Theme.of(context).colorScheme.secondary,
        ),
      ),
      body: Padding(
        padding: EdgeInsets.only(
          top: MediaQuery.of(context).padding.top,
        ),
        child: CustomRefreshIndicator(
          onRefresh: () async {
            setState(() {
              scrollLoading = true;
            });
            await fetchExpenseTypes(context);
            await fetchExpenses(context);
            setState(() {
              scrollLoading = false;
            });
          },
          builder: MaterialIndicatorDelegate(
            backgroundColor: Colors.transparent,
            elevation: 0,
            edgeOffset: 200,
            builder: (context, controller) {
              return CircularProgressIndicator(
                color: Theme.of(context).colorScheme.secondary,
              );
            },
          ),
          child: CustomScrollView(
            controller: controller,
            slivers: <Widget>[
              SliverPersistentHeader(
                delegate: PersonalSliverHeaderDelegate(
                  totalAmmount: Provider.of<ExpenseList>(context, listen: true)
                      .getAmmountSum(),
                  loading: initialLoading | scrollLoading,
                ),
                pinned: true,
                floating: true,
              ),
              SliverPadding(
                padding: const EdgeInsets.only(bottom: 80),
                sliver: initialLoading
                    ? SliverList(
                        delegate: SliverChildBuilderDelegate(
                          (BuildContext context, int index) {
                            return Container(
                              padding: const EdgeInsets.only(top: 30),
                              alignment: Alignment.center,
                              height: 70,
                              child: CircularProgressIndicator(
                                color: Theme.of(context).colorScheme.secondary,
                              ),
                            );
                          },
                          childCount: 1,
                        ),
                      )
                    : SliverGrid(
                        gridDelegate:
                            const SliverGridDelegateWithMaxCrossAxisExtent(
                          maxCrossAxisExtent: 180,
                          mainAxisSpacing: 10,
                          crossAxisSpacing: 10,
                        ),
                        delegate: SliverChildBuilderDelegate(
                          (BuildContext context, int index) {
                            return Padding(
                              padding: const EdgeInsets.all(10),
                              child: ExpenseCard(
                                type: _expensesTypes.elementAt(index),
                                totalAmmount: Provider.of<ExpenseList>(
                                  context,
                                  listen: true,
                                ).getAmmountByExpenseType(
                                  _expensesTypes.elementAt(index).id!,
                                ),
                                loading: scrollLoading,
                              ),
                            );
                          },
                          childCount: _expensesTypes.length,
                        ),
                      ),
              )
            ],
          ),
        ),
      ),
    );
  }
}
