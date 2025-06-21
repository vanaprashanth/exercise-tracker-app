import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:exercisetracker/screens/welcome_screen.dart'; // Make sure path matches your structure

void main() {
  testWidgets('Welcome screen loads correctly', (WidgetTester tester) async {
    await tester.pumpWidget(const MaterialApp(home: WelcomeScreen()));

    expect(find.text('Daily Exercises'), findsOneWidget);
    expect(find.text('Developed by Saiprashanth Vana'), findsOneWidget);
  });
}
