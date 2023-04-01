import 'dart:io';

import 'package:expense_app/models/transaction.dart';
import 'package:expense_app/widgets/Chart.dart';
import 'package:expense_app/widgets/new_transaction.dart';
import 'package:expense_app/widgets/transaction_list.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:uuid/uuid.dart';
import 'package:flutter/foundation.dart';

class Home extends StatefulWidget {
  const Home({super.key});

  @override
  State<Home> createState() => _HomeState();
}

class _HomeState extends State<Home> {
  final List<Transaction> _userTransactions = [
    Transaction(
      id: const Uuid().v1(),
      title: "Camera",
      amount: 12.99,
      date: DateTime.now(),
    ),
    Transaction(
      id: const Uuid().v1(),
      title: "Mouse",
      amount: 7.99,
      date: DateTime.now().subtract(const Duration(days: 1)),
    ),
    Transaction(
      id: const Uuid().v1(),
      title: "Shoe",
      amount: 19.99,
      date: DateTime.now().subtract(const Duration(days: 5)),
    ),
    Transaction(
      id: const Uuid().v1(),
      title: "Bottle",
      amount: 12.99,
      date: DateTime.now().subtract(const Duration(days: 3)),
    ),
    Transaction(
      id: const Uuid().v1(),
      title: "Lunch",
      amount: 5.99,
      date: DateTime.now().subtract(const Duration(days: 6)),
    ),
    Transaction(
      id: const Uuid().v1(),
      title: "Coffee",
      amount: 1.99,
      date: DateTime.now().subtract(const Duration(days: 2)),
    ),
    Transaction(
      id: const Uuid().v1(),
      title: "Football",
      amount: 25.99,
      date: DateTime.now().subtract(const Duration(days: 4)),
    ),
  ];

  bool _showChart = false;

  List<Transaction> get _recentTransaction {
    return _userTransactions.where((tx) {
      return tx.date.isAfter(DateTime.now().subtract(const Duration(days: 7)));
    }).toList();
  }

  void _addNewTransaction(String title, double amount, DateTime pickedDate) {
    final newTransaction = Transaction(
      id: const Uuid().v1(),
      title: title,
      amount: amount,
      date: pickedDate,
    );
    setState(() {
      _userTransactions.add(newTransaction);
    });
  }

  void _startAddNewTransaction(BuildContext context) {
    showModalBottomSheet(
      context: context,
      builder: (buildContext) {
        return NewTransaction(
          addNewTransaction: _addNewTransaction,
        );
      },
    );
  }

  void _deleteTransaction(String id) {
    setState(() {
      _userTransactions.removeWhere((tx) => tx.id == id);
    });
  }

  final isDesktop = defaultTargetPlatform == TargetPlatform.windows || kIsWeb;

  // final isWebMobile = kIsWeb &&
  //     (defaultTargetPlatform == TargetPlatform.iOS ||
  //         defaultTargetPlatform == TargetPlatform.android);

  @override
  Widget build(BuildContext context) {
    final mediaQuery = MediaQuery.of(context);
    final PreferredSizeWidget appBar = (Platform.isIOS
        ? CupertinoNavigationBar(
            middle: const Text("Expense Tracker"),
            trailing: Row(
              mainAxisSize: MainAxisSize.min,
              children: [
                GestureDetector(
                    onTap: () => {_startAddNewTransaction(context)},
                    child: const Icon(CupertinoIcons.add))
              ],
            ),
          )
        : AppBar(
            title: const Text("Expense Tracker"),
            actions: [
              IconButton(
                  onPressed: () => {_startAddNewTransaction(context)},
                  icon: const Icon(Icons.add))
            ],
          )) as PreferredSizeWidget;

    final listView = SizedBox(
      height: (mediaQuery.size.height -
              appBar.preferredSize.height -
              mediaQuery.padding.top) *
          0.7,
      child: TransactionList(
        deleteTransaction: _deleteTransaction,
        userTransactions: _userTransactions,
      ),
    );

    final isLandscape = mediaQuery.orientation == Orientation.landscape;

    final pageBody = SafeArea(
      child: SingleChildScrollView(
        child: isDesktop
            ? Center(
                child: Column(
                  children: [
                    SizedBox(
                      width: mediaQuery.size.width * 0.5,
                      height: (mediaQuery.size.height -
                              appBar.preferredSize.height -
                              mediaQuery.padding.top) *
                          0.3,
                      child: Chart(
                        recentTransactions: _recentTransaction,
                      ),
                    ),
                    SizedBox(
                      width: mediaQuery.size.width * 0.5,
                      height: (mediaQuery.size.height -
                              appBar.preferredSize.height -
                              mediaQuery.padding.top) *
                          0.7,
                      child: TransactionList(
                        deleteTransaction: _deleteTransaction,
                        userTransactions: _userTransactions,
                      ),
                    ),
                  ],
                ),
              )
            : Column(
                children: [
                  if (isLandscape)
                    Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        const Text(
                          "Show Chart",
                          style: TextStyle(
                              fontSize: 15, fontWeight: FontWeight.bold),
                        ),
                        Switch.adaptive(
                            value: _showChart,
                            onChanged: (val) {
                              setState(() {
                                _showChart = val;
                              });
                            })
                      ],
                    ),
                  if (!isLandscape)
                    SizedBox(
                      height: (mediaQuery.size.height -
                              appBar.preferredSize.height -
                              mediaQuery.padding.top) *
                          0.3,
                      child: Chart(
                        recentTransactions: _recentTransaction,
                      ),
                    ),
                  if (!isLandscape) listView,
                  if (isLandscape)
                    _showChart
                        ? SizedBox(
                            height: (mediaQuery.size.height -
                                    appBar.preferredSize.height -
                                    mediaQuery.padding.top) *
                                0.7,
                            child: Chart(
                              recentTransactions: _recentTransaction,
                            ),
                          )
                        : listView,
                ],
              ),
      ),
    );

    return Platform.isIOS
        ? CupertinoPageScaffold(
            navigationBar: appBar as ObstructingPreferredSizeWidget,
            child: pageBody)
        : Scaffold(
            appBar: appBar,
            floatingActionButtonLocation:
                FloatingActionButtonLocation.centerFloat,
            floatingActionButton: Platform.isIOS
                ? Container()
                : FloatingActionButton(
                    child: const Icon(Icons.add),
                    onPressed: () => {_startAddNewTransaction(context)},
                  ),
            body: pageBody);
  }
}
