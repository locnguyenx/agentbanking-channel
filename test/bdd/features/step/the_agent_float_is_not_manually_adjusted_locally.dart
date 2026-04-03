import 'package:flutter_test/flutter_test.dart';

/// Usage: the Agent Float is NOT manually adjusted locally
import '../../bdd_test_helper.dart';
import 'package:agentbanking_channel/features/settlement/providers/float_provider.dart';
import 'package:decimal/decimal.dart';

Future<void> theAgentFloatIsNotManuallyAdjustedLocally(
    WidgetTester tester) async {
  final floatState = bddContainer.read(floatProvider);
  expect(floatState.currentBalance, Decimal.fromInt(5000));
}
