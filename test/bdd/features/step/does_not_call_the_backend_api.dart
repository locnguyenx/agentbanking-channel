import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';

Future<void> doesNotCallTheBackendApi(WidgetTester tester) async {
  await tester.pumpAndSettle();
  final token = find.byKey(const Key('bdd_status_token'));
  expect(token, findsOneWidget);
  
  final text = tester.widget<Text>(token).data ?? '';
  // If we have an ERR_VAL (Validation Error), it's client-side
  expect(text.contains('ERR_VAL') || text.contains('failed'), isTrue);
  
  // We can also verify that we aren't in 'quoting' or 'processing' state
  expect(text.contains('quoting'), isFalse);
  expect(text.contains('processing'), isFalse);
}
