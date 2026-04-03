import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:dio/dio.dart';
import '../../bdd_test_helper.dart';

/// Usage: the backend does not respond within the timeout threshold (25 seconds)
Future<void> theBackendDoesNotRespondWithinTheTimeoutThreshold25Seconds(
    WidgetTester tester) async {
  // Set the stub to throw a timeout exception
  mockTransactionRepository.executeTransactionStub = (req, agentId, {idempotencyKey}) async {
    throw DioException(
      requestOptions: RequestOptions(path: '/execute'),
      type: DioExceptionType.connectionTimeout,
    );
  };

  // Trigger the actual request
  await tester.tap(find.byKey(const Key('btn_confirm')));
  await tester.pump();
  
  // Advance the fake clock by 30s to trigger the internal timeout logic
  await tester.pump(const Duration(seconds: 30));
  
  // Extra pumps to settle the reversal logic
  for (int i = 0; i < 5; i++) {
    await tester.pump();
  }
}
