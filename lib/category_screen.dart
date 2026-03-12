import 'package:flutter/material.dart';

class CategoryScreen extends StatefulWidget {
  final int totalBudget;

  const CategoryScreen({super.key, required this.totalBudget});

  @override
  State<CategoryScreen> createState() => _CategoryScreenState();
}

class _CategoryScreenState extends State<CategoryScreen> {

  TextEditingController categoryController = TextEditingController();
  TextEditingController limitController = TextEditingController();

  List<Map<String, dynamic>> categories = [];

  int totalCategoryLimits = 0;

  void addCategory() {

    String categoryName = categoryController.text;
    int newLimit = int.tryParse(limitController.text) ?? 0;

    if (categoryName.isEmpty || newLimit == 0) {
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

                  return Card(
                    child: ListTile(
                      title: Text(categories[index]["name"]),
                      subtitle: Text(
                        "Limit: ₹${categories[index]["limit"]}",
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