import 'package:expense_app/models/transaction.dart';
import 'package:expense_app/widgets/new_transaction.dart';
import 'package:flutter/material.dart';
import 'package:expense_app/pages/body.dart';
import 'package:uuid/uuid.dart';

class Home extends StatefulWidget {
  const Home({super.key});

  @override
  State<Home> createState() => _HomeState();
}

class _HomeState extends State<Home> {
  final List<Transaction> _userTransactions = [
    // Transaction(
    //   id: const Uuid(),
    //   title: "New Shoe",
    //   amount: 69.99,
    //   date: DateTime.now(),
    // ),
    // Transaction(
    //   id: const Uuid(),
    //   title: "Dinner",
    //   amount: 19.99,
    //   date: DateTime.now(),
    // ),
  ];
  void _addNewTransaction(String title, double amount) {
    final newTransaction = Transaction(
      id: const Uuid(),
      title: title,
      amount: amount,
      date: DateTime.now(),
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
      body: Body(userTransactions: _userTransactions),
    );
  }
}
