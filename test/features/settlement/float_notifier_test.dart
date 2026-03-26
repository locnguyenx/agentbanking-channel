import 'package:flutter_test/flutter_test.dart';
import 'package:agentbanking_channel/features/settlement/providers/float_provider.dart';
import 'package:agentbanking_channel/features/settlement/models/float_models.dart';

void main() {
  late FloatNotifier notifier;

  setUp(() {
    notifier = FloatNotifier(); // Starts with 5000.0 from mock default
  });

  group('FloatNotifier', () {
    test('initial balance is correct', () {
      expect(notifier.state.currentBalance, 5000.0);
    });

    test('creditFloat increases balance and adds entry', () {
      notifier.creditFloat(500.0, 'TX123');
      expect(notifier.state.currentBalance, 5500.0);
      expect(notifier.state.entries.length, 1);
      expect(notifier.state.entries.first.type, FloatEntryType.CREDIT);
    });

    test('debitFloat decreases balance and adds entry', () {
      notifier.debitFloat(200.0, 'TX456');
      expect(notifier.state.currentBalance, 4800.0);
      expect(notifier.state.entries.length, 1);
      expect(notifier.state.entries.first.type, FloatEntryType.DEBIT);
    });
  });
}
