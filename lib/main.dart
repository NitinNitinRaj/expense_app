import 'package:expense_app_v2/pages/expenses.dart';
import 'package:expense_app_v2/providers/expense_provider.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

void main() {
  runApp(const MainApp());
}

class MainApp extends StatelessWidget {
  const MainApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: MultiProvider(providers: [
        ChangeNotifierProvider(
          create: (_) => ExpenseProvider(),
        )
      ], child: const Expenses()),
    );
  }
}
