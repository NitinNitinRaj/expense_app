import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:expense_app/models/transaction.dart';

class TransactionList extends StatelessWidget {
  final List<Transaction> userTransactions;
  const TransactionList({super.key, required this.userTransactions});

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: 300,
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
                  child: Row(children: [
                    Container(
                      margin: const EdgeInsets.symmetric(
                        vertical: 10,
                        horizontal: 15,
                      ),
                      decoration: BoxDecoration(
                        border: Border.all(
                          color: Theme.of(context).primaryColor,
                          width: 2,
                        ),
                      ),
                      padding: const EdgeInsets.all(10),
                      child: Text(
                        "\$${userTransactions[index].amount.toStringAsFixed(2)}",
                        style: TextStyle(
                          fontWeight: FontWeight.bold,
                          fontSize: 20,
                          color: Theme.of(context).primaryColor,
                        ),
                      ),
                    ),
                    Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          userTransactions[index].title,
                          style: Theme.of(context).textTheme.titleLarge,
                        ),
                        Text(
                          DateFormat.yMMMMd()
                              .format(userTransactions[index].date),
                          style: const TextStyle(
                            fontWeight: FontWeight.bold,
                            fontSize: 13,
                            color: Colors.grey,
                          ),
                        )
                      ],
                    )
                  ]),
                );
              },
            ),
    );
  }
}
