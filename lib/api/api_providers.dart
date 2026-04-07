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

final switchApiProvider = Provider<SwitchControllerSwitchAdapterServiceApi>((ref) {
  final dio = ref.watch(dioProvider);
  return SwitchControllerSwitchAdapterServiceApi(dio, standardSerializers);
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

final transactionApiProvider = Provider<TransactionControllerSwitchAdapterServiceApi>((ref) {
  final dio = ref.watch(dioProvider);
  return TransactionControllerSwitchAdapterServiceApi(dio, standardSerializers);
});

final complianceApiProvider = Provider<ComplianceControllerRulesServiceApi>((ref) {
  final dio = ref.watch(dioProvider);
  return ComplianceControllerRulesServiceApi(dio, standardSerializers);
});

final orchestratorApiProvider = Provider<OrchestratorControllerOrchestratorServiceApi>((ref) {
  final dio = ref.watch(dioProvider);
  return OrchestratorControllerOrchestratorServiceApi(dio, standardSerializers);
});
