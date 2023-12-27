import 'package:expence_tracker/modal/widget/chart/chart.dart';
import 'package:expence_tracker/modal/widget/expences_list/expenses_list.dart';
import 'package:expence_tracker/modal/expense.dart';
import 'package:expence_tracker/modal/widget/new_expense.dart';
import 'package:flutter/material.dart';

class Expenses extends StatefulWidget {
  const Expenses({super.key});

  @override
  State<Expenses> createState() => _ExpensesState();
}

class _ExpensesState extends State<Expenses> {
  final List<Expense> _registerdExpense = [
    Expense(
        title: 'course',
        amount: 500.0,
        date: DateTime.now(),
        category: Category.work),
    Expense(
        title: 'cinema',
        amount: 200.0,
        date: DateTime.now(),
        category: Category.leisure),
  ];

  void openAddExpenseOverlay() {
    showModalBottomSheet(
        // useSafeArea: true,
        isScrollControlled: true,
        context: context,
        builder: (ctx) => NewExpense(onAddExpense: addExpence));
  }

  void addExpence(Expense expence) {
    setState(() {
      _registerdExpense.add(expence);
    });
  }

  void removeExpense(Expense expense) {
    final expenseIndex = _registerdExpense.indexOf(expense);
    setState(() {
      _registerdExpense.remove(expense);
    });
    ScaffoldMessenger.of(context).removeCurrentSnackBar();
    ScaffoldMessenger.of(context).showSnackBar(SnackBar(
        action: SnackBarAction(
            label: 'undo',
            onPressed: () {
              setState(() {
                _registerdExpense.insert(expenseIndex, expense);
              });
            }),
        duration: const Duration(seconds: 3),
        content: const Text('expensedeleted')));
  }

  @override
  Widget build(BuildContext context) {
    final width = MediaQuery.of(context).size.width;
    Widget mainContent = const Center(
      child: Text('No expenses found. Start adding some!'),
    );

    if (_registerdExpense.isNotEmpty) {
      mainContent = ExpensesList(
        expenses: _registerdExpense,
        onRemoveExpense: removeExpense,
      );
    }

    return Scaffold(
        appBar: AppBar(
          title: const Text('Flutter ExpenseTracker'),
          actions: [
            IconButton(
              onPressed: openAddExpenseOverlay,
              icon: const Icon(Icons.add),
            ),
          ],
        ),
        body: width < 600
            ? Column(
                children: [
                  Chart(expenses: _registerdExpense),
                  Expanded(
                    child: mainContent,
                  ),
                ],
              )
            : Row(
                children: [
                  Expanded(child: Chart(expenses: _registerdExpense)),
                  Expanded(
                    child: mainContent,
                  ),
                ],
              ));
  }
}
