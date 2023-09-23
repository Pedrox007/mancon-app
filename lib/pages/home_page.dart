import 'package:flutter/material.dart';
import 'package:mancon_app/models/expense_type.dart';
import 'package:mancon_app/models/user.dart';
import 'package:mancon_app/state/expense_list.dart';
import 'package:mancon_app/state/logged_user.dart';
import 'package:mancon_app/utils/mocked_data.dart';
import 'package:mancon_app/utils/sliver_header_delegate.dart';
import 'package:mancon_app/widgets/expense_card.dart';
import 'package:mancon_app/widgets/logo.dart';
import 'package:provider/provider.dart';

class HomePage extends StatefulWidget {
  const HomePage({super.key, required this.title});

  final String title;

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  final controller = ScrollController();
  double appBarHeight = 200.0;
  final List<ExpenseType> _expensesTypes = MockData().expensesType;

  @override
  void initState() {
    super.initState();
    WidgetsBinding.instance.addPostFrameCallback((timeStamp) {
      fetchExpenses(context);
    });
  }

  Future<void> fetchExpenses(BuildContext context) async {
    Provider.of<ExpenseList>(context, listen: false).setMockedExpenses();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        body: Padding(
      padding: EdgeInsets.only(top: MediaQuery.of(context).padding.top),
      child: CustomScrollView(
        controller: controller,
        slivers: <Widget>[
          SliverPersistentHeader(
            delegate: PersonalSliverHeaderDelegate(
                totalAmmount: Provider.of<ExpenseList>(context, listen: true)
                    .getAmmountSum()),
            pinned: true,
            floating: true,
          ),
          SliverGrid(
            gridDelegate: const SliverGridDelegateWithMaxCrossAxisExtent(
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
                      totalAmmount:
                          Provider.of<ExpenseList>(context, listen: true)
                              .getAmmountByExpenseType(
                                  _expensesTypes.elementAt(index).id!)),
                );
              },
              childCount: _expensesTypes.length,
            ),
          )
        ],
      ),
    ));
  }
}
