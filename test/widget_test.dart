// This is a basic Flutter widget test.
//
// To perform an interaction with a widget in your test, use the WidgetTester
// utility that Flutter provides. For example, you can send tap and scroll
// gestures. You can also use WidgetTester to find child widgets in the widget
// tree, read text, and verify that the values of widget properties are correct.

import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:inkrement/counter/domain/counter.dart';
import 'package:inkrement/counter/presentation/counter_tile.dart';

void main() {
  group("CounterTile", () {
    testWidgets('value should be incremented', (WidgetTester tester) async {
      await tester.pumpWidget(CounterTile(
          counter: Counter(null, "test", "Test", 5),
          onIncrement: (counter, value) {}));

      expect(find.text('5'), findsOneWidget);

      await tester.tap(find.byIcon(Icons.arrow_upward));
      await tester.pump(const Duration(seconds: 1));

      expect(find.text('5'), findsNothing);
      expect(find.text('6'), findsWidgets);
    });
  });
}
