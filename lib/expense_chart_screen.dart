import 'package:flutter/material.dart';
import 'package:fl_chart/fl_chart.dart';

class ExpenseChartScreen extends StatelessWidget {

  final List<Map<String, dynamic>> expenseHistory;

  const ExpenseChartScreen({
    super.key,
    required this.expenseHistory,
  });

  @override
  Widget build(BuildContext context) {

    Map<String, double> categoryTotals = {};

    for (var expense in expenseHistory) {

      String category = expense["category"];
      double amount = (expense["amount"]).toDouble();

      if (categoryTotals.containsKey(category)) {
        categoryTotals[category] = categoryTotals[category]! + amount;
      } else {
        categoryTotals[category] = amount;
      }
    }

    List<PieChartSectionData> sections = [];

    categoryTotals.forEach((category, amount) {

      sections.add(
        PieChartSectionData(
          value: amount,
          title: "$category\n₹${amount.toInt()}",
          radius: 90,
        ),
      );

    });

    return Scaffold(

      appBar: AppBar(
        title: const Text("Expense Analytics"),
        backgroundColor: const Color(0xFFD4A373),
      ),

      body: Center(

        child: categoryTotals.isEmpty
            ? const Text(
                "No expenses recorded yet",
                style: TextStyle(fontSize: 18),
              )
            : PieChart(
                PieChartData(
                  sections: sections,
                  sectionsSpace: 2,
                  centerSpaceRadius: 40,
                ),
              ),

      ),
    );
  }
}