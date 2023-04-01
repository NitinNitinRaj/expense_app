import 'package:expense_app/models/transaction.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';

class TransactionItem extends StatelessWidget {
  const TransactionItem({
    super.key,
    required this.userTransaction,
    required this.themeContext,
    required this.deleteTransaction,
  });

  final Transaction userTransaction;
  final ThemeData themeContext;
  final Function deleteTransaction;

  @override
  Widget build(BuildContext context) {
    return Card(
      elevation: 5,
      margin: const EdgeInsets.symmetric(vertical: 8, horizontal: 5),
      child: Padding(
        padding: const EdgeInsets.all(5),
        child: ListTile(
          leading: CircleAvatar(
            radius: 30,
            child: Padding(
              padding: const EdgeInsets.all(10),
              child: FittedBox(
                child: Text(
                  "\$${userTransaction.amount.toStringAsFixed(2)}",
                  style: const TextStyle(
                    fontWeight: FontWeight.bold,
                    color: Colors.white,
                  ),
                ),
              ),
            ),
          ),
          title: Text(
            userTransaction.title,
            style: themeContext.textTheme.titleLarge,
          ),
          subtitle: Text(
            DateFormat.yMMMMd().format(userTransaction.date),
          ),
          trailing: MediaQuery.of(context).size.width > 500
              ? TextButton.icon(
                  label: Text(
                    "Delete",
                    style: TextStyle(
                      color: themeContext.colorScheme.error,
                    ),
                  ),
                  icon: Icon(
                    Icons.delete,
                    color: themeContext.colorScheme.error,
                  ),
                  onPressed: () => {deleteTransaction(userTransaction.id)},
                )
              : IconButton(
                  icon: Icon(
                    Icons.delete,
                    color: themeContext.colorScheme.error,
                  ),
                  onPressed: () => {deleteTransaction(userTransaction.id)},
                ),
        ),
      ),
    );
  }
}
