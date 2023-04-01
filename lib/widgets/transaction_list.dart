import 'package:expense_app/models/transaction.dart';
import 'package:expense_app/widgets/transaction_item.dart';
import 'package:flutter/material.dart';

class TransactionList extends StatelessWidget {
  final List<Transaction> userTransactions;
  final Function deleteTransaction;
  const TransactionList(
      {super.key,
      required this.userTransactions,
      required this.deleteTransaction});

  @override
  Widget build(BuildContext context) {
    final themeContext = Theme.of(context);
    return userTransactions.isEmpty
        ? LayoutBuilder(builder: (context, constraints) {
            return Column(
              children: [
                SizedBox(
                  height: constraints.maxHeight * 0.1,
                ),
                Text(
                  "No transactions yet!",
                  style: themeContext.textTheme.titleLarge,
                ),
                SizedBox(
                  height: constraints.maxHeight * 0.2,
                ),
                SizedBox(
                  height: constraints.maxHeight * 0.5,
                  child: const Image(
                    image: AssetImage("assets/images/waiting.png"),
                    fit: BoxFit.cover,
                  ),
                )
              ],
            );
          })
        : ListView.builder(
            itemCount: userTransactions.length,
            itemBuilder: (ctx, index) {
              return TransactionItem(
                  userTransaction: userTransactions[index],
                  themeContext: themeContext,
                  deleteTransaction: deleteTransaction);
            },
          );
  }
}
