import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:agentbanking_channel/core/offline/widgets/offline_indicator.dart';
import 'package:agentbanking_channel/core/offline/offline_queue_service.dart';

void main() {
  testWidgets('OfflineIndicator is hidden when count is 0', (WidgetTester tester) async {
    await tester.pumpWidget(
      ProviderScope(
        overrides: [
          pendingQueueCountProvider.overrideWith((ref) => Stream.value(0)),
        ],
        child: const MaterialApp(
          home: Scaffold(
            body: OfflineIndicator(),
          ),
        ),
      ),
    );

    await tester.pump();
    expect(find.byType(OfflineIndicator), findsOneWidget);
    expect(find.byType(Container), findsNothing); // It returns SizedBox.shrink()
  });

  testWidgets('OfflineIndicator shows "Pending: X" when count > 0', (WidgetTester tester) async {
    await tester.pumpWidget(
      ProviderScope(
        overrides: [
          pendingQueueCountProvider.overrideWith((ref) => Stream.value(5)),
        ],
        child: const MaterialApp(
          home: Scaffold(
            body: OfflineIndicator(),
          ),
        ),
      ),
    );

    await tester.pump();
    expect(find.text('OFFLINE MODE'), findsOneWidget);
    expect(find.text('Pending: 5'), findsOneWidget);
    expect(find.byIcon(Icons.cloud_off), findsOneWidget);
  });
}
