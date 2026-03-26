import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:agentbanking_channel/main.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

void main() {
  // Use standard widget test binding
  TestWidgetsFlutterBinding.ensureInitialized();

  group('End-to-End Onboarding and Transaction Flow', () {
    testWidgets('Complete e-KYC Onboarding and a Bill Payment', (tester) async {
      // Set larger surface size to avoid scrolling issues
      tester.view.physicalSize = const Size(1024, 1024);
      tester.view.devicePixelRatio = 1.0;
      addTearDown(() => tester.view.resetPhysicalSize());

      await tester.pumpWidget(
        const ProviderScope(
          child: AgentBankingApp(),
        ),
      );
      await tester.pumpAndSettle();

      // 0. Login
      expect(find.text('Secure Terminal Login'), findsOneWidget);
      await tester.enterText(find.widgetWithText(TextField, 'Agent ID'), 'AGENT01');
      await tester.enterText(find.widgetWithText(TextField, 'Password'), '123456');
      await tester.tap(find.text('LOGIN'));
      
      // Wait for mock delay + navigation
      await tester.pump(const Duration(milliseconds: 1500));
      await tester.pumpAndSettle();

      // 1. Verify Home Screen
      expect(find.text('Agent Dashboard'), findsOneWidget);
      expect(find.text('RM 5,000.00'), findsOneWidget);

      // 2. Navigate to Onboarding
      await tester.tap(find.byKey(const Key('btn_onboard')));
      await tester.pumpAndSettle();

      // 3. Scan MyKad (Simulated)
      expect(find.text('Customer Onboarding'), findsOneWidget);
      final scanButton = find.text('START MYKAD SCAN');
      await tester.tap(scanButton);
      
      // Wait for Scan (3s) + Validate (1s)
      await tester.pump(const Duration(seconds: 6));
      await tester.pumpAndSettle();

      // 4. Verify Approval and Product Selection
      expect(find.text('SELECT ACCOUNT PRODUCT'), findsOneWidget);
      await tester.tap(find.text('Savings Account-i'));
      await tester.pump(const Duration(seconds: 3));
      await tester.pumpAndSettle();
      
      // 5. Success
      expect(find.text('Welcome Aboard!'), findsOneWidget);
      await tester.tap(find.text('BACK TO DASHBOARD'));
      await tester.pumpAndSettle();

      // 6. Perform a Bill Payment
      expect(find.text('Agent Dashboard'), findsOneWidget);
      await tester.tap(find.byKey(const Key('btn_bills')));
      await tester.pumpAndSettle();

      // Enter details
      expect(find.text('Bill Payment'), findsOneWidget);
      final textFields = find.byType(TextField);
      await tester.enterText(textFields.at(0), '1234'); // Biller Code
      await tester.enterText(textFields.at(1), 'REF123'); // Ref-1
      await tester.enterText(textFields.at(2), '50.00'); // Amount
      
      await tester.tap(find.text('PROCEED'));
      await tester.pump(const Duration(seconds: 1));
      await tester.pumpAndSettle();

      // Verify Quote
      expect(find.text('Confirm Details'), findsOneWidget);
      await tester.tap(find.text('Confirm'));
      // Execute (2s)
      await tester.pump(const Duration(seconds: 3));
      await tester.pumpAndSettle();

      // Final Receipt
      expect(find.text('Success!'), findsOneWidget);
      
      // Verify Float Debit (50.00)
      await tester.tap(find.text('DONE'));
      await tester.pumpAndSettle();
      expect(find.text('RM 4,950.00'), findsOneWidget);

      // 7. Perform an eSSP Purchase
      await tester.tap(find.byKey(const Key('btn_essp')));
      await tester.pumpAndSettle();
      
      expect(find.text('eSSP Purchase'), findsNWidgets(2));
      final ssTextFields = find.byType(TextField);
      await tester.enterText(ssTextFields.at(0), 'MYKAD880101');
      await tester.enterText(ssTextFields.at(1), '100.00');
      
      await tester.tap(find.text('PURCHASE'));
      await tester.pumpAndSettle();
      
      expect(find.text('Confirm Details'), findsOneWidget);
      await tester.tap(find.text('Confirm'));
      await tester.pump(const Duration(seconds: 3));
      await tester.pumpAndSettle();
      
      expect(find.text('Success!'), findsOneWidget);
      await tester.tap(find.text('DONE'));
      await tester.pumpAndSettle();
      
      // Verify final float (4950 - 100 = 4850)
      expect(find.text('RM 4,850.00'), findsOneWidget);
    });

    testWidgets('Bill Payment with CARD should require card insertion', (tester) async {
      tester.view.physicalSize = const Size(1024, 1024);
      tester.view.devicePixelRatio = 1.0;
      addTearDown(() => tester.view.resetPhysicalSize());

      await tester.pumpWidget(const ProviderScope(child: AgentBankingApp()));
      await tester.pumpAndSettle();

      // Login
      await tester.enterText(find.widgetWithText(TextField, 'Agent ID'), 'AGENT01');
      await tester.enterText(find.widgetWithText(TextField, 'Password'), '123456');
      await tester.tap(find.text('LOGIN'));
      await tester.pump(const Duration(milliseconds: 1500));
      await tester.pumpAndSettle();

      // 1. Navigate to Bills
      await tester.tap(find.byKey(const Key('btn_bills')));
      await tester.pumpAndSettle();

      // 2. Select CARD as funding source
      expect(find.text('SELECT FUNDING SOURCE'), findsOneWidget);
      final cardOption = find.text('CARD');
      await tester.tap(cardOption);
      await tester.pumpAndSettle();

      // Enter Details
      final textFields = find.byType(TextField);
      await tester.enterText(textFields.at(0), '1234');
      await tester.enterText(textFields.at(1), 'REF123');
      await tester.enterText(textFields.at(2), '50.00');
      
      await tester.tap(find.text('PROCEED'));
      await tester.pumpAndSettle();

      // Confirm Quote
      await tester.tap(find.text('Confirm'));
      await tester.pumpAndSettle();

      // 3. Verify that it asks for CARD insertion instead of just processing
      expect(find.text('Insert Customer Card'), findsOneWidget);

      // Wait for simulated hardware timers to finish to avoid test failure
      await tester.pump(const Duration(seconds: 5));
      await tester.pumpAndSettle();
    });

    testWidgets('Bill Payment with DUITNOW should NOT require card insertion', (tester) async {
      tester.view.physicalSize = const Size(1024, 1024);
      tester.view.devicePixelRatio = 1.0;
      addTearDown(() => tester.view.resetPhysicalSize());

      await tester.pumpWidget(const ProviderScope(child: AgentBankingApp()));
      await tester.pumpAndSettle();

      // Login
      await tester.enterText(find.widgetWithText(TextField, 'Agent ID'), 'AGENT01');
      await tester.enterText(find.widgetWithText(TextField, 'Password'), '123456');
      await tester.tap(find.text('LOGIN'));
      await tester.pump(const Duration(milliseconds: 1500));
      await tester.pumpAndSettle();

      // 1. Navigate to Bills
      await tester.tap(find.byKey(const Key('btn_bills')));
      await tester.pumpAndSettle();

      // 2. Select DUITNOW
      await tester.tap(find.text('DUITNOW'));
      await tester.pumpAndSettle();

      // Details (Proxy, Biller, Ref, Amount)
      final textFields = find.byType(TextField);
      await tester.enterText(textFields.at(0), '0129999999'); // Proxy ID
      await tester.enterText(textFields.at(1), '1234'); // Biller
      await tester.enterText(textFields.at(2), 'REF123'); // Ref
      await tester.enterText(textFields.at(3), '75.00'); // Amount
      
      await tester.tap(find.text('PROCEED'));
      await tester.pumpAndSettle();

      // Confirm
      await tester.tap(find.text('Confirm'));
      // Wait for DuitNow POLLING (10s)
      await tester.pump(const Duration(seconds: 12));
      await tester.pumpAndSettle();

      // 3. Verify it goes straight to success or processing (simulated)
      expect(find.text('Success!'), findsOneWidget);
    });
  });
}
