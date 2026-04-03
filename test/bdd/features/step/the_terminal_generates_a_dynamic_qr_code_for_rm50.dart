import 'package:flutter_test/flutter_test.dart';

/// Usage: the terminal generates a Dynamic QR Code for RM 50
import 'package:agentbanking_channel/features/merchant/providers/merchant_provider.dart';
import 'package:agentbanking_channel/features/transactions/models/transaction_models.dart';
import 'package:decimal/decimal.dart';
import '../../bdd_test_helper.dart';

Future<void> theTerminalGeneratesADynamicQrCodeForRm50(WidgetTester tester) async {
  final notifier = bddContainer.read(merchantProvider.notifier);
  // Note: we don't await because it starts polling
  notifier.startRetailSale(Decimal.fromInt(50), FundingSource.DUITNOW_QR);
  await tester.pump();
  
  final state = bddContainer.read(merchantProvider);
  expect(state.status, MerchantStatus.displayingQr);
}
