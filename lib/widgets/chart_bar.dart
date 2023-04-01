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
    return LayoutBuilder(builder: (context, constraints) {
      return Center(
        child: Column(
          children: [
            SizedBox(
                height: constraints.maxHeight * 0.13,
                child:
                    FittedBox(child: Text("\$${amount.toStringAsFixed(0)}"))),
            SizedBox(
              height: constraints.maxHeight * 0.04,
            ),
            SizedBox(
              width: constraints.maxHeight * 0.10,
              height: constraints.maxHeight * 0.6,
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
            SizedBox(
              height: constraints.maxHeight * 0.04,
            ),
            SizedBox(
                height: constraints.maxHeight * 0.13,
                child: FittedBox(child: Text(label))),
          ],
        ),
      );
    });
  }
}
