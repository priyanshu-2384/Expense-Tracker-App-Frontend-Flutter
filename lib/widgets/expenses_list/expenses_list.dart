import "package:flutter/material.dart";
import "package:expenses_tracker/models/expense.dart";
import "package:expenses_tracker/widgets/expenses_item.dart";

class ExpensesList extends StatelessWidget {
  const ExpensesList(
      {super.key, required this.expenses, required this.removeExpense});
  final List<Expense> expenses;
  final void Function(Expense expense) removeExpense;
  @override
  Widget build(BuildContext context) {
    return ListView.builder(
        itemCount: expenses.length,
        itemBuilder: (ctx, index) => Dismissible(
            //making the list item dismissible(deleting by swipe)
            background: Container(
                color: Theme.of(context).colorScheme.error.withOpacity(0.75),
                margin: EdgeInsets.symmetric(
                    horizontal:
                        Theme.of(context).cardTheme.margin!.horizontal)),
            key: ValueKey(expenses[index]),
            onDismissed: (direction) {
              removeExpense(expenses[index]);
            },
            child: ExpensesItem(expenses[index])));
  }
}
