import 'package:flutter/material.dart';
import 'package:agentbanking_channel/features/transactions/screens/bill_payment_base_screen.dart';

class SarawakPayScreen extends StatelessWidget {
  const SarawakPayScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return const BillPaymentBaseScreen(
      title: 'Sarawak Pay',
      serviceCode: 'EWALLET_TOPUP',
      fixedBillerCode: 'SARAWAK_PAY',
      metadataLabel: 'Wallet ID / Phone No',
      metadataKey: 'walletId',
    );
  }
}
