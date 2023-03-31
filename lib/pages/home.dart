import 'package:expense_app/models/transaction.dart';
import 'package:expense_app/widgets/Chart.dart';
import 'package:expense_app/widgets/new_transaction.dart';
import 'package:expense_app/widgets/transaction_list.dart';
import 'package:flutter/material.dart';
import 'package:uuid/uuid.dart';

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

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("Expense Tracker"),
        actions: [
          IconButton(
              onPressed: () => {_startAddNewTransaction(context)},
              icon: const Icon(Icons.add))
        ],
      ),
      floatingActionButtonLocation: FloatingActionButtonLocation.centerFloat,
      floatingActionButton: FloatingActionButton(
        child: const Icon(Icons.add),
        onPressed: () => {_startAddNewTransaction(context)},
      ),
      body: SingleChildScrollView(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            Chart(
              recentTransactions: _recentTransaction,
            ),
            TransactionList(
              deleteTransaction: _deleteTransaction,
              userTransactions: _userTransactions,
            ),
          ],
        ),
      ),
    );
  }
}
