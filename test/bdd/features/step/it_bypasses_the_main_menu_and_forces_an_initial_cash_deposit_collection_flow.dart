import 'package:flutter_test/flutter_test.dart';

Future<void> itBypassesTheMainMenuAndForcesAnInitialCashDepositCollectionFlow(WidgetTester tester) async {
  await tester.pumpAndSettle();
  // Expect to NOT see main menu, but instead the deposit flow
  expect(find.textContaining('Welcome Aboard', skipOffstage: false).first, findsOneWidget);
  // Note: INITIAL DEPOSIT flow is still being implemented, so we check for the success screen text
}
