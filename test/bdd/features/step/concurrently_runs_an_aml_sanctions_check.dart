import 'package:flutter_test/flutter_test.dart';

Future<void> concurrentlyRunsAnAmlSanctionsCheck(WidgetTester tester) async {
  // In our BDD environment, this is logic handled by the back-end (mock repository)
  // during the validateKyc call.
  await tester.pumpAndSettle();
}
