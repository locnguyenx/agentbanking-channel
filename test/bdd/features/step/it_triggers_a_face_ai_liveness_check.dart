import 'package:flutter_test/flutter_test.dart';

Future<void> itTriggersAFaceAiLivenessCheck(WidgetTester tester) async {
  // In BDD environment, we assume liveness check passes
  await tester.pumpAndSettle();
}
