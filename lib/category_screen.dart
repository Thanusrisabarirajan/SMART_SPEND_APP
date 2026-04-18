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

    // ✅ validation
    if (name.isEmpty || limit <= 0) {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(content: Text("Enter valid data")),
      );
      return;
    }

    // ✅ prevent exceeding total budget
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

    // ✅ savings from allocation
    int saved = widget.totalBudget - totalAllocated;

    return Scaffold(
      appBar: AppBar(
        title: const Text("Categories"),
        backgroundColor: const Color(0xFFD4A373),
      ),

      body: Padding(
        padding: const EdgeInsets.all(20),

        child: Column(

          children: [

            TextField(
              controller: categoryController,
              decoration: InputDecoration(
                hintText: "Category name",
                border: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(12),
                ),
              ),
            ),

            const SizedBox(height: 10),

            TextField(
              controller: limitController,
              keyboardType: TextInputType.number,
              decoration: InputDecoration(
                hintText: "Amount",
                border: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(12),
                ),
              ),
            ),

            const SizedBox(height: 10),

            ElevatedButton(
              onPressed: addCategory,
              style: ElevatedButton.styleFrom(
                backgroundColor: const Color(0xFFD4A373),
              ),
              child: const Text("Add Category"),
            ),

            const SizedBox(height: 20),

            // ✅ IMPORTANT (your requirement)
            Text(
              "💰 Saved from Allocation: ₹$saved",
              style: const TextStyle(
                color: Colors.green,
                fontSize: 16,
                fontWeight: FontWeight.bold,
              ),
            ),

            const SizedBox(height: 20),

            Expanded(
              child: ListView.builder(
                itemCount: categories.length,
                itemBuilder: (context, index) {

                  return Card(
                    child: ListTile(
                      title: Text(categories[index]["name"]),
                      trailing: Text("₹${categories[index]["limit"]}"),
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
                      weeklyBudget: widget.totalBudget, // ✅ IMPORTANT
                    ),
                  ),
                );

              },
              style: ElevatedButton.styleFrom(
                backgroundColor: const Color(0xFFD4A373),
              ),
              child: const Text("Next"),
            )

          ],
        ),
      ),
    );
  }
}