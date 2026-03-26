import 'package:flutter_test/flutter_test.dart';
import 'package:flutter/material.dart';
import '../../lib/features/auth/login_screen.dart';

void main() {
  testWidgets('renders login screen with CTA button', (tester) async {
    await tester.pumpWidget(const MaterialApp(home: LoginScreen()));
    expect(find.byType(ElevatedButton), findsOneWidget);
    expect(find.text('Login via Biometric'), findsOneWidget);
  });
}
