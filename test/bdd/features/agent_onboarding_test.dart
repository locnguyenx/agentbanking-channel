// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: type=lint, type=warning

import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';

import './step/a_prospective_micro_agent_opens_the_self_onboarding_flow_on_the_pos.dart';
import './step/the_applicant_completes_mykad_ocr_scan_liveness_video_and_enters_their_ssm_number.dart';
import './step/the_backend_fires_concurrent_checks_jpn_identity_pass_ssm_active_pass_aml_clean.dart';
import './step/the_app_shows_agent_id_activated_float_account_created.dart';
import './step/no_bank_officer_is_required_at_any_step.dart';
import './step/a_prospective_micro_agent_completes_the_onboarding_form.dart';
import './step/the_backend_aml_check_returns_a_potential_flag.dart';
import './step/the_app_shows_application_queued_for_review_a_bank_officer_will_contact_you_shortly.dart';
import './step/the_pos_returns_to_the_idle_screen.dart';

void main() {
  group('''Micro_Agent STP Self_Onboarding''', () {
    testWidgets('''Micro_Agent STP self_onboarding — all checks pass''',
        (tester) async {
      await aProspectiveMicroAgentOpensTheSelfOnboardingFlowOnThePos(tester);
      await theApplicantCompletesMykadOcrScanLivenessVideoAndEntersTheirSsmNumber(
          tester);
      await theBackendFiresConcurrentChecksJpnIdentityPassSsmActivePassAmlClean(
          tester);
      await theAppShowsAgentIdActivatedFloatAccountCreated(tester);
      await noBankOfficerIsRequiredAtAnyStep(tester);
    }, tags: ['US_CA_20', 'FR_CA_10_1', 'FR_CA_10_2', 'FR_CA_10_3', 'Phase2']);
    testWidgets(
        '''Micro_Agent self_onboarding — AML flag routes to manual review''',
        (tester) async {
      await aProspectiveMicroAgentCompletesTheOnboardingForm(tester);
      await theBackendAmlCheckReturnsAPotentialFlag(tester);
      await theAppShowsApplicationQueuedForReviewABankOfficerWillContactYouShortly(
          tester);
      await thePosReturnsToTheIdleScreen(tester);
    }, tags: ['US_CA_20', 'FR_CA_10_4', 'Phase2']);
  });
}
