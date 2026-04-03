import 'package:flutter_test/flutter_test.dart';

/// Usage: the UI shows "Settlement in Progress - Please Wait"
Future<void> theUiShowsSettlementInProgressPleaseWait(WidgetTester tester) async {
  expect(find.textContaining('Settlement in Progress'), findsOneWidget);
}
