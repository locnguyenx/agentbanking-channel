import 'package:flutter_test/flutter_test.dart';

/// Usage: uses the original X-Idempotency-Key to prevent duplicate reversals
import 'package:agentbanking_channel/core/offline/offline_queue_service.dart';
import '../../bdd_test_helper.dart';

Future<void> usesTheOriginalXidempotencykeyToPreventDuplicateReversals(
    WidgetTester tester) async {
  final queue = bddContainer.read(offlineQueueServiceProvider) as MockOfflineQueueService;
  final pending = await queue.getPending();
  final hasRevKey = pending.any((item) => (item['key'] as String).startsWith('REV_'));
  expect(hasRevKey, isTrue);
}
