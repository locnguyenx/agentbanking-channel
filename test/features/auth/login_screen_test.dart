import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:agentbanking_channel/features/auth/login_screen.dart';

void main() {
  testWidgets('renders login screen with Agent ID and Password fields', (WidgetTester tester) async {
    await tester.pumpWidget(
      const ProviderScope(
        child: MaterialApp(home: LoginScreen()),
      ),
    );

    // Verify UI components
    expect(find.text('AGENT BANKING'), findsOneWidget);
    expect(find.text('Agent ID'), findsOneWidget);
    expect(find.text('Password'), findsOneWidget);
    expect(find.text('LOGIN'), findsOneWidget);
    expect(find.text('Login via Biometric'), findsOneWidget);
  });
}
