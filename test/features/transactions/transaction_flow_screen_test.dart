import 'package:flutter_test/flutter_test.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import '../../lib/features/transactions/screens/transaction_flow_screen.dart';

void main() {
  testWidgets('renders start button in idle state', (tester) async {
    await tester.pumpWidget(
      const ProviderScope(
        child: MaterialApp(home: TransactionFlowScreen()),
      ),
    );

    expect(find.text('Start Cash Withdrawal (RM 100)'), findsOneWidget);
  });
}
