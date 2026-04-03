import 'package:flutter_test/flutter_test.dart';

/// Usage: the customer_facing display prominently shows:
Future<void> theCustomerFacingDisplayProminentlyShows(WidgetTester tester, [String? text]) async {
  // We simulate customer display check by searching for text in the main app
  await tester.pumpAndSettle();
  if (text == null) return;
  // Split text by newlines or multiple spaces and check each part
  final parts = text.split(RegExp(r'\n|\s{2,}')).map((p) => p.trim()).where((p) => p.isNotEmpty).toList();
  for (final part in parts) {
    expect(find.textContaining(part), findsWidgets, reason: 'Could not find text part: "$part"');
  }
}
