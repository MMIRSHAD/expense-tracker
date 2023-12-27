import 'package:expence_tracker/modal/expense.dart';
import 'package:flutter/material.dart';

class ExpenseItem extends StatelessWidget {
  const ExpenseItem(this.expense, {super.key});

  final Expense expense;

  @override
  Widget build(BuildContext context) {
    return Card(
      child: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 20.0, vertical: 10.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              expense.title,
              style: Theme.of(context).textTheme.titleLarge,
            ),
            const SizedBox(
              height: 2.0,
            ),
            Row(
              children: [
                Text('\$${expense.amount.toStringAsFixed(2)}'),
                const Spacer(),
                Row(
                  children: [
                    Icon(categoryIcons[expense.category]),
                    const SizedBox(
                      width: 8.0,
                    ),
                    Text(expense
                        .formattedDate) //hm yaha gettter le rahe h isliye formattedDate likha agr expense class me formatteddate ko method ki trh use krtr to use 'formatteddate()' ki trh call krte.
                  ],
                )
              ],
            )
          ],
        ),
      ),
    );
  }
}
