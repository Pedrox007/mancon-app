import 'package:flutter/material.dart';
import 'package:flutter/rendering.dart';
import 'package:flutter/services.dart';
import 'package:mancon_app/models/expense_type.dart';
import 'package:mancon_app/state/expense_list.dart';
import 'package:mancon_app/utils/mocked_data.dart';
import 'package:mancon_app/utils/sliver_header_delegate.dart';
import 'package:mancon_app/widgets/expense_card.dart';
import 'package:provider/provider.dart';

class HomePage extends StatefulWidget {
  const HomePage({super.key});

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
        floatingActionButton: FloatingActionButton(
          backgroundColor: Theme.of(context).colorScheme.primary,
          elevation: 5,
          onPressed: () {},
          child: const Icon(Icons.person_outlined, size: 35),
        ),
        body: AnnotatedRegion<SystemUiOverlayStyle>(
          value: SystemUiOverlayStyle(
              statusBarColor: Theme.of(context).colorScheme.background),
          child: Padding(
            padding: EdgeInsets.only(top: MediaQuery.of(context).padding.top),
            child: CustomScrollView(
              controller: controller,
              slivers: <Widget>[
                SliverPersistentHeader(
                  delegate: PersonalSliverHeaderDelegate(
                      totalAmmount:
                          Provider.of<ExpenseList>(context, listen: true)
                              .getAmmountSum()),
                  pinned: true,
                  floating: true,
                ),
                SliverPadding(
                  padding: const EdgeInsets.only(bottom: 80),
                  sliver: SliverGrid(
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
                              totalAmmount: Provider.of<ExpenseList>(context,
                                      listen: true)
                                  .getAmmountByExpenseType(
                                      _expensesTypes.elementAt(index).id!)),
                        );
                      },
                      childCount: _expensesTypes.length,
                    ),
                  ),
                )
              ],
            ),
          ),
        ));
  }
}
