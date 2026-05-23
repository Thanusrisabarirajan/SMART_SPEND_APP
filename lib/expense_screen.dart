void startNewWeek() async {

  setState(() {

    for (var category in widget.categories) {

      // carry forward logic
      int currentRemaining = category["limit"];

      // add original allocation again
      category["limit"] = currentRemaining + 200;

    }

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