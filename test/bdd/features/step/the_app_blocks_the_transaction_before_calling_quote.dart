import 'package:flutter_test/flutter_test.dart';

Future<void> theAppBlocksTheTransactionBeforeCallingQuote(WidgetTester tester) async {
  // Verification is done in subsequent steps looking for the error code
  await tester.pumpAndSettle();
}
