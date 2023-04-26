import 'package:expense_app_v2/models/expense.dart';
import 'package:flutter/material.dart';

class ExpenseProvider with ChangeNotifier {
  final List<Expense> _expenses = [
    Expense(
        title: "Hat",
        amount: 5.99,
        dateTime: DateTime.now(),
        category: Category.lisure),
    Expense(
        title: "Coffee",
        amount: 2.99,
        dateTime: DateTime.now(),
        category: Category.food),
  ];

  List<Expense> get expenses {
    return [..._expenses];
  }
}
