import 'package:flutter_test/flutter_test.dart';

Future<void> theAppShowsAgentIdActivatedFloatAccountCreated(WidgetTester tester) async {
  await tester.pumpAndSettle();
  expect(find.text('KYC VERIFIED'), findsOneWidget);
}
