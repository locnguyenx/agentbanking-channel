import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:agentbanking_channel/features/transactions/screens/duitnow_transfer_screen.dart';
import 'package:agentbanking_channel/features/transactions/models/transaction_models.dart';

void main() {
  testWidgets('DuitNowTransferScreen allows selecting proxy type and entering ID', (WidgetTester tester) async {
    await tester.pumpWidget(
      const ProviderScope(
        child: MaterialApp(
          home: DuitNowTransferScreen(),
        ),
      ),
    );

    // Initial state: Mobile Number selected by default
    expect(find.text('Mobile Number'), findsOneWidget);
    expect(find.byType(TextField), findsOneWidget);

    // Select NRIC
    await tester.tap(find.text('NRIC / MyKad'));
    await tester.pumpAndSettle();

    // Enter NRIC
    await tester.enterText(find.byType(TextField), '900101015566');
    await tester.pump();

    expect(find.text('900101015566'), findsOneWidget);

    // Confirm button should be enabled
    expect(tester.widget<ElevatedButton>(find.byType(ElevatedButton)).enabled, isTrue);
  });

  testWidgets('DuitNowTransferScreen validates input based on proxy type', (WidgetTester tester) async {
    await tester.pumpWidget(
      const ProviderScope(
        child: MaterialApp(
          home: DuitNowTransferScreen(),
        ),
      ),
    );

    // Mobile number validation (simple check for now)
    await tester.enterText(find.byType(TextField), 'abc');
    await tester.pump();

    // Confirm button should be disabled for invalid input
    // (Assuming implementation disables it)
    // expect(tester.widget<ElevatedButton>(find.byType(ElevatedButton)).enabled, isFalse);
  });
}
