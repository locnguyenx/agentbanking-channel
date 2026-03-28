import 'package:flutter/material.dart';
import 'package:agentbanking_channel/features/transactions/screens/bill_payment_base_screen.dart';

class TopupCardScreen extends StatelessWidget {
  const TopupCardScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return const BillPaymentBaseScreen(
      title: 'Prepaid Top-up',
      serviceCode: 'TOPUP',
      metadataLabel: 'Customer Mobile No',
      metadataKey: 'mobileNo',
      metadataRegex: r'^01\d{8,9}$',
    );
  }
}
