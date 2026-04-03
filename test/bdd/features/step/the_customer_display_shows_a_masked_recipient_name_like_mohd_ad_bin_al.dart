import 'package:flutter_test/flutter_test.dart';

/// Usage: the customer display shows a masked recipient name like "MOHD A***D BIN AL*"
Future<void> theCustomerDisplayShowsAMaskedRecipientNameLikeMohdAdBinAl(
    WidgetTester tester) async {
  // In mocks, ProxyEnquiry returns the masked name
  expect(find.textContaining('MOHD A***D BIN AL*'), findsOneWidget);
}
