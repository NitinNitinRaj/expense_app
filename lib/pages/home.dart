import 'dart:io';

import 'package:expense_app/models/transaction.dart';
import 'package:expense_app/widgets/Chart.dart';
import 'package:expense_app/widgets/new_transaction.dart';
import 'package:expense_app/widgets/transaction_list.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:uuid/uuid.dart';

class Home extends StatefulWidget {
  const Home({super.key});

  @override
  State<Home> createState() => _HomeState();
}

class _HomeState extends State<Home> {
  final List<Transaction> _userTransactions = [];
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

  // final isWebMobile = kIsWeb &&(defaultTargetPlatform == TargetPlatform.iOS ||defaultTargetPlatform == TargetPlatform.android);

  @override
  Widget build(BuildContext context) {
    final mediaQuery = MediaQuery.of(context);
    final PreferredSizeWidget appBar = _buildAppBar();
    final listView = buildListView(mediaQuery, appBar);
    final isLandscape = mediaQuery.orientation == Orientation.landscape;

    return Platform.isIOS
        ? CupertinoPageScaffold(
            navigationBar: appBar as ObstructingPreferredSizeWidget,
            child:
                _pageBody(mediaQuery, appBar as AppBar, listView, isLandscape),
          )
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
            body: _pageBody(
              mediaQuery,
              appBar as AppBar,
              listView,
              isLandscape,
            ),
          );
  }

  SizedBox buildListView(
      MediaQueryData mediaQuery, PreferredSizeWidget appBar) {
    return SizedBox(
      height: (mediaQuery.size.height -
              appBar.preferredSize.height -
              mediaQuery.padding.top) *
          0.7,
      child: TransactionList(
        deleteTransaction: _deleteTransaction,
        userTransactions: _userTransactions,
      ),
    );
  }

  List<Widget> _buildLandscapeContent(
      MediaQueryData mediaQuery, AppBar appBar, Widget listView) {
    return [
      Row(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Text("Show Chart", style: Theme.of(context).textTheme.titleLarge),
          Switch.adaptive(
              value: _showChart,
              onChanged: (val) {
                setState(() {
                  _showChart = val;
                });
              })
        ],
      ),
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
    ];
  }

  List<Widget> _buildPortraitContent(
      MediaQueryData mediaQuery, AppBar appBar, Widget listView) {
    return [
      SizedBox(
        height: (mediaQuery.size.height -
                appBar.preferredSize.height -
                mediaQuery.padding.top) *
            0.3,
        child: Chart(
          recentTransactions: _recentTransaction,
        ),
      ),
      listView,
    ];
  }

  Widget _pageBody(MediaQueryData mediaQuery, AppBar appBar, Widget listView,
      bool isLandscape) {
    return SafeArea(
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
                  if (!isLandscape)
                    ..._buildPortraitContent(
                        mediaQuery, appBar as AppBar, listView),
                  if (isLandscape)
                    ..._buildLandscapeContent(
                        mediaQuery, appBar as AppBar, listView),
                ],
              ),
      ),
    );
  }

  PreferredSizeWidget _buildAppBar() {
    return (Platform.isIOS
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
  }
}
