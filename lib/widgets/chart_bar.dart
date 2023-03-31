import 'package:flutter/material.dart';

class ChartBar extends StatelessWidget {
  final String label;
  final double amount;
  final double spendingPCtOfTotal;
  const ChartBar({
    super.key,
    required this.spendingPCtOfTotal,
    required this.label,
    required this.amount,
  });

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        SizedBox(
            height: 15,
            child: FittedBox(child: Text("\$${amount.toStringAsFixed(0)}"))),
        const SizedBox(
          height: 4,
        ),
        SizedBox(
          width: 10,
          height: 60,
          child: Stack(
            children: [
              Container(
                decoration: BoxDecoration(
                  border: Border.all(
                    color: Theme.of(context).primaryColor.withOpacity(0.5),
                    width: 1,
                  ),
                  borderRadius: BorderRadius.circular(10),
                  color: const Color.fromRGBO(220, 220, 220, 1),
                ),
              ),
              FractionallySizedBox(
                heightFactor: spendingPCtOfTotal,
                child: Container(
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(10),
                    color: Theme.of(context)
                        .colorScheme
                        .secondary
                        .withOpacity(0.5),
                  ),
                ),
              ),
            ],
          ),
        ),
        const SizedBox(
          height: 4,
        ),
        Text(label),
      ],
    );
  }
}
