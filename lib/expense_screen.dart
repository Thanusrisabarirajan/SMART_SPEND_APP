import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'history_screen.dart';

class ExpenseScreen extends StatefulWidget {
  final List<Map<String, dynamic>> categories;
  final int weeklyBudget;

  const ExpenseScreen({
    super.key,
    required this.categories,
    required this.weeklyBudget,
  });

  @override
  State<ExpenseScreen> createState() => _ExpenseScreenState();
}

class _ExpenseScreenState extends State<ExpenseScreen> {

  final TextEditingController expenseController = TextEditingController();

  String? selectedCategory;

  List<Map<String, dynamic>> expenseHistory = [];
  List<Map<String, dynamic>> weeklyHistory = [];

  String message = "";
  Color messageColor = Colors.black;

  int totalSpent = 0;
  int weekNumber = 1;

  @override
  void initState() {
    super.initState();
    loadData();
  }

  // SAVE DATA
  Future<void> saveData() async {

    final prefs = await SharedPreferences.getInstance();

    prefs.setString(
      'categories',
      jsonEncode(widget.categories),
    );

    prefs.setString(
      'history',
      jsonEncode(expenseHistory),
    );

    prefs.setString(
      'weeklyHistory',
      jsonEncode(weeklyHistory),
    );

    prefs.setInt('totalSpent', totalSpent);
    prefs.setInt('weekNumber', weekNumber);
  }

  // LOAD DATA
  Future<void> loadData() async {

    final prefs = await SharedPreferences.getInstance();

    String? savedCategories = prefs.getString('categories');
    String? savedHistory = prefs.getString('history');
    String? savedWeekly = prefs.getString('weeklyHistory');

    int savedSpent = prefs.getInt('totalSpent') ?? 0;
    int savedWeek = prefs.getInt('weekNumber') ?? 1;

    setState(() {

      if (savedCategories != null) {
        widget.categories.clear();

        widget.categories.addAll(
          List<Map<String, dynamic>>.from(
            jsonDecode(savedCategories),
          ),
        );
      }

      if (savedHistory != null) {
        expenseHistory = List<Map<String, dynamic>>.from(
          jsonDecode(savedHistory),
        );
      }

      if (savedWeekly != null) {
        weeklyHistory = List<Map<String, dynamic>>.from(
          jsonDecode(savedWeekly),
        );
      }

      totalSpent = savedSpent;
      weekNumber = savedWeek;

    });
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

      saveData();

    } else {

      setState(() {
        message = "Category limit exceeded";
        messageColor = Colors.red;
      });

    }

    expenseController.clear();
  }

  void finishWeek() async {

    int finalSavings = widget.weeklyBudget - totalSpent;

    weeklyHistory.add({
      "week": weekNumber,
      "spent": totalSpent,
      "saved": finalSavings,
    });

    await saveData();

    showDialog(
      context: context,
      builder: (_) => AlertDialog(
        title: const Text("Weekly Summary"),
        content: Text(
          "🎉 You saved ₹$finalSavings this week!",
        ),
      ),
    );
  }

  void startNewWeek() async {

    setState(() {

      totalSpent = 0;
      expenseHistory.clear();

      weekNumber++;

    });

    await saveData();

    ScaffoldMessenger.of(context).showSnackBar(
      const SnackBar(
        content: Text("Started New Week"),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {

    int remainingBalance = widget.weeklyBudget - totalSpent;
    int finalSavings = widget.weeklyBudget - totalSpent;

    return Scaffold(

      appBar: AppBar(
        title: Text("Expense Tracker - Week $weekNumber"),
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
              ),
              child: const Text("Add Expense"),
            ),

            const SizedBox(height: 20),

            Text(
              message,
              style: TextStyle(color: messageColor),
            ),

            const SizedBox(height: 20),

            Text(
              "Remaining Balance: ₹$remainingBalance",
              style: const TextStyle(
                color: Colors.blue,
                fontSize: 18,
                fontWeight: FontWeight.bold,
              ),
            ),

            const SizedBox(height: 10),

            Text(
              "💰 Final Savings: ₹$finalSavings",
              style: const TextStyle(
                color: Colors.green,
                fontSize: 18,
                fontWeight: FontWeight.bold,
              ),
            ),

            const SizedBox(height: 20),

            ElevatedButton(
              onPressed: finishWeek,
              style: ElevatedButton.styleFrom(
                backgroundColor: Colors.green,
              ),
              child: const Text("Finish Week"),
            ),

            const SizedBox(height: 10),

            ElevatedButton(
              onPressed: startNewWeek,
              style: ElevatedButton.styleFrom(
                backgroundColor: Colors.orange,
              ),
              child: const Text("Start New Week"),
            ),

            const SizedBox(height: 10),

            ElevatedButton(
              onPressed: () {

                Navigator.push(
                  context,
                  MaterialPageRoute(
                    builder: (_) => HistoryScreen(
                      weeklyHistory: weeklyHistory,
                    ),
                  ),
                );

              },
              child: const Text("View Weekly History"),
            ),

            const SizedBox(height: 20),

            const Align(
              alignment: Alignment.centerLeft,
              child: Text(
                "Expense History",
                style: TextStyle(
                  fontWeight: FontWeight.bold,
                ),
              ),
            ),

            Expanded(
              child: ListView.builder(
                itemCount: expenseHistory.length,
                itemBuilder: (context, index) {
                  return ListTile(
                    title: Text(expenseHistory[index]["category"]),
                    trailing: Text(
                      "₹${expenseHistory[index]["amount"]}",
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