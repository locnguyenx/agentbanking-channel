import 'package:flutter_test/flutter_test.dart';

/// Usage: the backend velocity engine detects deliberate structuring (smurfing)
import 'package:agentbanking_channel/features/transactions/providers/transaction_provider.dart';
import 'package:agentbanking_channel/features/compliance/providers/compliance_provider.dart';
import '../../bdd_test_helper.dart';

Future<void> theBackendVelocityEngineDetectsDeliberateStructuringSmurfing(WidgetTester tester) async {
  final compliance = bddContainer.read(complianceProvider.notifier);
  
  // We simulate the backend error by manually freezing
  compliance.freeze('ERR_BIZ_COMPLIANCE_FREEZE');
}
