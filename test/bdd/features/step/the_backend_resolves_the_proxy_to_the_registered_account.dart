import 'package:flutter_test/flutter_test.dart';
import '../../bdd_test_helper.dart';

Future<void> theBackendResolvesTheProxyToTheRegisteredAccount(WidgetTester tester) async {
  // Mock the proxy enquiry result in the repository
  mockTransactionRepository.performProxyEnquiryStub = (proxyId, proxyType) async {
    return 'MOHD A***D BIN AL*';
  };
  await tester.pump();
}
