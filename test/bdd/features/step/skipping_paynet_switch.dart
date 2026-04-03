import 'package:flutter_test/flutter_test.dart';

Future<void> skippingPaynetSwitch(WidgetTester tester) async {
  await tester.pumpAndSettle();
  // No-op for BDD compliance
}
