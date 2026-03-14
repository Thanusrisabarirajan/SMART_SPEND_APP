import 'package:flutter/material.dart';

class ExpenseScreen extends StatefulWidget {
  final List<Map<String, dynamic>> categories;

  const ExpenseScreen({super.key, required this.categories});

  @override
  State<ExpenseScreen> createState() => _ExpenseScreenState();
}

class _ExpenseScreenState extends State<ExpenseScreen> {

  TextEditingController expenseController = TextEditingController();

  String? selectedCategory;

  List<Map<String, dynamic>> expenseHistory = [];

  String message = "";
  Color messageColor = Colors.black;

  int totalSpent = 0;
  int totalBudget = 0;

  @override
  void initState() {
    super.initState();

    // calculate total budget from categories
    for (var cat in widget.categories) {
      totalBudget += cat["limit"] as int;
    }
  }

  void addExpense() {

    int expense = int.tryParse(expenseController.text) ?? 0;

    if (selectedCategory == null || expense <= 0) {
      setState(() {
        message = "Enter valid category and amount";
        messageColor = Colors.red;
      });
      return;
    }

    int index = widget.categories.indexWhere(
        (cat) => cat["name"] == selectedCategory);

    int remaining = widget.categories[index]["limit"];

    if (expense <= remaining) {

      setState(() {

        widget.categories[index]["limit"] -= expense;

        totalSpent += expense;

        expenseHistory.add({
          "category": selectedCategory,
          "amount": expense
        });

        message = "Expense added successfully";
        messageColor = Colors.green;

      });

      // spending reminder logic
      if (totalSpent > totalBudget * 0.7) {

        ScaffoldMessenger.of(context).showSnackBar(
          const SnackBar(
            content: Text(
              "⚠️ You are spending too fast. Try to control your expenses.",
            ),
          ),
        );

      }

    } else {

      setState(() {
        message = "Category limit exceeded";
        messageColor = Colors.red;
      });

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

            DropdownButtonFormField<String>(
              hint: const Text("Select Category"),
              value: selectedCategory,

              items: widget.categories.map((cat) {
                return DropdownMenuItem<String>(
                  value: cat["name"],
                  child: Text("${cat["name"]} (₹${cat["limit"]})"),
                );
              }).toList(),

              onChanged: (value) {
                setState(() {
                  selectedCategory = value;
                });
              },
            ),

            const SizedBox(height: 20),

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

            const SizedBox(height: 30),

            const Align(
              alignment: Alignment.centerLeft,
              child: Text(
                "Expense History",
                style: TextStyle(
                  fontSize: 18,
                  fontWeight: FontWeight.bold,
                ),
              ),
            ),

            const SizedBox(height: 10),

            Expanded(

              child: ListView.builder(

                itemCount: expenseHistory.length,

                itemBuilder: (context, index) {

                  return Card(

                    child: ListTile(

                      title: Text(expenseHistory[index]["category"]),

                      trailing: Text(
                        "₹${expenseHistory[index]["amount"]}",
                        style: const TextStyle(
                          fontWeight: FontWeight.bold,
                        ),
                      ),

                    ),

                  );

                },

              ),

            ),

          ],
        ),
      ),
    );
  }
}