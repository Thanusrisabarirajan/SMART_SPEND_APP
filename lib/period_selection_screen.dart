import 'package:flutter/material.dart';

class PeriodSelectionScreen extends StatelessWidget {
  const PeriodSelectionScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [

            const Text(
              "Choose Your Budget Period",
              style: TextStyle(
                fontSize: 28,
                fontWeight: FontWeight.bold,
              ),
            ),

            const SizedBox(height: 50),

            ElevatedButton(
              onPressed: () {
                print("Weekly Selected");
              },
              style: ElevatedButton.styleFrom(
                backgroundColor: Colors.green,
                padding: const EdgeInsets.symmetric(
                    horizontal: 40, vertical: 15),
              ),
              child: const Text(
                "Weekly Budget",
                style: TextStyle(fontSize: 20),
              ),
            ),

            const SizedBox(height: 20),

            ElevatedButton(
              onPressed: () {
                print("Monthly Selected");
              },
              style: ElevatedButton.styleFrom(
                backgroundColor: Colors.blue,
                padding: const EdgeInsets.symmetric(
                    horizontal: 40, vertical: 15),
              ),
              child: const Text(
                "Monthly Budget",
                style: TextStyle(fontSize: 20),
              ),
            ),

          ],
        ),
      ),
    );
  }
}