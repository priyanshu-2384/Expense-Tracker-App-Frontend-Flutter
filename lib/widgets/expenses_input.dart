import "package:flutter/material.dart";
import "package:expenses_tracker/models/expense.dart";

class ExpensesInput extends StatefulWidget {
  const ExpensesInput(this.addExpense, {super.key});
  final void Function(Expense expense) addExpense;
  @override
  State<StatefulWidget> createState() {
    return _StateExpensesInput();
  }
}

class _StateExpensesInput extends State<ExpensesInput> {
  final _titleController = TextEditingController();
  final _amountController = TextEditingController();
  DateTime? _selectedDate;
  Category selectedCategory = Category.leisure;
  @override
  void dispose() {
    _amountController.dispose();
    _titleController.dispose();
    super.dispose();
  }

  void _presentDatePicker() async {
    final now = DateTime.now();
    final first = DateTime(now.year - 1, now.month,
        now.day); // await tells flutter that we will get a value in future
    final presentDate = await showDatePicker(
        //then when we will get the value then the the function below that will be called
        context: context,
        initialDate: now,
        firstDate: first,
        lastDate: now);
    setState(() {
      _selectedDate = presentDate;
    });
  }

  void _submitExpenseData() {
    final currAmount = double.tryParse(
        _amountController.text); //if not valid number results in null
    final invalidAmount = currAmount == null || currAmount <= 0;
    if (_titleController.text.trim().isEmpty ||
        invalidAmount ||
        _selectedDate == null) {
      showDialog(
          context: context,
          builder: (ctx) => AlertDialog(
                //Error message dialog box
                title: const Text("Invalid Input"),
                content: const Text(
                    "Make sure that you enter valid Date,Title,Amount"),
                actions: [
                  TextButton(
                      onPressed: () {
                        Navigator.pop(ctx);
                      },
                      child: const Text("Okay"))
                ],
              ));
      return;
    } else {
      widget.addExpense(Expense(
          amount: currAmount,
          category: selectedCategory,
          date: _selectedDate!,
          title: _titleController.text));
    }
    Navigator.pop(context);
  }

  @override
  Widget build(BuildContext context) {
    final keyBoardSpace = MediaQuery.of(context).viewInsets.bottom;
    return LayoutBuilder(builder: (ctx, constraints) {
      final width = constraints.maxWidth;
      return SizedBox(
        height: double.maxFinite,
        width: double.infinity,
        child: SingleChildScrollView(
          child: Padding(
              padding: EdgeInsets.fromLTRB(16, 16, 16, keyBoardSpace + 16),
              child: Column(
                children: [
                  if (width >= 600)
                    Row(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Expanded(
                          child: TextField(
                            controller: _titleController,
                            maxLength: 50,
                            decoration:
                                const InputDecoration(label: Text("Title")),
                          ),
                        ),
                        Expanded(
                          child: TextField(
                            controller: _amountController,
                            maxLength: 10,
                            keyboardType: TextInputType.number,
                            decoration: const InputDecoration(
                                prefixText: '\$', label: Text("Amount")),
                          ),
                        ),
                      ],
                    )
                  else
                    TextField(
                      controller: _titleController,
                      maxLength: 50,
                      decoration: const InputDecoration(label: Text("Title")),
                    ),
                  Row(
                    children: [
                      if (width >= 600)
                        DropdownButton(
                            value: selectedCategory,
                            items: Category.values
                                .map((category) => DropdownMenuItem(
                                    value:
                                        category, //this value is the same which is gonna paseed in onchanged,working on dropdown button
                                    child: Text(category.name.toUpperCase())))
                                .toList(),
                            onChanged: (value) {
                              if (value == null) {
                                return;
                              }
                              setState(() {
                                selectedCategory = value;
                              });
                            })
                      else
                        Expanded(
                          child: TextField(
                            controller: _amountController,
                            maxLength: 10,
                            keyboardType: TextInputType.number,
                            decoration: const InputDecoration(
                                prefixText: '\$', label: Text("Amount")),
                          ),
                        ),
                      const SizedBox(width: 16),
                      Expanded(
                          child: Row(
                        mainAxisAlignment: MainAxisAlignment.end,
                        crossAxisAlignment: CrossAxisAlignment.center,
                        children: [
                          Text(_selectedDate == null
                              ? "No Date Picked"
                              : formatter.format(
                                  _selectedDate!)), //! to telll flutter that it would not be null

                          IconButton(
                            onPressed: _presentDatePicker,
                            icon: const Icon(Icons.calendar_month_rounded),
                          )
                        ],
                      ))
                    ],
                  ),
                  const SizedBox(
                    height: 16,
                  ),
                  if (width >= 600)
                    Row(
                      children: [
                        const Spacer(),
                        TextButton(
                            onPressed: () {
                              Navigator.pop(
                                  context); //closes the modal onpressed
                            },
                            child: const Text("Cancel")),
                        ElevatedButton(
                          onPressed: _submitExpenseData,
                          child: const Text("Submit Expense"),
                        ),
                      ],
                    )
                  else
                    Row(
                      children: [
                        DropdownButton(
                            value: selectedCategory,
                            items: Category.values
                                .map((category) => DropdownMenuItem(
                                    value:
                                        category, //this value is the same which is gonna paseed in onchanged,working on dropdown button
                                    child: Text(category.name.toUpperCase())))
                                .toList(),
                            onChanged: (value) {
                              if (value == null) {
                                return;
                              }
                              setState(() {
                                selectedCategory = value;
                              });
                            }),
                        const Spacer(),
                        TextButton(
                            onPressed: () {
                              Navigator.pop(
                                  context); //closes the modal onpressed
                            },
                            child: const Text("Cancel")),
                        ElevatedButton(
                          onPressed: _submitExpenseData,
                          child: const Text("Submit Expense"),
                        ),
                      ],
                    )
                ],
              )),
        ),
      );
    });
  }
}
