import 'package:flutter/material.dart';
import 'package:agentbanking_channel/features/transactions/screens/bill_payment_base_screen.dart';

class EsspScreen extends StatelessWidget {
  const EsspScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return const BillPaymentBaseScreen(
      title: 'eSSP Purchase',
      serviceCode: 'ESSP_PURCHASE',
      fixedBillerCode: 'ESSP',
      metadataLabel: 'SSPN-i Account Number',
      metadataKey: 'accountNo',
    );
  }
}
