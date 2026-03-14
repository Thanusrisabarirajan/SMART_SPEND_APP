import 'package:flutter/material.dart';

class SavingsGoalScreen extends StatefulWidget {
  const SavingsGoalScreen({super.key});

  @override
  State<SavingsGoalScreen> createState() => _SavingsGoalScreenState();
}

class _SavingsGoalScreenState extends State<SavingsGoalScreen> {

  final TextEditingController goalController = TextEditingController();

  int savingsGoal = 0;
  int savedAmount = 0;

  @override
  Widget build(BuildContext context) {

    int remaining = savingsGoal - savedAmount;

    double progress = 0;

    if (savingsGoal > 0) {
      progress = savedAmount / savingsGoal;
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
                });

              },

              style: ElevatedButton.styleFrom(
                backgroundColor: const Color(0xFFD4A373),
              ),

              child: const Text("Set Goal"),

            ),

            const SizedBox(height: 40),

            Text(
              "Saved: ₹$savedAmount",
              style: const TextStyle(
                fontSize: 18,
                fontWeight: FontWeight.bold,
              ),
            ),

            Text(
              "Remaining: ₹$remaining",
              style: const TextStyle(
                fontSize: 18,
                fontWeight: FontWeight.bold,
              ),
            ),

            const SizedBox(height: 20),

            LinearProgressIndicator(
              value: progress,
              minHeight: 10,
              backgroundColor: Colors.grey[300],
              color: Colors.green,
            ),

            const SizedBox(height: 30),

            ElevatedButton(

              onPressed: () {

                setState(() {
                  savedAmount += 100; // demo increment
                });

              },

              style: ElevatedButton.styleFrom(
                backgroundColor: Colors.green,
              ),

              child: const Text("Add ₹100 to Savings"),

            ),

          ],
        ),
      ),
    );
  }
}