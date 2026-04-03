// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: type=lint, type=warning

import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';

import './step/the_agent_is_logged_in_with_an_active_session.dart';
import './step/the_customer_agreed_to_the_principal_fee_amount_on_their_display.dart';
import './step/the_customer_inserts_their_emv_card_into_the_hardware_reader.dart';
import './step/enters_their_pin_on_the_hardware_pin_pad.dart';
import './step/the_pos_hardware_encrypts_the_pin_block_via_dukpt_immediately.dart';
import './step/the_app_fires_post_apiv1withdrawal.dart';
import './step/the_agent_never_sees_or_has_access_to_the_customers_pin.dart';
import './step/the_transaction_is_a_cash_deposit_and_the_destination_is_verified_via_proxyenquiry.dart';
import './step/the_app_prompts_the_agent_for_physical_confirmation.dart';
import './step/the_ui_requires_the_agent_to_click_confirm_cash_received.dart';
import './step/upon_clicking_the_backend_is_notified_to_credit_the_destination_account.dart';
import './step/the_customer_receives_an_sms_receipt_from_the_backend_notification_gateway.dart';
import './step/the_customer_deposits_physical_cash_of_rm3500.dart';
import './step/the_transaction_amount_exceeds_the_rm3000_stp_threshold.dart';
import './step/the_app_forces_a_mykad_biometric_scan_to_unmask_customer_identity_for_aml.dart';
import './step/the_customers_funding_source_is_duitnow.dart';
import './step/the_customer_provides_a_mobile_number_as_their_duitnow_proxy.dart';
import './step/the_agent_submits_the_transfer_request.dart';
import './step/the_backend_fires_a_push_notification_to_the_customers_mobile_banking_app.dart';
import './step/the_terminal_enters_waiting_for_customer_approval_polling_state.dart';
import './step/the_customer_approves_on_their_smartphone.dart';
import './step/the_terminal_receives_confirmation_and_completes_the_transaction.dart';
import './step/the_customer_provides_a_mykad_number_as_their_duitnow_proxy.dart';
import './step/the_backend_resolves_the_proxy_to_the_registered_account.dart';
import './step/the_push_notification_is_fired_to_the_customers_mobile_banking_app.dart';
import './step/the_customer_provides_a_brn_as_their_duitnow_proxy.dart';
import './step/the_backend_resolves_the_brn_proxy_to_the_registered_business_account.dart';
import './step/the_push_notification_is_fired_to_the_account_holders_mobile_banking_app.dart';

void main() {
  group('''Dual_Handshake Payment Execution''', () {
    Future<void> bddSetUp(WidgetTester tester) async {
      await theAgentIsLoggedInWithAnActiveSession(tester);
    }

    testWidgets('''Cash_Out using ATM Card (EMV chip)''', (tester) async {
      await bddSetUp(tester);
      await theCustomerAgreedToThePrincipalFeeAmountOnTheirDisplay(tester);
      await theCustomerInsertsTheirEmvCardIntoTheHardwareReader(tester);
      await entersTheirPinOnTheHardwarePinPad(tester);
      await thePosHardwareEncryptsThePinBlockViaDukptImmediately(tester);
      await theAppFiresPostApiv1withdrawal(tester);
      await theAgentNeverSeesOrHasAccessToTheCustomersPin(tester);
    }, tags: ['US_CA_03', 'FR_CA_3_1', 'MVP']);
    testWidgets('''Cash Deposit via Agent Validation (Physical Cash)''',
        (tester) async {
      await bddSetUp(tester);
      await theTransactionIsACashDepositAndTheDestinationIsVerifiedViaProxyenquiry(
          tester);
      await theAppPromptsTheAgentForPhysicalConfirmation(tester);
      await theUiRequiresTheAgentToClickConfirmCashReceived(tester);
      await uponClickingTheBackendIsNotifiedToCreditTheDestinationAccount(
          tester);
      await theCustomerReceivesAnSmsReceiptFromTheBackendNotificationGateway(
          tester);
    }, tags: ['US_CA_04', 'FR_CA_3_2', 'MVP']);
    testWidgets('''Cash Deposit > RM 3,000 requires MyKad biometric scan''',
        (tester) async {
      await bddSetUp(tester);
      await theCustomerDepositsPhysicalCashOfRm3500(tester);
      await theTransactionAmountExceedsTheRm3000StpThreshold(tester);
      await theAppForcesAMykadBiometricScanToUnmaskCustomerIdentityForAml(
          tester);
    }, tags: ['US_CA_04', 'FR_CA_3_2', 'MVP']);
    testWidgets('''DuitNow transfer using Mobile Number proxy''',
        (tester) async {
      await bddSetUp(tester);
      await theCustomersFundingSourceIsDuitnow(tester);
      await theCustomerProvidesAMobileNumberAsTheirDuitnowProxy(tester);
      await theAgentSubmitsTheTransferRequest(tester);
      await theBackendFiresAPushNotificationToTheCustomersMobileBankingApp(
          tester);
      await theTerminalEntersWaitingForCustomerApprovalPollingState(tester);
      await theCustomerApprovesOnTheirSmartphone(tester);
      await theTerminalReceivesConfirmationAndCompletesTheTransaction(tester);
    }, tags: ['US_CA_05', 'FR_CA_3_3', 'FR_CA_3_4', 'Phase2']);
    testWidgets('''DuitNow transfer using MyKad Number proxy''',
        (tester) async {
      await bddSetUp(tester);
      await theCustomersFundingSourceIsDuitnow(tester);
      await theCustomerProvidesAMykadNumberAsTheirDuitnowProxy(tester);
      await theAgentSubmitsTheTransferRequest(tester);
      await theBackendResolvesTheProxyToTheRegisteredAccount(tester);
      await thePushNotificationIsFiredToTheCustomersMobileBankingApp(tester);
      await theTerminalEntersWaitingForCustomerApprovalPollingState(tester);
      await theCustomerApprovesOnTheirSmartphone(tester);
      await theTerminalReceivesConfirmationAndCompletesTheTransaction(tester);
    }, tags: ['US_CA_05', 'FR_CA_3_3', 'FR_CA_3_4', 'Phase2']);
    testWidgets(
        '''DuitNow transfer using Business Registration Number (BRN) proxy''',
        (tester) async {
      await bddSetUp(tester);
      await theCustomersFundingSourceIsDuitnow(tester);
      await theCustomerProvidesABrnAsTheirDuitnowProxy(tester);
      await theAgentSubmitsTheTransferRequest(tester);
      await theBackendResolvesTheBrnProxyToTheRegisteredBusinessAccount(tester);
      await thePushNotificationIsFiredToTheAccountHoldersMobileBankingApp(
          tester);
      await theTerminalEntersWaitingForCustomerApprovalPollingState(tester);
      await theCustomerApprovesOnTheirSmartphone(tester);
      await theTerminalReceivesConfirmationAndCompletesTheTransaction(tester);
    }, tags: ['US_CA_05', 'FR_CA_3_3', 'FR_CA_3_4', 'Phase2']);
  });
}
