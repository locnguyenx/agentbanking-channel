import 'package:flutter_test/flutter_test.dart';
import 'package:agentbanking_channel/features/transactions/screens/transaction_flow_screen.dart';
import '../../bdd_test_helper.dart';

Future<void> thisCommissionValueIsNeverShownOnTheCustomerFacingDisplay(WidgetTester tester) async {
  await tester.pumpAndSettle();
  
  // Toggle to Customer View using the provider in the BDD container
  bddContainer.read(isCustomerViewProvider.notifier).state = true;
  await tester.pumpAndSettle();

  // Commission amounts like '0.50' should be hidden from customer display
  expect(find.textContaining('0.50'), findsNothing);
  expect(find.textContaining('Commission'), findsNothing);
  expect(find.textContaining('AGENT COMMISSION'), findsNothing);
  
  // Reset for next steps (though BDD steps usually clean up)
  bddContainer.read(isCustomerViewProvider.notifier).state = false;
  await tester.pumpAndSettle();
}
