// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: type=lint, type=warning

import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';

import './step/the_channel_app_is_launched_on_a_whitelisted_device.dart';
import './step/the_agent_authenticates_using_fingerprint_biometrics.dart';
import './step/a_jwt_session_is_created_and_stored_securely.dart';
import './step/the_agent_is_navigated_to_the_home_screen.dart';
import './step/the_ui_displays_the_agents_pre_funded_float_ledger_balance.dart';
import './step/the_agents_device_mac_address_is_not_whitelisted_in_the_backend.dart';
import './step/the_agent_attempts_to_log_in.dart';
import './step/the_login_is_rejected_with_error_code_err_auth_device_not_whitelisted.dart';
import './step/the_session_is_not_created.dart';
import './step/the_agent_is_logged_in_with_an_active_session.dart';
import './step/two_hours_of_inactivity_has_elapsed.dart';
import './step/the_app_shows_a_non_blocking_session_expired_dialog.dart';
import './step/allows_the_agent_to_re_authenticate_without_losing_transaction_context.dart';
import './step/the_agent_is_in_the_middle_of_a_pricing_quote_workflow.dart';
import './step/the_system_detects_an_expired_jwt_token.dart';
import './step/the_app_shows_a_non_blocking_session_expired_please_re_authenticate_overlay.dart';
import './step/resumes_the_transaction_flow_after_successful_re_authentication.dart';
import './step/the_agent_logs_out.dart';
import './step/the_jwt_token_is_deleted_from_secure_storage.dart';
import './step/all_session_state_is_cleared.dart';
import './step/the_app_returns_to_the_login_screen.dart';

void main() {
  group('''Agent Authentication and Session''', () {
    testWidgets('''Agent logs in with valid biometric''', (tester) async {
      await theChannelAppIsLaunchedOnAWhitelistedDevice(tester);
      await theAgentAuthenticatesUsingFingerprintBiometrics(tester);
      await aJwtSessionIsCreatedAndStoredSecurely(tester);
      await theAgentIsNavigatedToTheHomeScreen(tester);
      await theUiDisplaysTheAgentsPreFundedFloatLedgerBalance(tester);
    }, tags: ['US_CA_01', 'FR_CA_1_1', 'MVP']);
    testWidgets('''Device not whitelisted is rejected on login''',
        (tester) async {
      await theAgentsDeviceMacAddressIsNotWhitelistedInTheBackend(tester);
      await theAgentAttemptsToLogIn(tester);
      await theLoginIsRejectedWithErrorCodeErrAuthDeviceNotWhitelisted(tester);
      await theSessionIsNotCreated(tester);
    }, tags: ['US_CA_01', 'FR_CA_1_1', 'MVP']);
    testWidgets('''Session expires during idle — non_blocking re_auth''',
        (tester) async {
      await theAgentIsLoggedInWithAnActiveSession(tester);
      await twoHoursOfInactivityHasElapsed(tester);
      await theAppShowsANonBlockingSessionExpiredDialog(tester);
      await allowsTheAgentToReAuthenticateWithoutLosingTransactionContext(
          tester);
    }, tags: ['US_CA_01', 'FR_CA_1_3', 'MVP']);
    testWidgets('''Session expires mid-transaction''', (tester) async {
      await theAgentIsInTheMiddleOfAPricingQuoteWorkflow(tester);
      await theSystemDetectsAnExpiredJwtToken(tester);
      await theAppShowsANonBlockingSessionExpiredPleaseReAuthenticateOverlay(
          tester);
      await resumesTheTransactionFlowAfterSuccessfulReAuthentication(tester);
    }, tags: ['US_CA_01', 'FR_CA_1_3', 'MVP']);
    testWidgets('''Secure logout clears all sensitive data''', (tester) async {
      await theAgentIsLoggedInWithAnActiveSession(tester);
      await theAgentLogsOut(tester);
      await theJwtTokenIsDeletedFromSecureStorage(tester);
      await allSessionStateIsCleared(tester);
      await theAppReturnsToTheLoginScreen(tester);
    }, tags: ['US_CA_01', 'FR_CA_1_3', 'MVP']);
  });
}
