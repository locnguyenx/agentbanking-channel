import 'package:flutter/material.dart';
import 'package:agentbanking_channel/features/transactions/screens/bill_payment_base_screen.dart';

class MyKadWithdrawalScreen extends StatelessWidget {
  const MyKadWithdrawalScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return const BillPaymentBaseScreen(
      title: 'MyKad Biometric Withdrawal',
      serviceCode: 'CASH_WITHDRAWAL',
      metadataLabel: 'NRIC Number (MyKad)',
      metadataKey: 'nric',
      metadataRegex: r'^\d{6}-\d{2}-\d{4}$',
    );
  }
}
// Note: In a full implementation, we would force FundingSource.MYKAD_BIOMETRIC here.
// For this Phase 2 task, it uses the base screen with metadata.
