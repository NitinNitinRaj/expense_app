import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:expense_app/models/transaction.dart';

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
                            "\$${userTransactions[index].amount.toStringAsFixed(2)}",
                            style: const TextStyle(
                              fontWeight: FontWeight.bold,
                              color: Colors.white,
                            ),
                          ),
                        ),
                      ),
                    ),
                    title: Text(
                      userTransactions[index].title,
                      style: themeContext.textTheme.titleLarge,
                    ),
                    subtitle: Text(
                      DateFormat.yMMMMd().format(userTransactions[index].date),
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
                            onPressed: () =>
                                {deleteTransaction(userTransactions[index].id)},
                          )
                        : IconButton(
                            icon: Icon(
                              Icons.delete,
                              color: themeContext.colorScheme.error,
                            ),
                            onPressed: () =>
                                {deleteTransaction(userTransactions[index].id)},
                          ),
                  ),
                ),
              );
            },
          );
  }
}
