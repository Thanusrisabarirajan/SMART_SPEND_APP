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

    if (categoryName.isEmpty || newLimit <= 0) {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(content: Text("Enter valid category and limit")),
      );
      return;
    }

    if (totalCategoryLimits + newLimit > widget.totalBudget) {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(
          content: Text("Category limits exceed total budget"),
        ),
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
  void dispose() {
    categoryController.dispose();
    limitController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {

    final int savings = widget.totalBudget - totalCategoryLimits;

    return Scaffold(
      appBar: AppBar(
        title: const Text("Create Categories"),
        backgroundColor: const Color(0xFFD4A373),
      ),

      body: Padding(
        padding: const EdgeInsets.all(20),

        child: Column(
          children: [

            TextField(
              controller: categoryController,
              decoration: InputDecoration(
                hintText: "Category name (Food, Transport...)",
                border: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(12),
                ),
              ),
            ),

            const SizedBox(height: 15),

            TextField(
              controller: limitController,
              keyboardType: TextInputType.number,
              decoration: InputDecoration(
                hintText: "Spending limit ₹",
                border: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(12),
                ),
              ),
            ),

            const SizedBox(height: 15),

            ElevatedButton(
              onPressed: addCategory,
              style: ElevatedButton.styleFrom(
                backgroundColor: const Color(0xFFD4A373),
                padding: const EdgeInsets.symmetric(
                  horizontal: 35,
                  vertical: 15,
                ),
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(30),
                ),
              ),
              child: const Text(
                "Add Category",
                style: TextStyle(
                  fontSize: 16,
                  fontWeight: FontWeight.bold,
                ),
              ),
            ),

            const SizedBox(height: 25),

            Align(
              alignment: Alignment.centerLeft,
              child: Text(
                "Savings: ₹$savings",
                style: const TextStyle(
                  fontSize: 20,
                  fontWeight: FontWeight.bold,
                  color: Colors.green,
                ),
              ),
            ),

            const SizedBox(height: 20),

            Expanded(
              child: ListView.builder(
                itemCount: categories.length,
                itemBuilder: (context, index) {

                  final category = categories[index];

                  return Card(
                    elevation: 2,
                    margin: const EdgeInsets.only(bottom: 10),

                    child: ListTile(
                      title: Text(
                        category["name"],
                        style: const TextStyle(fontWeight: FontWeight.bold),
                      ),
                      subtitle: Text("Limit: ₹${category["limit"]}"),
                    ),
                  );
                },
              ),
            ),

            const SizedBox(height: 10),

            ElevatedButton(
              onPressed: () {

                if (categories.isEmpty) {
                  ScaffoldMessenger.of(context).showSnackBar(
                    const SnackBar(content: Text("Add at least one category")),
                  );
                  return;
                }

                Navigator.push(
                  context,
                  MaterialPageRoute(
                    builder: (context) => ExpenseScreen(
                      categories: categories,
                    ),
                  ),
                );

              },

              style: ElevatedButton.styleFrom(
                backgroundColor: const Color(0xFFD4A373),
                padding: const EdgeInsets.symmetric(
                  horizontal: 40,
                  vertical: 16,
                ),
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(30),
                ),
              ),

              child: const Text(
                "Continue to Expense Tracker",
                style: TextStyle(
                  fontSize: 16,
                  fontWeight: FontWeight.bold,
                ),
              ),
            ),

          ],
        ),
      ),
    );
  }
}