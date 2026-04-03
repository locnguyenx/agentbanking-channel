import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'bdd/bdd_test_helper.dart';

void main() {
  testWidgets('Debug Widget Tree', (tester) async {
    await pumpBddApp(tester, isAuthenticated: true);
    await tester.pumpAndSettle();
    
    debugPrint('=== WIDGET TREE ===');
    // Using a more structured output
    for (var element in tester.allElements) {
      if (element.widget is InkWell) {
        final inkWell = element.widget as InkWell;
        if (inkWell.key != null) {
          debugPrint('InkWell Key: ${inkWell.key}');
        }
      }
    }
    
    final jompayButtons = find.byKey(const Key('btn_jompay'));
    debugPrint('Found ${jompayButtons.evaluate().length} btn_jompay widgets');
    
    for (final element in jompayButtons.evaluate()) {
      debugPrint('Element: $element');
      // Find parent context to see where it is
      debugPrint('Depth: ${element.depth}');
    }
    
    expect(jompayButtons, findsOneWidget);
  });
}
