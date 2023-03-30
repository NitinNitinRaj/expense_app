import 'package:uuid/uuid.dart';

class Transaction {
  final Uuid id;
  final String title;
  final double amount;
  final DateTime date;

  Transaction({
    required this.id,
    required this.title,
    required this.amount,
    required this.date,
  });
}
