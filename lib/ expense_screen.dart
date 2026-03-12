import 'package:flutter/material.dart';

class ExpenseScreen extends StatefulWidget {
  const ExpenseScreen({super.key});

  @override
  State<ExpenseScreen> createState() => _ExpenseScreenState();
}

class _ExpenseScreenState extends State<ExpenseScreen> {

  final TextEditingController amountController = TextEditingController();

  String selectedCategory = "Food";

  List<String> categories = [
    "Food",
    "Transport",
    "Snacks",
    "Recharge",
  ];

  List<Map<String, String>> expenses = [];

  void addExpense() {

    if (amountController.text.isNotEmpty) {

      setState(() {

        expenses.add({
          "amount": amountController.text,
          "category": selectedCategory
        });

        amountController.clear();

      });

    }

  }

  @override
  Widget build(BuildContext context) {

    return Scaffold(

      appBar: AppBar(
        title: const Text("Add Expense"),
        backgroundColor: const Color(0xFFD4A373),
      ),

      body: Padding(
        padding: const EdgeInsets.all(20),

        child: Column(
          children: [

            TextField(
              controller: amountController,
              keyboardType: TextInputType.number,
              decoration: InputDecoration(
                hintText: "Enter amount ₹",
                border: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(12),
                ),
              ),
            ),

            const SizedBox(height: 15),

            DropdownButton<String>(
              value: selectedCategory,

              items: categories.map((String category) {

                return DropdownMenuItem<String>(
                  value: category,
                  child: Text(category),
                );

              }).toList(),

              onChanged: (value) {

                setState(() {
                  selectedCategory = value!;
                });

              },
            ),

            const SizedBox(height: 15),

            ElevatedButton(
              onPressed: addExpense,
              style: ElevatedButton.styleFrom(
                backgroundColor: const Color(0xFFD4A373),
              ),
              child: const Text("Add Expense"),
            ),

            const SizedBox(height: 20),

            Expanded(
              child: ListView.builder(
                itemCount: expenses.length,
                itemBuilder: (context, index) {

                  return ListTile(
                    title: Text("₹${expenses[index]["amount"]}"),
                    subtitle: Text(expenses[index]["category"]!),
                  );

                },
              ),
            )

          ],
        ),
      ),

    );

  }
}