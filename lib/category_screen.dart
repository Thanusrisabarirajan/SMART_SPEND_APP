import 'package:flutter/material.dart';

class CategoryScreen extends StatefulWidget {

  final int totalBudget;

  const CategoryScreen({super.key, required this.totalBudget});

  @override
  State<CategoryScreen> createState() => _CategoryScreenState();
}

class _CategoryScreenState extends State<CategoryScreen> {

  final TextEditingController categoryController = TextEditingController();
  final TextEditingController limitController = TextEditingController();

  List<Map<String, int>> categories = [];

  int totalCategoryLimits = 0;

  void addCategory() {

    if (categoryController.text.isEmpty || limitController.text.isEmpty) {
      return;
    }

    int newLimit = int.parse(limitController.text);

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
        "name": categoryController.text,
        "limit": newLimit,
      });

      totalCategoryLimits += newLimit;

      categoryController.clear();
      limitController.clear();

    });

  }

  @override
  Widget build(BuildContext context) {

    int savings = widget.totalBudget - totalCategoryLimits;

    return Scaffold(

      appBar: AppBar(
        title: const Text("Create Categories"),
        backgroundColor: const Color(0xFFD4A373),
      ),

      body: Padding(
        padding: const EdgeInsets.all(20),

        child: Column(

          children: [

            Text(
              "Total Budget: ₹${widget.totalBudget}",
              style: const TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
            ),

            const SizedBox(height: 10),

            Text(
              "Savings: ₹$savings",
              style: const TextStyle(fontSize: 18, color: Colors.green),
            ),

            const SizedBox(height: 20),

            TextField(
              controller: categoryController,
              decoration: InputDecoration(
                hintText: "Category name (Food, Transport...)",
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
                hintText: "Spending limit ₹",
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

            Expanded(
              child: ListView.builder(
                itemCount: categories.length,
                itemBuilder: (context, index) {

                  return Card(
                    child: ListTile(
                      title: Text(categories[index]["name"].toString()),
                      subtitle: Text(
                        "Limit: ₹${categories[index]["limit"]}",
                      ),
                    ),
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