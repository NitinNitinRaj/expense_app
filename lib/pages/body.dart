import 'package:expense_app/models/transaction.dart';
import 'package:expense_app/widgets/transaction_list.dart';
import 'package:flutter/material.dart';

class Body extends StatelessWidget {
  final List<Transaction> userTransactions;
  const Body({super.key, required this.userTransactions});

  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: [
          const Card(
            color: Colors.amber,
            child: Text("Chart"),
          ),
          TransactionList(
            userTransactions: userTransactions,
          ),
        ],
      ),
    );
  }
}
