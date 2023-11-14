import "package:uuid/uuid.dart";
import "package:flutter/material.dart";
import "package:intl/intl.dart";

final formatter = DateFormat.yMd(); //format data in human readable way

//for generating random string id's
const uuid = Uuid();

//creating enum
enum Category { food, travel, leisure, work }

const categoryIcon = {
  Category.food: Icons.lunch_dining,
  Category.travel: Icons.flight,
  Category.leisure: Icons.movie,
  Category.work: Icons.work
};

class Expense {
  Expense(
      {required this.date,
      required this.title,
      required this.amount,
      required this.category})
      : id = uuid.v4();
  final String id;
  final String title;
  final double amount;
  final DateTime date;
  final Category category;

  String get formatDate {
    return formatter.format(date);
  }
}

class ExpenseBucket {
  ExpenseBucket({required this.expenses, required this.category});
  final Category category;
  final List<Expense> expenses;

  ExpenseBucket.forCategory(List<Expense> allExpenses, this.category)
      : expenses = allExpenses
            .where((expense) => expense.category == category)
            .toList();

  double get totalExpenses {
    double sum = 0;

    for (final expense in expenses) {
      sum = sum + expense.amount;
    }

    return sum;
  }
}
