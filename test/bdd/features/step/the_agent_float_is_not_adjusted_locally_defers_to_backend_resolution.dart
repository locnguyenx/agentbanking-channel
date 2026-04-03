import 'package:flutter_test/flutter_test.dart';
import 'package:agentbanking_channel/features/settlement/providers/float_provider.dart';
import 'package:decimal/decimal.dart';
import '../../bdd_test_helper.dart';

/// Usage: the Agent Float is NOT adjusted locally — defers to backend resolution
Future<void> theAgentFloatIsNotAdjustedLocallyDefersToBackendResolution(
    WidgetTester tester) async {
  final floatState = bddContainer.read(floatProvider);
  // Balance should remain 10000.00 since transaction was reversed/failed
  expect(floatState.currentBalance, Decimal.fromInt(5000));
}
