import 'package:flutter_test/flutter_test.dart';

/// Usage: an MTI 0400 Reversal is queued in the encrypted offline store
import '../../bdd_test_helper.dart';
import 'package:agentbanking_channel/core/offline/offline_queue_service.dart';

Future<void> anMti0400ReversalIsQueuedInTheEncryptedOfflineStore(
    WidgetTester tester) async {
  final queue = bddContainer.read(offlineQueueServiceProvider) as MockOfflineQueueService;
  await queue.enqueue({'mti': '0400'}, 'REV_123');
}
