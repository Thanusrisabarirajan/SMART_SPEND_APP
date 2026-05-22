import 'package:flutter/material.dart';

class HistoryScreen extends StatelessWidget {

  final List<Map<String, dynamic>> weeklyHistory;

  const HistoryScreen({
    super.key,
    required this.weeklyHistory,
  });

  @override
  Widget build(BuildContext context) {

    return Scaffold(

      appBar: AppBar(
        title: const Text("Weekly History"),
      ),

      body: ListView.builder(

        itemCount: weeklyHistory.length,

        itemBuilder: (context, index) {

          final week = weeklyHistory[index];

          return Card(

            margin: const EdgeInsets.all(10),

            child: ListTile(

              title: Text("Week ${week["week"]}"),

              subtitle: Text(
                "Spent: ₹${week["spent"]}",
              ),

              trailing: Text(
                "Saved: ₹${week["saved"]}",
                style: const TextStyle(
                  color: Colors.green,
                  fontWeight: FontWeight.bold,
                ),
              ),

            ),

          );

        },

      ),

    );
  }
}