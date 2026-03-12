import 'package:flutter/material.dart';
import 'category_screen.dart';

class BudgetInputScreen extends StatefulWidget {
  const BudgetInputScreen({super.key});

  @override
  State<BudgetInputScreen> createState() => _BudgetInputScreenState();
}

class _BudgetInputScreenState extends State<BudgetInputScreen> {

  TextEditingController budgetController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,

      body: Center(
        child: Padding(
          padding: const EdgeInsets.all(30),

          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [

              const Text(
                "Enter Your Budget",
                style: TextStyle(
                  fontSize: 28,
                  fontWeight: FontWeight.bold,
                ),
              ),

              const SizedBox(height: 40),

              TextField(
                controller: budgetController,
                keyboardType: TextInputType.number,

                decoration: InputDecoration(
                  hintText: "Enter amount (₹)",
                  border: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(15),
                  ),
                ),
              ),

              const SizedBox(height: 30),

              ElevatedButton(
                onPressed: () {

                  String budget = budgetController.text;

                  if (budget.isNotEmpty) {

                    Navigator.push(
                      context,
                      MaterialPageRoute(
                        builder: (context) => const CategoryScreen(),
                      ),
                    );

                  } else {

                    ScaffoldMessenger.of(context).showSnackBar(
                      const SnackBar(
                        content: Text("Please enter a budget amount"),
                      ),
                    );

                  }

                },

                style: ElevatedButton.styleFrom(
                  backgroundColor: const Color(0xFFD4A373),

                  padding: const EdgeInsets.symmetric(
                    horizontal: 40,
                    vertical: 15,
                  ),

                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(30),
                  ),
                ),

                child: const Text(
                  "Continue",
                  style: TextStyle(
                    fontSize: 18,
                    fontWeight: FontWeight.bold,
                    color: Colors.white,
                  ),
                ),

              )

            ],
          ),
        ),
      ),
    );
  }
}