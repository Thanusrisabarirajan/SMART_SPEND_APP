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
                color: Colors.black87,
              ),
            ),

            const SizedBox(height: 50),

            // Weekly Button
            ElevatedButton(
              onPressed: () {
                print("Weekly Selected");
              },

              style: ElevatedButton.styleFrom(
                backgroundColor: const Color(0xFFA8E6CF), // pastel green
                padding: const EdgeInsets.symmetric(
                  horizontal: 45,
                  vertical: 18,
                ),

                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(30),
                ),
              ),

              child: const Text(
                "Weekly Budget",
                style: TextStyle(
                  fontSize: 18,
                  fontWeight: FontWeight.bold,
                  color: Colors.black87,
                ),
              ),
            ),

            const SizedBox(height: 20),

            // Monthly Button
            ElevatedButton(
              onPressed: () {
                print("Monthly Selected");
              },

              style: ElevatedButton.styleFrom(
                backgroundColor: const Color(0xFFFFC1CC), // pastel pink
                padding: const EdgeInsets.symmetric(
                  horizontal: 40,
                  vertical: 18,
                ),

                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(30),
                ),
              ),

              child: const Text(
                "Monthly Budget",
                style: TextStyle(
                  fontSize: 18,
                  fontWeight: FontWeight.bold,
                  color: Colors.black87,
                ),
              ),
            ),

          ],
        ),
      ),
    );
  }
}