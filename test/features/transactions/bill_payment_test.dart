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

    test('isValidBillerCode validates digits only', () {
      expect(ValidationService.isValidBillerCode('12345'), true);
      expect(ValidationService.isValidBillerCode('ABCD'), false);
    });
  });

  testWidgets('BillPaymentForm validation works', (tester) async {
    bool submitted = false;

    await tester.pumpWidget(MaterialApp(
      home: Scaffold(
        body: BillPaymentForm(onSubmit: (b, r, a) => submitted = true),
      ),
    ));

    await tester.tap(find.text('PROCEED'));
    await tester.pump();

    expect(find.text('Invalid Biller Code'), findsOneWidget);
    expect(find.text('Invalid Ref-1'), findsOneWidget);
    expect(find.text('Invalid Amount'), findsOneWidget);
    expect(submitted, false);

    await tester.enterText(find.byType(TextFormField).at(0), '12345');
    await tester.enterText(find.byType(TextFormField).at(1), 'REF123');
    await tester.enterText(find.byType(TextFormField).at(2), '50.0');

    await tester.tap(find.text('PROCEED'));
    await tester.pump();

    expect(submitted, true);
  });
}
