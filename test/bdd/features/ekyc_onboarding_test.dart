// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: type=lint, type=warning

import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';

import './step/the_agent_is_logged_in_with_an_active_session.dart';
import './step/an_unregistered_customer_wants_to_open_an_account.dart';
import './step/the_agent_inserts_the_mykad_into_the_smart_card_reader.dart';
import './step/the_ocrchip_read_extracts_name_ic_number_and_address.dart';
import './step/the_mykad_data_is_extracted_successfully.dart';
import './step/the_customer_presses_their_thumb_on_the_biometric_peripheral.dart';
import './step/a_verified_match_status_is_returned_from_the_hardware.dart';
import './step/the_app_proceeds_to_send_the_payload_to_apiv1kycverify.dart';
import './step/the_match_on_card_thumbprint_check_returns_no_match_or_failed.dart';
import './step/the_app_transitions_state.dart';
import './step/the_pos_frontal_camera_activates_immediately.dart';
import './step/prompts_the_customer_please_blink_twice_for_video_liveness_capture.dart';
import './step/the_liveness_video_blob_is_captured.dart';
import './step/the_app_triggers_post_apiv1kycverify_with_gps_coordinates.dart';
import './step/the_backend_routes_the_media_to_the_configured_kyc_provider_innov8tifjumio.dart';
import './step/concurrently_runs_an_aml_sanctions_check.dart';
import './step/the_kyc_payload_returns_status_auto_approved.dart';
import './step/the_app_handles_the_http200_ok_response.dart';
import './step/it_bypasses_the_main_menu_and_forces_an_initial_cash_deposit_collection_flow.dart';
import './step/provisions_the_core_savings_account_within_the_same_session.dart';
import './step/the_kyc_payload_returns_status_manual_review.dart';
import './step/the_app_stops_the_onboarding_workflow.dart';
import './step/informs_the_customer_application_queued_for_analyst_review_you_will_be_notified_via_sms.dart';

void main() {
  group('''e_KYC Verification and Face AI''', () {
    Future<void> bddSetUp(WidgetTester tester) async {
      await theAgentIsLoggedInWithAnActiveSession(tester);
    }

    testWidgets('''Scan MyKad OCR/Chip''', (tester) async {
      await bddSetUp(tester);
      await anUnregisteredCustomerWantsToOpenAnAccount(tester);
      await theAgentInsertsTheMykadIntoTheSmartCardReader(tester);
      await theOcrchipReadExtractsNameIcNumberAndAddress(tester);
    }, tags: ['US_CA_12', 'FR_CA_5_1', 'MVP']);
    testWidgets('''Happy Path — Biometric Match_on_Card succeeds''',
        (tester) async {
      await bddSetUp(tester);
      await anUnregisteredCustomerWantsToOpenAnAccount(tester);
      await theMykadDataIsExtractedSuccessfully(tester);
      await theCustomerPressesTheirThumbOnTheBiometricPeripheral(tester);
      await aVerifiedMatchStatusIsReturnedFromTheHardware(tester);
      await theAppProceedsToSendThePayloadToApiv1kycverify(tester);
    }, tags: ['US_CA_12', 'FR_CA_5_2', 'MVP']);
    testWidgets('''Failed thumbprint triggers Face AI Liveness Fallback''',
        (tester) async {
      await bddSetUp(tester);
      await anUnregisteredCustomerWantsToOpenAnAccount(tester);
      await theMatchOnCardThumbprintCheckReturnsNoMatchOrFailed(tester);
      await theAppTransitionsState(tester);
      await thePosFrontalCameraActivatesImmediately(tester);
      await promptsTheCustomerPleaseBlinkTwiceForVideoLivenessCapture(tester);
    }, tags: ['US_CA_13', 'FR_CA_5_3', 'MVP']);
    testWidgets('''Payload dispatched to KYC endpoint for 3rd-party & AML''',
        (tester) async {
      await bddSetUp(tester);
      await anUnregisteredCustomerWantsToOpenAnAccount(tester);
      await theLivenessVideoBlobIsCaptured(tester);
      await theAppTriggersPostApiv1kycverifyWithGpsCoordinates(tester);
      await theBackendRoutesTheMediaToTheConfiguredKycProviderInnov8tifjumio(
          tester);
      await concurrentlyRunsAnAmlSanctionsCheck(tester);
    }, tags: ['US_CA_13', 'FR_CA_5_4', 'MVP']);
    testWidgets(
        '''AUTO_APPROVED routes directly to initial deposit collection''',
        (tester) async {
      await bddSetUp(tester);
      await anUnregisteredCustomerWantsToOpenAnAccount(tester);
      await theKycPayloadReturnsStatusAutoApproved(tester);
      await theAppHandlesTheHttp200OkResponse(tester);
      await itBypassesTheMainMenuAndForcesAnInitialCashDepositCollectionFlow(
          tester);
      await provisionsTheCoreSavingsAccountWithinTheSameSession(tester);
    }, tags: ['US_CA_14', 'FR_CA_5_5', 'MVP']);
    testWidgets('''MANUAL_REVIEW stops workflow and notifies customer''',
        (tester) async {
      await bddSetUp(tester);
      await anUnregisteredCustomerWantsToOpenAnAccount(tester);
      await theKycPayloadReturnsStatusManualReview(tester);
      await theAppStopsTheOnboardingWorkflow(tester);
      await informsTheCustomerApplicationQueuedForAnalystReviewYouWillBeNotifiedViaSms(
          tester);
    }, tags: ['US_CA_14', 'FR_CA_5_6', 'MVP']);
  });
}
