import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:agentbanking_channel/features/transactions/services/validation_service.dart';
import 'package:agentbanking_channel/features/transactions/screens/bill_payment_form.dart';

void main() {
  group('ValidationService', () {
    test('isValidRef1 validates alphanumeric format', () {
      expect(ValidationService.isValidRef1('ABC12345'), true);
      expect(ValidationService.isValidRef1('!@#'), false);
      expect(ValidationService.isValidRef1(''), false);
    });

    test('isValidBillerCode validates alphanumeric', () {
      expect(ValidationService.isValidBillerCode('12345'), true);
      expect(ValidationService.isValidBillerCode('ABCD'), true);
      expect(ValidationService.isValidBillerCode('JOMPAY'), true);
      expect(ValidationService.isValidBillerCode('??'), false);
    });
  });

  testWidgets('BillPaymentForm validation works', (tester) async {
    bool submitted = false;

    await tester.pumpWidget(MaterialApp(
      home: Scaffold(
        body: BillPaymentForm(onSubmit: (b, r, a) => submitted = true),
      ),
    ));

    // Fill Ref-1 with invalid data to trigger error messages
    await tester.enterText(find.byType(TextFormField).at(0), '123'); // Too short
    await tester.enterText(find.byType(TextFormField).at(1), '0'); // Too small

    await tester.tap(find.text('PROCEED'));
    await tester.pump();

    expect(find.text('Please select a biller'), findsOneWidget);
    expect(find.text('Must be at least 5 characters'), findsOneWidget);
    expect(find.text('Amount must be at least 0.01'), findsOneWidget);
    expect(submitted, false);

    // Select Biller from Dropdown
    await tester.tap(find.text('Select Biller'));
    await tester.pumpAndSettle();
    await tester.tap(find.text('JomPAY (JOMPAY)').last);
    await tester.pumpAndSettle();

    // Fill other fields
    await tester.enterText(find.byType(TextFormField).at(0), 'REF123');
    await tester.enterText(find.byType(TextFormField).at(1), '50.0');

    await tester.tap(find.text('PROCEED'));
    await tester.pump();

    expect(submitted, true);
  });
  testWidgets('BillPaymentForm validation shows length errors', (tester) async {
    await tester.pumpWidget(MaterialApp(
      home: Scaffold(
        body: BillPaymentForm(onSubmit: (b, r, a) {}),
      ),
    ));

    // Fill Ref-1 with > 20 chars
    await tester.enterText(find.byType(TextFormField).at(0), 'A' * 21);
    await tester.tap(find.text('PROCEED'));
    await tester.pump();

    expect(find.text('Cannot exceed 20 characters'), findsOneWidget);
  });
}
