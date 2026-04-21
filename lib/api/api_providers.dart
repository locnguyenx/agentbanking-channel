import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:agent_api/agent_api.dart';
import 'package:agentbanking_channel/core/network/dio_provider.dart';

final ledgerApiProvider = Provider<LedgerControllerLedgerServiceApi>((ref) {
  final dio = ref.watch(dioProvider);
  return LedgerControllerLedgerServiceApi(dio, standardSerializers);
});

final merchantApiProvider = Provider<MerchantControllerLedgerServiceApi>((ref) {
  final dio = ref.watch(dioProvider);
  return MerchantControllerLedgerServiceApi(dio, standardSerializers);
});

final billerApiProvider = Provider<BillerControllerBillerServiceApi>((ref) {
  final dio = ref.watch(dioProvider);
  return BillerControllerBillerServiceApi(dio, standardSerializers);
});

final switchApiProvider = Provider<SwitchControllerBillerServiceApi>((ref) {
  final dio = ref.watch(dioProvider);
  return SwitchControllerBillerServiceApi(dio, standardSerializers);
});

final onboardingApiProvider = Provider<OnboardingControllerOnboardingServiceApi>((ref) {
  final dio = ref.watch(dioProvider);
  return OnboardingControllerOnboardingServiceApi(dio, standardSerializers);
});

final agentApiProvider = Provider<AgentControllerOnboardingServiceApi>((ref) {
  final dio = ref.watch(dioProvider);
  return AgentControllerOnboardingServiceApi(dio, standardSerializers);
});

final esspApiProvider = Provider<EsspControllerBillerServiceApi>((ref) {
  final dio = ref.watch(dioProvider);
  return EsspControllerBillerServiceApi(dio, standardSerializers);
});

final ewalletApiProvider = Provider<EWalletControllerBillerServiceApi>((ref) {
  final dio = ref.watch(dioProvider);
  return EWalletControllerBillerServiceApi(dio, standardSerializers);
});

final transactionApiProvider = Provider<TransactionControllerRulesServiceApi>((ref) {
  final dio = ref.watch(dioProvider);
  return TransactionControllerRulesServiceApi(dio, standardSerializers);
});

final complianceApiProvider = Provider<ComplianceControllerOnboardingServiceApi>((ref) {
  final dio = ref.watch(dioProvider);
  return ComplianceControllerOnboardingServiceApi(dio, standardSerializers);
});

final orchestratorApiProvider = Provider<OrchestratorControllerOrchestratorServiceApi>((ref) {
  final dio = ref.watch(dioProvider);
  return OrchestratorControllerOrchestratorServiceApi(dio, standardSerializers);
});

final agentOnboardingApiProvider = Provider<AgentOnboardingControllerOnboardingServiceApi>((ref) {
  final dio = ref.watch(dioProvider);
  return AgentOnboardingControllerOnboardingServiceApi(dio, standardSerializers);
});
