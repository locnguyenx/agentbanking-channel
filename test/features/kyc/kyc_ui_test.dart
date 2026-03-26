import 'package:flutter_test/flutter_test.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import '../../lib/features/kyc/screens/kyc_flow_screen.dart';

void main() {
  testWidgets('renders start scan button in idle state', (tester) async {
    await tester.pumpWidget(
      const ProviderScope(
        child: MaterialApp(home: KycFlowScreen()),
      ),
    );

    expect(find.text('Start MyKad Scan'), findsOneWidget);
  });
}
