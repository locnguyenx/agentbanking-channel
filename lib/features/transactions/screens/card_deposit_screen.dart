import 'package:flutter/material.dart';
import 'package:agentbanking_channel/features/transactions/screens/bill_payment_base_screen.dart';

class CardDepositScreen extends StatelessWidget {
  const CardDepositScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return const BillPaymentBaseScreen(
      title: 'Card-Funded Deposit',
      serviceCode: 'CASH_DEPOSIT',
      metadataLabel: 'Account Number',
      metadataKey: 'accountNo',
    );
  }
}
