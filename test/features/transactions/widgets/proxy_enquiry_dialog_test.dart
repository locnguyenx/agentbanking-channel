import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:agentbanking_channel/features/transactions/widgets/proxy_enquiry_dialog.dart';

void main() {
  testWidgets('ProxyEnquiryDialog displays masked name', (tester) async {
    bool confirmed = false;
    bool cancelled = false;

    await tester.pumpWidget(MaterialApp(
      home: ProxyEnquiryDialog(
        maskedName: 'MOHD A***D BIN AL*',
        onConfirm: () => confirmed = true,
        onCancel: () => cancelled = true,
      ),
    ));

    expect(find.text('MOHD A***D BIN AL*'), findsOneWidget);
    expect(find.text('Verify Recipient'), findsOneWidget);

    await tester.tap(find.text('CONFIRM'));
    expect(confirmed, true);

    await tester.tap(find.text('CANCEL'));
    expect(cancelled, true);
  });
}
