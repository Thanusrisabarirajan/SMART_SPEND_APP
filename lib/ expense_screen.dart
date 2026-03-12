import 'package:flutter/material.dart';

class ExpenseScreen extends StatefulWidget {

  final int totalBudget;
  final int lastWeekSavings;

  const ExpenseScreen({
    super.key,
    required this.totalBudget,
    required this.lastWeekSavings,
  });

  @override
  State<ExpenseScreen> createState() => _ExpenseScreenState();
}

class _ExpenseScreenState extends State<ExpenseScreen> {

  TextEditingController expenseController = TextEditingController();

  int remainingBudget = 0;
  int remainingLastWeek = 0;

  String message = "";
  Color messageColor = Colors.black;

  @override
  void initState() {
    super.initState();
    remainingBudget = widget.totalBudget;
    remainingLastWeek = widget.lastWeekSavings;
  }

  void addExpense() {

    int expense = int.tryParse(expenseController.text) ?? 0;

    if (expense <= remainingBudget) {

      setState(() {
        remainingBudget -= expense;
        message = "Expense added successfully";
        messageColor = Colors.green;
      });

    } else {

      int needed = expense - remainingBudget;

      if (needed <= remainingLastWeek) {

        setState(() {
          remainingLastWeek -= needed;
          remainingBudget = 0;
          message = "Used ₹$needed from last week savings";
          messageColor = Colors.orange;
        });

      } else {

        setState(() {
          message = "Not sufficient amount";
          messageColor = Colors.red;
        });

      }

    }

    expenseController.clear();
  }

  @override
  Widget build(BuildContext context) {

    return Scaffold(

      appBar: AppBar(
        title: const Text("Expense Tracker"),
        backgroundColor: const Color(0xFFD4A373),
      ),

      body: Padding(
        padding: const EdgeInsets.all(20),

        child: Column(

          children: [

            Text(
              "Current Budget: ₹$remainingBudget",
              style: const TextStyle(
                fontSize: 18,
                fontWeight: FontWeight.bold,
              ),
            ),

            const SizedBox(height: 10),

            Text(
              "Last Week Savings: ₹$remainingLastWeek",
              style: const TextStyle(
                fontSize: 18,
                fontWeight: FontWeight.bold,
              ),
            ),

            const SizedBox(height: 30),

            TextField(
              controller: expenseController,
              keyboardType: TextInputType.number,

              decoration: InputDecoration(
                hintText: "Enter expense amount",

                border: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(15),
                ),
              ),
            ),

            const SizedBox(height: 20),

            ElevatedButton(

              onPressed: addExpense,

              style: ElevatedButton.styleFrom(
                backgroundColor: const Color(0xFFD4A373),
                padding: const EdgeInsets.symmetric(
                  horizontal: 40,
                  vertical: 15,
                ),
              ),

              child: const Text("Add Expense"),

            ),

            const SizedBox(height: 20),

            Text(
              message,
              style: TextStyle(
                fontSize: 18,
                fontWeight: FontWeight.bold,
                color: messageColor,
              ),
            ),

          ],
        ),
      ),
    );
  }
}