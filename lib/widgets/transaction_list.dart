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
    return SizedBox(
      height: 520,
      child: userTransactions.isEmpty
          ? Column(
              children: [
                const SizedBox(
                  height: 10,
                ),
                Text(
                  "No transactions yet!",
                  style: Theme.of(context).textTheme.titleLarge,
                ),
                const SizedBox(
                  height: 20,
                ),
                const SizedBox(
                  height: 200,
                  child: Image(
                    image: AssetImage("assets/images/waiting.png"),
                    fit: BoxFit.cover,
                  ),
                )
              ],
            )
          : ListView.builder(
              itemCount: userTransactions.length,
              itemBuilder: (ctx, index) {
                return Card(
                  elevation: 5,
                  margin:
                      const EdgeInsets.symmetric(vertical: 8, horizontal: 5),
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
                        style: Theme.of(context).textTheme.titleLarge,
                      ),
                      subtitle: Text(
                        DateFormat.yMMMMd()
                            .format(userTransactions[index].date),
                      ),
                      trailing: IconButton(
                        icon: Icon(
                          Icons.delete,
                          color: Theme.of(context).colorScheme.error,
                        ),
                        onPressed: () =>
                            {deleteTransaction(userTransactions[index].id)},
                      ),
                    ),
                  ),
                );
              },
            ),
    );
  }
}
