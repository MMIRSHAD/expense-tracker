import 'package:flutter/material.dart';

import 'package:intl/intl.dart';
import 'package:expence_tracker/modal/expense.dart';

final formatter = DateFormat.yMd();

class NewExpense extends StatefulWidget {
  NewExpense({super.key, required this.onAddExpense});

  void Function(Expense expence) onAddExpense;

  @override
  State<NewExpense> createState() => _NewExpenseState();
}

class _NewExpenseState extends State<NewExpense> {
  final titleController = TextEditingController();
  final amountController = TextEditingController();
  DateTime? selectedDate;
  Category selectedCtegory = Category.work;

  @override
  void dispose() {
    titleController.dispose();
    amountController.dispose();
    super.dispose();
  }

  slcCategory(values) {
    setState(() {
      selectedCtegory = values;
    });
  }

  void presentDatePicker() async {
    final now = DateTime.now();
    final firstDate = DateTime(now.year - 1, now.month, now.day);
    final pickedDate = await showDatePicker(
        context: context,
        initialDate: now,
        firstDate: firstDate,
        lastDate: now);
    setState(() {
      selectedDate = pickedDate;
    });
  }

  void submitExpenceData() {
    final enteredAmount = double.tryParse(amountController.text);
    final invalidAmount = enteredAmount == null || enteredAmount <= 0;
    if (titleController.text.trim().isEmpty ||
        invalidAmount ||
        selectedDate == null) {
      showDialog(
        context: context,
        builder: (ctx) => AlertDialog(
          title: const Text('Invailid Input'),
          content: const Text(
              'please make sure valid title,amount,date and category was entered'),
          actions: [
            TextButton(
              onPressed: () {
                Navigator.pop(ctx);
              },
              child: const Text('Okay'),
            ),
          ],
        ),
      );
      return;
    }
    widget.onAddExpense(
      Expense(
          title: titleController.text,
          amount: enteredAmount,
          date: selectedDate!,
          category: selectedCtegory),
    );

    Navigator.pop(context);
  }

  @override
  Widget build(BuildContext context) {
    final keyBoardSpace = MediaQuery.of(context).viewInsets.bottom;
    return LayoutBuilder(builder: (ctx, constraints) {
      final width = constraints.maxWidth;
      return SizedBox(
        height: double.infinity,
        child: SingleChildScrollView(
          child: Padding(
            padding:
                EdgeInsets.fromLTRB(15.0, 40.0, 15.0, keyBoardSpace + 15.0),
            child: Column(
              children: [
                if (width >= 600)
                  Row(
                    mainAxisAlignment: MainAxisAlignment.start,
                    children: [
                      Expanded(
                        child: TextField(
                          controller: titleController,
                          maxLength: 50,
                          decoration: const InputDecoration(
                            label: Text('title'),
                          ),
                        ),
                      ),
                      const SizedBox(width: 20),
                      Expanded(
                        child: TextField(
                          controller: amountController,
                          keyboardType: TextInputType.number,
                          decoration: const InputDecoration(
                              label: Text('enter Amount'), prefixText: '\$ '),
                        ),
                      ),
                    ],
                  )
                else
                  TextField(
                    controller: titleController,
                    maxLength: 50,
                    decoration: const InputDecoration(
                      label: Text('title'),
                    ),
                  ),
                if (width >= 600)
                  Row(
                    children: [
                      DropdownButton(
                          value: selectedCtegory,
                          items: Category.values
                              .map((category) => DropdownMenuItem(
                                  value: category,
                                  child: (Text(category.name.toUpperCase()))))
                              .toList(),
                          onChanged: slcCategory),
                      Expanded(
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.end,
                          children: [
                            Text(selectedDate == null
                                ? 'no date selected'
                                : formatter.format(selectedDate!)),
                            IconButton(
                                onPressed: presentDatePicker,
                                icon: const Icon(Icons.calendar_month))
                          ],
                        ),
                      ),
                    ],
                  )
                else
                  Row(
                    children: [
                      Expanded(
                        child: TextField(
                          controller: amountController,
                          keyboardType: TextInputType.number,
                          decoration: const InputDecoration(
                              label: Text('enter Amount'), prefixText: '\$ '),
                        ),
                      ),
                      const SizedBox(
                        width: 15,
                      ),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.end,
                        children: [
                          Text(selectedDate == null
                              ? 'no date selected'
                              : formatter.format(selectedDate!)),
                          IconButton(
                              onPressed: presentDatePicker,
                              icon: const Icon(Icons.calendar_month))
                        ],
                      ),
                    ],
                  ),
                const SizedBox(height: 16),
                if (width >= 600)
                  Row(
                    children: [
                      const Spacer(),
                      TextButton(
                          onPressed: () {
                            Navigator.pop(context);
                          },
                          child: const Text('cancel')),
                      ElevatedButton(
                          onPressed: submitExpenceData,
                          child: const Text('save expense')),
                    ],
                  )
                else
                  Row(
                    children: [
                      DropdownButton(
                          value: selectedCtegory,
                          items: Category.values
                              .map((category) => DropdownMenuItem(
                                  value: category,
                                  child: (Text(category.name.toUpperCase()))))
                              .toList(),
                          onChanged: slcCategory),
                      const Spacer(),
                      TextButton(
                          onPressed: () {
                            Navigator.pop(context);
                          },
                          child: const Text('cancel')),
                      ElevatedButton(
                          onPressed: submitExpenceData,
                          child: const Text('save expense')),
                    ],
                  ),
              ],
            ),
          ),
        ),
      );
    });
  }
}
