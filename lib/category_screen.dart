import 'package:flutter/material.dart';
import 'expense_screen.dart';

class CategoryScreen extends StatefulWidget {
  final int totalBudget;

  const CategoryScreen({super.key, required this.totalBudget});

  @override
  State<CategoryScreen> createState() => _CategoryScreenState();
}

class _CategoryScreenState extends State<CategoryScreen> {

  final TextEditingController categoryController = TextEditingController();
  final TextEditingController limitController = TextEditingController();

  final List<Map<String, dynamic>> categories = [];

  int totalAllocated = 0;

  void addCategory() {
    String name = categoryController.text.trim();
    int limit = int.tryParse(limitController.text) ?? 0;

    if (name.isEmpty || limit <= 0) return;

    if (totalAllocated + limit > widget.totalBudget) {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(content: Text("Exceeds budget")),
      );
      return;
    }

    setState(() {
      categories.add({
        "name": name,
        "limit": limit,
      });

      totalAllocated += limit;
    });

    categoryController.clear();
    limitController.clear();
  }

  @override
  Widget build(BuildContext context) {

    int saved = widget.totalBudget - totalAllocated;

    return Scaffold(
      appBar: AppBar(title: const Text("Categories")),

      body: Padding(
        padding: const EdgeInsets.all(20),
        child: Column(

          children: [

            TextField(
              controller: categoryController,
              decoration: const InputDecoration(
                hintText: "Category name",
              ),
            ),

            const SizedBox(height: 10),

            TextField(
              controller: limitController,
              keyboardType: TextInputType.number,
              decoration: const InputDecoration(
                hintText: "Amount",
              ),
            ),

            const SizedBox(height: 10),

            ElevatedButton(
              onPressed: addCategory,
              child: const Text("Add Category"),
            ),

            const SizedBox(height: 20),

            Text(
              "💰 Saved from Allocation: ₹$saved",
              style: const TextStyle(color: Colors.green),
            ),

            const SizedBox(height: 20),

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