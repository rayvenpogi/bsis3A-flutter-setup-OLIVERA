import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:my_quiz_app/main.dart';

void main() {
  testWidgets('Mini Form Smoke Test', (WidgetTester tester) async {
    await tester.pumpWidget(const MaterialApp(home: MiniForm()));

    expect(find.text('Mini Form'), findsOneWidget);
    expect(find.text('Submit'), findsOneWidget);
  });
}