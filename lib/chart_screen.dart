import 'package:flutter/material.dart';
import 'package:fl_chart/fl_chart.dart';

class ChartScreen extends StatelessWidget {

  final List<Map<String, dynamic>> expenseHistory;

  const ChartScreen({
    super.key,
    required this.expenseHistory,
  });

  @override
  Widget build(BuildContext context) {

    Map<String, double> categoryTotals = {};

    for (var item in expenseHistory) {

      String category = item["category"];
      double amount = item["amount"].toDouble();

      if (categoryTotals.containsKey(category)) {
        categoryTotals[category] =
            categoryTotals[category]! + amount;
      } else {
        categoryTotals[category] = amount;
      }

    }

    List<PieChartSectionData> sections = [];

    final colors = [
      Colors.blue,
      Colors.orange,
      Colors.green,
      Colors.purple,
      Colors.red,
    ];

    int colorIndex = 0;

    categoryTotals.forEach((category, amount) {

      sections.add(

        PieChartSectionData(
          value: amount,
          title: category,
          radius: 100,
          color: colors[colorIndex % colors.length],
          titleStyle: const TextStyle(
            fontSize: 14,
            fontWeight: FontWeight.bold,
            color: Colors.white,
          ),
        ),

      );

      colorIndex++;

    });

    return Scaffold(

      appBar: AppBar(
        title: const Text("Expense Chart"),
        backgroundColor: const Color(0xFFD4A373),
      ),

      body: Center(

        child: Padding(
          padding: const EdgeInsets.all(20),

          child: PieChart(

            PieChartData(
              sections: sections,
              sectionsSpace: 3,
              centerSpaceRadius: 40,
            ),

          ),

        ),

      ),

    );
  }
}