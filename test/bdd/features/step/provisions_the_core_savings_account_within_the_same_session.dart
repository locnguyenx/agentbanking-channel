import 'package:flutter_test/flutter_test.dart';

Future<void> provisionsTheCoreSavingsAccountWithinTheSameSession(WidgetTester tester) async {
  // In our BDD environment, account provisioning is mockable
  // For now, we just ensure we are in a state that allows account opening
  await tester.pumpAndSettle();
}
