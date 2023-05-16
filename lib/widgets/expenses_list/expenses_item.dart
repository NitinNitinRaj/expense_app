import 'package:expenses_app/models/expense.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';

class ExpensesItem extends StatelessWidget {
  const ExpensesItem(this.expense, {super.key});
  final Expense expense;

  @override
  Widget build(BuildContext context) {
    return Card(
      child: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 16),
        child: Column(
          children: [
            Text(expense.title),
            const SizedBox(
              height: 6,
            ),
            Row(
              children: [
                Text('\$${expense.amount.toStringAsFixed(2)}'),
                const Spacer(),
                Row(
                  children: [
                     Icon(categoryIcon[expense.category]),
                    const SizedBox(width: 5,),
                    Text(expense.formattedDate)
                  ],
                )
              ],
            )
          ],
        ),
      ),
    );
  }
}
