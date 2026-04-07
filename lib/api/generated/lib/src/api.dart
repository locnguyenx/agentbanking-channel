//
// AUTO-GENERATED FILE, DO NOT MODIFY!
//

import 'package:dio/dio.dart';
import 'package:built_value/serializer.dart';
import 'package:agent_api/src/serializers.dart';
import 'package:agent_api/src/auth/api_key_auth.dart';
import 'package:agent_api/src/auth/basic_auth.dart';
import 'package:agent_api/src/auth/bearer_auth.dart';
import 'package:agent_api/src/auth/oauth.dart';
import 'package:agent_api/src/api/agent_controller_onboarding_service_api.dart';
import 'package:agent_api/src/api/audit_log_controller_onboarding_service_api.dart';
import 'package:agent_api/src/api/auth_controller_auth_iam_service_api.dart';
import 'package:agent_api/src/api/biller_controller_biller_service_api.dart';
import 'package:agent_api/src/api/compliance_controller_rules_service_api.dart';
import 'package:agent_api/src/api/e_wallet_controller_biller_service_api.dart';
import 'package:agent_api/src/api/essp_controller_biller_service_api.dart';
import 'package:agent_api/src/api/ledger_controller_ledger_service_api.dart';
import 'package:agent_api/src/api/merchant_controller_ledger_service_api.dart';
import 'package:agent_api/src/api/onboarding_controller_onboarding_service_api.dart';
import 'package:agent_api/src/api/orchestrator_controller_orchestrator_service_api.dart';
import 'package:agent_api/src/api/reconciliation_controller_ledger_service_api.dart';
import 'package:agent_api/src/api/resolution_controller_orchestrator_service_api.dart';
import 'package:agent_api/src/api/rules_controller_rules_service_api.dart';
import 'package:agent_api/src/api/switch_controller_switch_adapter_service_api.dart';
import 'package:agent_api/src/api/transaction_controller_switch_adapter_service_api.dart';
import 'package:agent_api/src/api/user_management_controller_auth_iam_service_api.dart';

class AgentApi {
  static const String basePath = r'http://localhost:8080';

  final Dio dio;
  final Serializers serializers;

  AgentApi({
    Dio? dio,
    Serializers? serializers,
    String? basePathOverride,
    List<Interceptor>? interceptors,
  })  : this.serializers = serializers ?? standardSerializers,
        this.dio = dio ??
            Dio(BaseOptions(
              baseUrl: basePathOverride ?? basePath,
              connectTimeout: const Duration(milliseconds: 5000),
              receiveTimeout: const Duration(milliseconds: 3000),
            )) {
    if (interceptors == null) {
      this.dio.interceptors.addAll([
        OAuthInterceptor(),
        BasicAuthInterceptor(),
        BearerAuthInterceptor(),
        ApiKeyAuthInterceptor(),
      ]);
    } else {
      this.dio.interceptors.addAll(interceptors);
    }
  }

  void setOAuthToken(String name, String token) {
    if (this.dio.interceptors.any((i) => i is OAuthInterceptor)) {
      (this.dio.interceptors.firstWhere((i) => i is OAuthInterceptor) as OAuthInterceptor).tokens[name] = token;
    }
  }

  void setBearerAuth(String name, String token) {
    if (this.dio.interceptors.any((i) => i is BearerAuthInterceptor)) {
      (this.dio.interceptors.firstWhere((i) => i is BearerAuthInterceptor) as BearerAuthInterceptor).tokens[name] = token;
    }
  }

  void setBasicAuth(String name, String username, String password) {
    if (this.dio.interceptors.any((i) => i is BasicAuthInterceptor)) {
      (this.dio.interceptors.firstWhere((i) => i is BasicAuthInterceptor) as BasicAuthInterceptor).authInfo[name] = BasicAuthInfo(username, password);
    }
  }

  void setApiKey(String name, String apiKey) {
    if (this.dio.interceptors.any((i) => i is ApiKeyAuthInterceptor)) {
      (this.dio.interceptors.firstWhere((element) => element is ApiKeyAuthInterceptor) as ApiKeyAuthInterceptor).apiKeys[name] = apiKey;
    }
  }

  /// Get AgentControllerOnboardingServiceApi instance, base route and serializer can be overridden by a given but be careful,
  /// by doing that all interceptors will not be executed
  AgentControllerOnboardingServiceApi getAgentControllerOnboardingServiceApi() {
    return AgentControllerOnboardingServiceApi(dio, serializers);
  }

  /// Get AuditLogControllerOnboardingServiceApi instance, base route and serializer can be overridden by a given but be careful,
  /// by doing that all interceptors will not be executed
  AuditLogControllerOnboardingServiceApi getAuditLogControllerOnboardingServiceApi() {
    return AuditLogControllerOnboardingServiceApi(dio, serializers);
  }

  /// Get AuthControllerAuthIamServiceApi instance, base route and serializer can be overridden by a given but be careful,
  /// by doing that all interceptors will not be executed
  AuthControllerAuthIamServiceApi getAuthControllerAuthIamServiceApi() {
    return AuthControllerAuthIamServiceApi(dio, serializers);
  }

  /// Get BillerControllerBillerServiceApi instance, base route and serializer can be overridden by a given but be careful,
  /// by doing that all interceptors will not be executed
  BillerControllerBillerServiceApi getBillerControllerBillerServiceApi() {
    return BillerControllerBillerServiceApi(dio, serializers);
  }

  /// Get ComplianceControllerRulesServiceApi instance, base route and serializer can be overridden by a given but be careful,
  /// by doing that all interceptors will not be executed
  ComplianceControllerRulesServiceApi getComplianceControllerRulesServiceApi() {
    return ComplianceControllerRulesServiceApi(dio, serializers);
  }

  /// Get EWalletControllerBillerServiceApi instance, base route and serializer can be overridden by a given but be careful,
  /// by doing that all interceptors will not be executed
  EWalletControllerBillerServiceApi getEWalletControllerBillerServiceApi() {
    return EWalletControllerBillerServiceApi(dio, serializers);
  }

  /// Get EsspControllerBillerServiceApi instance, base route and serializer can be overridden by a given but be careful,
  /// by doing that all interceptors will not be executed
  EsspControllerBillerServiceApi getEsspControllerBillerServiceApi() {
    return EsspControllerBillerServiceApi(dio, serializers);
  }

  /// Get LedgerControllerLedgerServiceApi instance, base route and serializer can be overridden by a given but be careful,
  /// by doing that all interceptors will not be executed
  LedgerControllerLedgerServiceApi getLedgerControllerLedgerServiceApi() {
    return LedgerControllerLedgerServiceApi(dio, serializers);
  }

  /// Get MerchantControllerLedgerServiceApi instance, base route and serializer can be overridden by a given but be careful,
  /// by doing that all interceptors will not be executed
  MerchantControllerLedgerServiceApi getMerchantControllerLedgerServiceApi() {
    return MerchantControllerLedgerServiceApi(dio, serializers);
  }

  /// Get OnboardingControllerOnboardingServiceApi instance, base route and serializer can be overridden by a given but be careful,
  /// by doing that all interceptors will not be executed
  OnboardingControllerOnboardingServiceApi getOnboardingControllerOnboardingServiceApi() {
    return OnboardingControllerOnboardingServiceApi(dio, serializers);
  }

  /// Get OrchestratorControllerOrchestratorServiceApi instance, base route and serializer can be overridden by a given but be careful,
  /// by doing that all interceptors will not be executed
  OrchestratorControllerOrchestratorServiceApi getOrchestratorControllerOrchestratorServiceApi() {
    return OrchestratorControllerOrchestratorServiceApi(dio, serializers);
  }

  /// Get ReconciliationControllerLedgerServiceApi instance, base route and serializer can be overridden by a given but be careful,
  /// by doing that all interceptors will not be executed
  ReconciliationControllerLedgerServiceApi getReconciliationControllerLedgerServiceApi() {
    return ReconciliationControllerLedgerServiceApi(dio, serializers);
  }

  /// Get ResolutionControllerOrchestratorServiceApi instance, base route and serializer can be overridden by a given but be careful,
  /// by doing that all interceptors will not be executed
  ResolutionControllerOrchestratorServiceApi getResolutionControllerOrchestratorServiceApi() {
    return ResolutionControllerOrchestratorServiceApi(dio, serializers);
  }

  /// Get RulesControllerRulesServiceApi instance, base route and serializer can be overridden by a given but be careful,
  /// by doing that all interceptors will not be executed
  RulesControllerRulesServiceApi getRulesControllerRulesServiceApi() {
    return RulesControllerRulesServiceApi(dio, serializers);
  }

  /// Get SwitchControllerSwitchAdapterServiceApi instance, base route and serializer can be overridden by a given but be careful,
  /// by doing that all interceptors will not be executed
  SwitchControllerSwitchAdapterServiceApi getSwitchControllerSwitchAdapterServiceApi() {
    return SwitchControllerSwitchAdapterServiceApi(dio, serializers);
  }

  /// Get TransactionControllerSwitchAdapterServiceApi instance, base route and serializer can be overridden by a given but be careful,
  /// by doing that all interceptors will not be executed
  TransactionControllerSwitchAdapterServiceApi getTransactionControllerSwitchAdapterServiceApi() {
    return TransactionControllerSwitchAdapterServiceApi(dio, serializers);
  }

  /// Get UserManagementControllerAuthIamServiceApi instance, base route and serializer can be overridden by a given but be careful,
  /// by doing that all interceptors will not be executed
  UserManagementControllerAuthIamServiceApi getUserManagementControllerAuthIamServiceApi() {
    return UserManagementControllerAuthIamServiceApi(dio, serializers);
  }
}
