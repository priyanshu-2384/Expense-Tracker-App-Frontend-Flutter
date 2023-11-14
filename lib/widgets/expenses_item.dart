import "package:flutter/material.dart";
import "package:expenses_tracker/models/expense.dart";

class ExpensesItem extends StatelessWidget {
  const ExpensesItem(this.expense, {super.key});
  final Expense expense;

  @override
  Widget build(BuildContext context) {
    return Card(
        child: Padding(
      padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 12),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            expense.title,
            style: Theme.of(context).textTheme.titleLarge,
          ),
          const SizedBox(height: 8),
          Row(
            children: [
              Text("\$${expense.amount.toStringAsFixed(2)}"),
              const Spacer(),
              Row(
                children: [
                  Icon(categoryIcon[expense.category]),
                  const SizedBox(width: 4),
                  Text(expense.formatDate),
                ],
              )
            ],
          )
        ],
      ),
    ));
  }
}
