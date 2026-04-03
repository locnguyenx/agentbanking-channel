import 'package:flutter_test/flutter_test.dart';
import 'package:agentbanking_channel/core/offline/offline_queue_service.dart';
import '../../bdd_test_helper.dart';

/// Usage: the app queues an MTI 0400 Reversal Payload in the encrypted SQLite queue
Future<void> theAppQueuesAnMti0400ReversalPayloadInTheEncryptedSqliteQueue(
    WidgetTester tester) async {
  final queueService = bddContainer.read(offlineQueueServiceProvider);
  final count = await queueService.getCount();
  expect(count, greaterThan(0));
  
  final pending = await queueService.getPending();
  final reversal = pending.any((item) => (item['payload'] as Map)['mti'] == '0400');
  expect(reversal, isTrue);
}
