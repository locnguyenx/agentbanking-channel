import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:agentbanking_channel/features/transactions/screens/jompay_form.dart';
import 'package:agent_api/agent_api.dart';

void main() {
  testWidgets('JomPayForm shows validation errors', (tester) async {
    await tester.pumpWidget(MaterialApp(
      home: Scaffold(
        body: JomPayForm(onSubmit: (req) {}),
      ),
    ));

    // Fill invalid data to trigger error messages
    await tester.enterText(find.widgetWithText(TextFormField, 'Biller Code'), '123'); // Invalid
    await tester.enterText(find.widgetWithText(TextFormField, 'Ref-1'), '123'); // Too short
    await tester.enterText(find.widgetWithText(TextFormField, 'Amount'), '0'); // Too small

    await tester.tap(find.text('PROCEED'));
    await tester.pump();

    expect(find.text('Invalid format'), findsOneWidget);
    expect(find.text('Must be at least 10 characters'), findsOneWidget);
    expect(find.text('Amount must be at least 0.01'), findsOneWidget);
  });

  testWidgets('JomPayForm submits successfully', (tester) async {
    JomPayExternalRequest? submittedReq;

    await tester.pumpWidget(MaterialApp(
      home: Scaffold(
        body: JomPayForm(onSubmit: (req) => submittedReq = req),
      ),
    ));

    await tester.enterText(find.widgetWithText(TextFormField, 'Biller Code'), '5454');
    await tester.enterText(find.widgetWithText(TextFormField, 'Ref-1'), '1234567890');
    await tester.enterText(find.widgetWithText(TextFormField, 'Amount'), '100.0');

    await tester.tap(find.text('PROCEED'));
    await tester.pump();

    expect(submittedReq, isNotNull);
    expect(submittedReq!.billerCode, '5454');
    expect(submittedReq!.ref1, '1234567890');
    expect(submittedReq!.amount, '100.0');
  });
}
