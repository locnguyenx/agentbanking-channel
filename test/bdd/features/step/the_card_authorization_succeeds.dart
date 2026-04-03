import 'package:flutter_test/flutter_test.dart';

/// Usage: the card authorization succeeds
import 'package:agentbanking_channel/features/merchant/providers/merchant_provider.dart';
import '../../bdd_test_helper.dart';

Future<void> theCardAuthorizationSucceeds(WidgetTester tester) async {
  final notifier = bddContainer.read(merchantProvider.notifier);
  // Do NOT await here, it blocks the FakeAsync clock.
  notifier.processCardSale();
  
  // Iterative pump to allow multiple internal awaits to settle
  for (int i = 0; i < 10; i++) {
    await tester.pump(const Duration(milliseconds: 10));
  }
}
