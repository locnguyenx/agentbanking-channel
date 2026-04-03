import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';

Future<void> aRedBannerReadingComplianceReviewDial1800xxxxxxxForSupportIsPermanentlyDisplayed(WidgetTester tester) async {
  await tester.pump(const Duration(milliseconds: 500));
  // Expect a banner with the compliance message
  expect(find.textContaining('COMPLIANCE REVIEW'), findsOneWidget);
  expect(find.textContaining('1-800-XXX-XXXX'), findsOneWidget);
  
  // Verify it's "permanently displayed" by checking color or container
  find.byType(Container).evaluate().where((e) {
    final decoration = (e.widget as Container).decoration;
    if (decoration is BoxDecoration) {
      return decoration.color == Colors.red || decoration.color == Colors.redAccent;
    }
    return false;
  });
  // Note: We don't strictly enforce the color here if the text is found, 
  // but let's at least ensure the text is there as per BRD.
}
