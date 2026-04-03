import 'package:flutter_test/flutter_test.dart';

Future<void> callsBackendPostApiv1transactionsquote(WidgetTester tester) async {
  // Quote is handled by the mock repository in bdd_test_helper
  // This step just acknowledges that the quote process is part of the flow
  await tester.pump();
}
