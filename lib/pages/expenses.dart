import 'package:expenses_app/models/expense.dart';
import 'package:expenses_app/widgets/expenses_list/expenses_list.dart';
import 'package:flutter/material.dart';

class Expenses extends StatefulWidget {
  const Expenses({super.key});

  @override
  State<Expenses> createState() => _ExpensesState();
}

class _ExpensesState extends State<Expenses> {
  final List<Expense> _registeredExpenses = [
    Expense(
      title: "Flutter Course",
      amount: 19.99,
      category: Category.work,
      dateTime: DateTime.now(),
    ),
    Expense(
      title: "Film",
      amount: 15.99,
      category: Category.leisure,
      dateTime: DateTime.now(),
    ),
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text("Expense App")),
      body: Column(children: [
        const Text("Chart"),
        Expanded(child: ExpenseList(expenses: _registeredExpenses)),
      ]),
    );
  }
}
