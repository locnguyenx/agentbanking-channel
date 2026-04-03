import 'package:flutter_test/flutter_test.dart';


Future<void> paynetNotifiesTheBackend(WidgetTester tester) async {
  // In our fake repo, the next poll will return SUCCESS.
  // The polling loop has a 5s delay.
  await tester.pump(const Duration(seconds: 6));
}
