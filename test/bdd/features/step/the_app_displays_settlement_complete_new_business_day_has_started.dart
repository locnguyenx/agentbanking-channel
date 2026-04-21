import 'package:flutter_test/flutter_test.dart';
import '../../bdd_test_helper.dart';

/// Usage: the app displays "Settlement Complete. New business day has started."
Future<void> theAppDisplaysSettlementCompleteNewBusinessDayHasStarted(WidgetTester tester) async {
  await waitFor(tester, find.textContaining('Settlement Complete'), timeout: const Duration(seconds: 20));
}
