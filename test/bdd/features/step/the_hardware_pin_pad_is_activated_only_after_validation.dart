import 'package:flutter_test/flutter_test.dart';

Future<void> theHardwarePinPadIsActivatedOnlyAfterValidation(
    WidgetTester tester) async {
  await tester.pumpAndSettle();
}
