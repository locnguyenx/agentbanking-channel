import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:agentbanking_channel/main.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

void main() {
  TestWidgetsFlutterBinding.ensureInitialized();

  group('End-to-End Onboarding and Transaction Flow', () {
    testWidgets('Complete e-KYC Onboarding and a Bill Payment', (tester) async {
      tester.view.physicalSize = const Size(1024, 1024);
      tester.view.devicePixelRatio = 1.0;
      addTearDown(() => tester.view.resetPhysicalSize());

      await tester.pumpWidget(const ProviderScope(child: AgentBankingApp()));
      await tester.pumpAndSettle();

      // Login
      await tester.enterText(find.byType(TextField).at(0), 'AGENT01');
      await tester.enterText(find.byType(TextField).at(1), '123456');
      await tester.tap(find.text('LOGIN'));
      await tester.pump(const Duration(milliseconds: 1500));
      await tester.pumpAndSettle();

      // Dashboard
      expect(find.text('Agent Dashboard'), findsOneWidget);

      // Onboarding
      await tester.tap(find.byKey(const Key('btn_onboard')));
      await tester.pumpAndSettle();
      await tester.tap(find.text('START MYKAD SCAN'));
      await tester.pump(const Duration(seconds: 6));
      await tester.pumpAndSettle();
      await tester.tap(find.text('Savings Account-i'));
      await tester.pump(const Duration(seconds: 3));
      await tester.pumpAndSettle();
      await tester.tap(find.text('BACK TO DASHBOARD'));
      await tester.pumpAndSettle();

      // Bill Payment (Cash)
      await tester.tap(find.byKey(const Key('btn_bills')));
      await tester.pumpAndSettle();
      final fields = find.byType(TextField);
      await tester.enterText(fields.at(0), '1234');
      await tester.enterText(fields.at(1), 'REF123');
      await tester.enterText(fields.at(2), '50.00');
      
      await tester.tap(find.text('PROCEED'));
      await tester.pump(const Duration(seconds: 1));
      await tester.pump(const Duration(seconds: 1));
      await tester.tap(find.text('Confirm'));
      // Wait for mock Dio "success"
      for (int i = 0; i < 5; i++) {
        await tester.pump(const Duration(seconds: 1));
      }
      await tester.pump(const Duration(milliseconds: 500));
      expect(find.text('Success!'), findsOneWidget);
      await tester.tap(find.text('DONE'));
      await tester.pump(const Duration(seconds: 1));
      expect(find.text('RM 5,000.00'), findsOneWidget);
    });

    testWidgets('Bill Payment with CARD should require card insertion', (tester) async {
      tester.view.physicalSize = const Size(1024, 1024);
      tester.view.devicePixelRatio = 1.0;
      addTearDown(() => tester.view.resetPhysicalSize());

      await tester.pumpWidget(const ProviderScope(child: AgentBankingApp()));
      await tester.pump(const Duration(seconds: 1));

      await tester.enterText(find.byType(TextField).at(0), 'AGENT01');
      await tester.enterText(find.byType(TextField).at(1), '123456');
      await tester.tap(find.text('LOGIN'));
      await tester.pump(const Duration(milliseconds: 1500));
      await tester.pump(const Duration(seconds: 2));

      await tester.tap(find.byKey(const Key('btn_bills')));
      await tester.pump(const Duration(seconds: 1));
      await tester.tap(find.byKey(const Key('funding_source_CARD_EMV')));
      await tester.pump(const Duration(seconds: 1));

      final fields = find.byType(TextField);
      await tester.enterText(fields.at(0), '1234');
      await tester.enterText(fields.at(1), 'REF123');
      await tester.enterText(fields.at(2), '50.00');
      
      await tester.tap(find.text('PROCEED'));
      await tester.pump(const Duration(seconds: 1));

      await tester.tap(find.text('Confirm'));
      // Wait for card insertion prompt
      for (int i = 0; i < 3; i++) {
        await tester.pump(const Duration(seconds: 1));
      }
      await tester.pump(const Duration(milliseconds: 500));
      expect(find.text('Insert Customer Card'), findsOneWidget);
    });

    testWidgets('Bill Payment with DUITNOW should NOT require card insertion', (tester) async {
      tester.view.physicalSize = const Size(1024, 1024);
      tester.view.devicePixelRatio = 1.0;
      addTearDown(() => tester.view.resetPhysicalSize());

      await tester.pumpWidget(const ProviderScope(child: AgentBankingApp()));
      await tester.pump(const Duration(seconds: 1));

      await tester.enterText(find.byType(TextField).at(0), 'AGENT01');
      await tester.enterText(find.byType(TextField).at(1), '123456');
      await tester.tap(find.text('LOGIN'));
      await tester.pump(const Duration(milliseconds: 1500));
      await tester.pump(const Duration(seconds: 2));

      await tester.tap(find.byKey(const Key('btn_bills')));
      await tester.pump(const Duration(seconds: 1));
      await tester.tap(find.byKey(const Key('funding_source_DUITNOW_MOBILE')));
      await tester.pump(const Duration(seconds: 1));

      // DuitNow flow has 4 fields (Proxy + Biller + Ref + Amount)
      final fields = find.byType(TextField);
      await tester.enterText(fields.at(0), '0129999999'); 
      await tester.enterText(fields.at(1), '1234');
      await tester.enterText(fields.at(2), 'REF123');
      await tester.enterText(fields.at(3), '75.00');
      
      await tester.tap(find.text('PROCEED'));
      await tester.pump(const Duration(seconds: 1));

      await tester.tap(find.text('Confirm'));
      await tester.pump(const Duration(seconds: 1));
      // Advance clock for 5 polling iterations of 2s each
      for (int i = 0; i < 5; i++) {
        await tester.pump(const Duration(seconds: 2));
      }
      await tester.pump(const Duration(milliseconds: 500));

      expect(find.text('Success!'), findsOneWidget);
      await tester.tap(find.text('DONE'));
      await tester.pump(const Duration(seconds: 1));
      expect(find.text('RM 5,000.00'), findsOneWidget);
    });
  });
}
