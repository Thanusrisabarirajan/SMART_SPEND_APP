import 'package:flutter/material.dart';
import 'category_screen.dart';

class BudgetInputScreen extends StatefulWidget {
  const BudgetInputScreen({super.key});

  @override
  State<BudgetInputScreen> createState() => _BudgetInputScreenState();
}

class _BudgetInputScreenState extends State<BudgetInputScreen> {

  final TextEditingController budgetController = TextEditingController();

  void goToCategoryScreen() {

    String budgetText = budgetController.text.trim();

    if (budgetText.isEmpty) {

      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(
          content: Text("Please enter your budget"),
        ),
      );

      return;
    }

    int? budget = int.tryParse(budgetText);

    if (budget == null || budget <= 0) {

      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(
          content: Text("Enter a valid budget amount"),
        ),
      );

      return;
    }

    Navigator.push(
      context,
      MaterialPageRoute(
        builder: (context) => CategoryScreen(
          totalBudget: budget,
        ),
      ),
    );

  }

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
                  fontSize: 30,
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

                  focusedBorder: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(15),
                    borderSide: const BorderSide(
                      color: Color(0xFFD4A373),
                      width: 2,
                    ),
                  ),
                ),
              ),

              const SizedBox(height: 35),

              ElevatedButton(

                onPressed: goToCategoryScreen,

                style: ElevatedButton.styleFrom(
                  backgroundColor: const Color(0xFFD4A373),

                  padding: const EdgeInsets.symmetric(
                    horizontal: 50,
                    vertical: 16,
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

              ),

            ],
          ),
        ),
      ),
    );
  }
}