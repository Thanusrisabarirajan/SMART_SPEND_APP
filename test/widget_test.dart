import 'package:flutter_test/flutter_test.dart';
import 'package:smart_spend_app/main.dart';

void main() {
  testWidgets('App loads successfully', (WidgetTester tester) async {

    // Build the app
    await tester.pumpWidget(const SmartSpendApp());

    // Verify app loads
    expect(find.byType(SmartSpendApp), findsOneWidget);

  });
}