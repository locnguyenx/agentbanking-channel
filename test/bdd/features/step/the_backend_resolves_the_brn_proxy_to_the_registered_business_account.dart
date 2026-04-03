import 'package:flutter_test/flutter_test.dart';
import '../../bdd_test_helper.dart';

Future<void> theBackendResolvesTheBrnProxyToTheRegisteredBusinessAccount(WidgetTester tester) async {
  // Mock the proxy enquiry result in the repository for BRN
  mockTransactionRepository.performProxyEnquiryStub = (proxyId, proxyType) async {
    return 'TECH S***N BHD';
  };
  await tester.pump();
}
