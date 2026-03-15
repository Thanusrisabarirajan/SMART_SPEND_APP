import 'package:flutter/material.dart';

class SavingsGoalScreen extends StatefulWidget {

  final int totalBudget;
  final int totalSpent;

  const SavingsGoalScreen({
    super.key,
    required this.totalBudget,
    required this.totalSpent,
  });

  @override
  State<SavingsGoalScreen> createState() => _SavingsGoalScreenState();
}

class _SavingsGoalScreenState extends State<SavingsGoalScreen> {

  final TextEditingController goalController = TextEditingController();

  int savingsGoal = 0;

  @override
  Widget build(BuildContext context) {

    // savings automatically calculated
    int savedAmount = widget.totalBudget - widget.totalSpent;

    if (savedAmount < 0) {
      savedAmount = 0;
    }

    int remaining = savingsGoal - savedAmount;

    if (remaining < 0) {
      remaining = 0;
    }

    double progress = 0;

    if (savingsGoal > 0) {
      progress = savedAmount / savingsGoal;

      if (progress > 1) {
        progress = 1;
      }
    }

    return Scaffold(

      appBar: AppBar(
        title: const Text("Savings Goal"),
        backgroundColor: const Color(0xFFD4A373),
      ),

      body: Padding(
        padding: const EdgeInsets.all(20),

        child: Column(

          children: [

            TextField(
              controller: goalController,
              keyboardType: TextInputType.number,
              decoration: InputDecoration(
                hintText: "Enter Savings Goal (₹)",
                border: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(12),
                ),
              ),
            ),

            const SizedBox(height: 20),

            ElevatedButton(

              onPressed: () {

                setState(() {
                  savingsGoal = int.tryParse(goalController.text) ?? 0;
                  goalController.clear();
                });

              },

              style: ElevatedButton.styleFrom(
                backgroundColor: const Color(0xFFD4A373),
              ),

              child: const Text("Set Goal"),

            ),

            const SizedBox(height: 40),

            Text(
              "Saved from Budget: ₹$savedAmount",
              style: const TextStyle(
                fontSize: 18,
                fontWeight: FontWeight.bold,
              ),
            ),

            Text(
              "Remaining to Goal: ₹$remaining",
              style: const TextStyle(
                fontSize: 18,
                fontWeight: FontWeight.bold,
              ),
            ),

            const SizedBox(height: 20),

            LinearProgressIndicator(
              value: progress,
              minHeight: 10,
              backgroundColor: Colors.grey,
              color: Colors.green,
            ),

            const SizedBox(height: 20),

            if (savedAmount >= savingsGoal && savingsGoal > 0)
              const Text(
                "🎉 Goal Achieved!",
                style: TextStyle(
                  fontSize: 18,
                  fontWeight: FontWeight.bold,
                  color: Colors.green,
                ),
              ),

          ],
        ),
      ),
    );
  }
}