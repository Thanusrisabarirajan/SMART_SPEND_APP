import 'package:flutter/material.dart';
import 'expense_screen.dart';

class CategoryScreen extends StatefulWidget {
  final int totalBudget;

  const CategoryScreen({
    super.key,
    required this.totalBudget,
  });

  @override
  State<CategoryScreen> createState() => _CategoryScreenState();
}

class _CategoryScreenState extends State<CategoryScreen> {

  final TextEditingController categoryController = TextEditingController();
  final TextEditingController limitController = TextEditingController();

  final List<Map<String, dynamic>> categories = [];

  int totalCategoryLimits = 0;

  void addCategory() {

    final String categoryName = categoryController.text.trim();
    final int newLimit = int.tryParse(limitController.text) ?? 0;

    if (categoryName.isEmpty || newLimit <= 0) return;

    if (totalCategoryLimits + newLimit > widget.totalBudget) {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(content: Text("Exceeds budget")),
      );
      return;
    }

    setState(() {
      categories.add({
        "name": categoryName,
        "limit": newLimit,
      });

      totalCategoryLimits += newLimit;
    });

    categoryController.clear();
    limitController.clear();
  }

  @override
  Widget build(BuildContext context) {

    int remainingSavings = widget.totalBudget - totalCategoryLimits;

    return Scaffold(
      appBar: AppBar(title: const Text("Categories")),

      body: Padding(
        padding: const EdgeInsets.all(20),
        child: Column(

          children: [

            TextField(controller: categoryController),
            const SizedBox(height: 10),

            TextField(
              controller: limitController,
              keyboardType: TextInputType.number,
            ),

            const SizedBox(height: 10),

            ElevatedButton(
              onPressed: addCategory,
              child: const Text("Add Category"),
            ),

            const SizedBox(height: 20),

            Text(
              "Saved from Allocation: ₹$remainingSavings",
              style: const TextStyle(color: Colors.green),
            ),

            Expanded(
              child: ListView.builder(
                itemCount: categories.length,
                itemBuilder: (context, index) {
                  return ListTile(
                    title: Text(categories[index]["name"]),
                    trailing: Text("₹${categories[index]["limit"]}"),
                  );
                },
              ),
            ),

            ElevatedButton(
              onPressed: () {

                Navigator.push(
                  context,
                  MaterialPageRoute(
                    builder: (context) => ExpenseScreen(
                      categories: categories,
                      weeklyBudget: widget.totalBudget,
                    ),
                  ),
                );

              },
              child: const Text("Next"),
            )

          ],
        ),
      ),
    );
  }
}