import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:uuid/uuid.dart';

const uuid = Uuid();
final dateformatter = DateFormat.yMd();

enum Category { food, travel, leisure, work }

final categoryIcon = {
  Category.food: Icons.lunch_dining,
  Category.travel: Icons.flight_takeoff,
  Category.leisure: Icons.movie,
  Category.work: Icons.work
};

class Expense {
  final String id;
  final String title;
  final double amount;
  final Category category;
  final DateTime dateTime;
  Expense({
    required this.title,
    required this.amount,
    required this.category,
    required this.dateTime,
  }) : id = uuid.v4();

  String get formattedDate{
    return dateformatter.format(dateTime);
  }

}
