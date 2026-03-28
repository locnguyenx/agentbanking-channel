import 'package:flutter/material.dart';
import 'package:agentbanking_channel/features/transactions/screens/bill_payment_base_screen.dart';

class BillPaymentCardScreen extends StatelessWidget {
  const BillPaymentCardScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return const BillPaymentBaseScreen(
      title: 'Bill Payment',
      serviceCode: 'BILL_PAYMENT',
      metadataLabel: 'Reference Number (Ref-1)',
      metadataKey: 'ref1',
    );
  }
}
