import 'package:flutter/material.dart';
import 'package:expense_app/pages/home.dart';

void main() {
  runApp(MainApp());
}

class MainApp extends StatelessWidget {
  MainApp({super.key});

  final theme = ThemeData(
    primarySwatch: Colors.purple,
    fontFamily: "Quicksand",
    appBarTheme: const AppBarTheme(
      titleTextStyle: TextStyle(
        fontFamily: "OpenSans",
        fontSize: 20,
        fontWeight: FontWeight.bold,
      ),
    ),
    textTheme: ThemeData.light().textTheme.copyWith(
          titleLarge: const TextStyle(
            fontFamily: "OpenSans",
            fontSize: 18,
            fontWeight: FontWeight.bold,
          ),
        ),
  );

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: "Expense App",
      theme: theme.copyWith(
        colorScheme: theme.colorScheme.copyWith(secondary: Colors.amber),
      ),
      home: const Home(),
    );
  }
}
