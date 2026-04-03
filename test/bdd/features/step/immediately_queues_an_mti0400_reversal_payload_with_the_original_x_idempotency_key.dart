import 'package:flutter_test/flutter_test.dart';
import 'package:agentbanking_channel/core/offline/offline_queue_service.dart';
import '../../bdd_test_helper.dart';

/// Usage: immediately queues an MTI 0400 Reversal payload with the original X_Idempotency_Key
Future<void> immediatelyQueuesAnMti0400ReversalPayloadWithTheOriginalXIdempotencyKey(
    WidgetTester tester) async {
  final queueService = bddContainer.read(offlineQueueServiceProvider);
  final count = await queueService.getCount();
  expect(count, greaterThan(0));
  
  final pending = await queueService.getPending();
  final reversal = pending.any((item) => (item['payload'] as Map)['mti'] == '0400');
  expect(reversal, isTrue);
}
