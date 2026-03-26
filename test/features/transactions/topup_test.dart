import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:agentbanking_channel/features/transactions/services/validation_service.dart';
import 'package:agentbanking_channel/features/transactions/screens/topup_form.dart';

void main() {
  group('ValidationService - Phone', () {
    test('isValidPhoneNumber validates Malaysian format', () {
      expect(ValidationService.isValidPhoneNumber('012-3456789'), true);
      expect(ValidationService.isValidPhoneNumber('01912345678'), true);
      expect(ValidationService.isValidPhoneNumber('12345'), false);
      expect(ValidationService.isValidPhoneNumber(''), false);
    });
  });

  testWidgets('TopUpForm validation works', (tester) async {
    bool submitted = false;

    await tester.pumpWidget(MaterialApp(
      home: Scaffold(
        body: TopUpForm(onSubmit: (t, p, a) => submitted = true),
      ),
    ));

    await tester.tap(find.text('PROCEED'));
    await tester.pump();

    expect(find.text('Please select a Telco'), findsOneWidget);
    expect(find.text('Invalid Phone Number'), findsOneWidget);
    expect(find.text('Invalid Amount'), findsOneWidget);
    expect(submitted, false);

    // Select Telco
    await tester.tap(find.byType(DropdownButtonFormField<String>));
    await tester.pumpAndSettle();
    await tester.tap(find.text('CELCOM').last);
    await tester.pumpAndSettle();

    await tester.enterText(find.byType(TextFormField).at(0), '012-3456789');
    await tester.enterText(find.byType(TextFormField).at(1), '10.0');

    await tester.tap(find.text('PROCEED'));
    await tester.pump();

    expect(submitted, true);
  });
}
