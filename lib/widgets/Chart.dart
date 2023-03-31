import 'package:expense_app/models/transaction.dart';
import 'package:expense_app/widgets/chart_bar.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';

class Chart extends StatelessWidget {
  final List<Transaction> recentTransactions;
  const Chart({super.key, required this.recentTransactions});

  List<Map<String, Object>> get groupedTransactionValues {
    return List.generate(7, (index) {
      final weekDay = DateTime.now().subtract(Duration(days: index));
      var totalAmount = 0.0;
      for (Transaction transaction in recentTransactions) {
        if (transaction.date.day == weekDay.day &&
            transaction.date.month == weekDay.month &&
            transaction.date.year == weekDay.year) {
          totalAmount += transaction.amount;
        }
      }
      return {
        "day": DateFormat.E().format(weekDay).substring(0, 2),
        "amount": totalAmount
      };
    }).reversed.toList();
  }

  double get spendingPCtOfTotal {
    return groupedTransactionValues.fold(0.0, (sum, item) {
      return sum + (item["amount"] as double);
    });
  }

  @override
  Widget build(BuildContext context) {
    return Card(
      elevation: 6,
      margin: const EdgeInsets.all(20),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceAround,
        children: [
          ...groupedTransactionValues.map((dayAmount) {
            return Flexible(
              fit: FlexFit.tight,
              child: Padding(
                padding:
                    const EdgeInsets.symmetric(vertical: 12, horizontal: 5),
                child: ChartBar(
                  spendingPCtOfTotal: spendingPCtOfTotal == 0
                      ? 0.0
                      : (dayAmount["amount"] as double) / spendingPCtOfTotal,
                  label: dayAmount["day"].toString().substring(0, 2),
                  amount: dayAmount["amount"] as double,
                ),
              ),
            );
          }).toList(),
        ],
      ),
    );
  }
}
