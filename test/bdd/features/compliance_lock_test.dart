// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: type=lint, type=warning

import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';

import './step/the_agent_is_logged_in_with_an_active_session.dart';
import './step/an_agent_initiates_their10th_cash_deposit_of_rm2900_within_an_hour.dart';
import './step/the_backend_velocity_engine_detects_deliberate_structuring_smurfing.dart';
import './step/the_api_rejects_the_request_with_error_err_biz_compliance_freeze.dart';
import './step/the_app_enters_a_local_locked_state_immediately.dart';
import './step/all_financial_services_are_disabled_and_grayed_out.dart';
import './step/a_red_banner_reading_compliance_review_dial1800xxxxxxx_for_support_is_permanently_displayed.dart';
import './step/the_terminal_is_in_the_locked_compliance_state.dart';
import './step/the_agent_closes_and_re_opens_the_app.dart';
import './step/the_locked_state_is_restored_from_encrypted_local_storage.dart';
import './step/financial_services_remain_disabled.dart';
import './step/the_backend_sends_a_compliance_unlock_webhook_to_the_app.dart';
import './step/the_app_clears_the_locked_flag_from_encrypted_local_storage.dart';
import './step/financial_services_are_re_enabled_automatically.dart';
import './step/the_agent_sees_terminal_unlocked_you_may_resume_operations.dart';
import './step/no_manual_app_restart_is_required.dart';

void main() {
  group('''Anti_Smurfing Category 3 Fallbacks''', () {
    Future<void> bddSetUp(WidgetTester tester) async {
      await theAgentIsLoggedInWithAnActiveSession(tester);
    }

    testWidgets('''Velocity breach immediately locks terminal''',
        (tester) async {
      await bddSetUp(tester);
      await anAgentInitiatesTheir10thCashDepositOfRm2900WithinAnHour(tester);
      await theBackendVelocityEngineDetectsDeliberateStructuringSmurfing(
          tester);
      await theApiRejectsTheRequestWithErrorErrBizComplianceFreeze(tester);
      await theAppEntersALocalLockedStateImmediately(tester);
      await allFinancialServicesAreDisabledAndGrayedOut(tester);
      await aRedBannerReadingComplianceReviewDial1800xxxxxxxForSupportIsPermanentlyDisplayed(
          tester);
    }, tags: ['US_CA_16', 'FR_CA_6_1', 'FR_CA_6_2', 'Phase2']);
    testWidgets('''LOCKED state persists across app restarts''',
        (tester) async {
      await bddSetUp(tester);
      await theTerminalIsInTheLockedComplianceState(tester);
      await theAgentClosesAndReOpensTheApp(tester);
      await theLockedStateIsRestoredFromEncryptedLocalStorage(tester);
      await financialServicesRemainDisabled(tester);
    }, tags: ['US_CA_16', 'FR_CA_6_2', 'FR_CA_6_3', 'Phase2']);
    testWidgets('''Compliance unlock webhook restores STP operations''',
        (tester) async {
      await bddSetUp(tester);
      await theTerminalIsInTheLockedComplianceState(tester);
      await theBackendSendsAComplianceUnlockWebhookToTheApp(tester);
      await theAppClearsTheLockedFlagFromEncryptedLocalStorage(tester);
      await financialServicesAreReEnabledAutomatically(tester);
      await theAgentSeesTerminalUnlockedYouMayResumeOperations(tester);
      await noManualAppRestartIsRequired(tester);
    }, tags: ['US_CA_21', 'FR_CA_6_4', 'Phase2']);
  });
}
