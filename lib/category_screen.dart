import 'package:flutter/material.dart';

class CategoryScreen extends StatefulWidget {
  const CategoryScreen({super.key});

  @override
  State<CategoryScreen> createState() => _CategoryScreenState();
}

class _CategoryScreenState extends State<CategoryScreen> {

  final TextEditingController categoryController = TextEditingController();
  final TextEditingController limitController = TextEditingController();

  List<Map<String, String>> categories = [];

  void addCategory() {
    if (categoryController.text.isNotEmpty && limitController.text.isNotEmpty) {
      setState(() {
        categories.add({
          "name": categoryController.text,
          "limit": limitController.text,
        });

        categoryController.clear();
        limitController.clear();
      });
    }
  }

  @override
  Widget build(BuildContext context) {
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

            const SizedBox(height: 15),

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
                      title: Text(categories[index]["name"]!),
                      subtitle: Text("Limit: ₹${categories[index]["limit"]}"),
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