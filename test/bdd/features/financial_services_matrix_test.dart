// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: type=lint, type=warning

import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';

import './step/the_agent_is_logged_in_with_an_active_session.dart';
import './step/the_customer_inserts_their_emv_card.dart';
import './step/enters_their_pin_on_the_hardware_pin_pad.dart';
import './step/the_agent_selects_balance_inquiry_and_the_app_calls_post_apiv1balanceinquiry.dart';
import './step/the_customer_balance_is_shown_on_the_customerfacing_display_masked_rm.dart';
import './step/no_funds_are_deducted.dart';
import './step/a_receipt_is_printed_on_request.dart';
import './step/the_customer_does_not_have_their_atm_card.dart';
import './step/the_customer_places_their_mykad_in_the_reader_and_presses_thumb_on_biometric_scanner.dart';
import './step/the_matchoncard_returns_match.dart';
import './step/the_app_fires_post_apiv1withdrawal_with_fundingsourcemykad_biometric.dart';
import './step/the_agent_hands_over_the_requested_cash_amount.dart';
import './step/the_agent_runs_proxyenquiry_and_shows_masked_destination_name_to_customer.dart';
import './step/the_customer_confirms_the_destination_is_correct.dart';
import './step/the_customer_inserts_their_atm_card_and_enters_their_pin_on_the_hardware_pin_pad.dart';
import './step/the_app_fires_post_apiv1deposit_with_fundingsourcecard_emv.dart';
import './step/the_destination_account_is_credited.dart';
import './step/the_agent_receives_an_sms_confirmation.dart';
import './step/the_agent_selects_jompay_and_enters_the_biller_code_and_customer_ref1.dart';
import './step/the_biller_inquiry_returns_billerroutingoff_us_and_validationstatusvalid.dart';
import './step/the_agent_accepts_cash_from_the_customer_and_clicks_confirm_cash_collected.dart';
import './step/the_app_fires_post_apiv1billpay_with_fundingsourcecash_billerroutingoff_us.dart';
import './step/a_jompay_payment_receipt_is_printed.dart';
import './step/the_agent_validates_ref1_and_biller_inquiry_returns_billerroutingoff_us.dart';
import './step/the_app_fires_post_apiv1billpay_with_fundingsourcecard_emv_billerroutingoff_us.dart';
import './step/the_biller_inquiry_returns_billerroutingon_us.dart';
import './step/the_agent_accepts_cash_and_clicks_confirm_cash_collected.dart';
import './step/the_app_fires_the_payment_to_the_onus_internal_endpoint_skipping_paynet_switch.dart';
import './step/settlement_is_faster_than_offus_routing.dart';
import './step/a_biller_receipt_is_printed.dart';
import './step/the_customer_inserts_atm_card_and_enters_their_pin_on_the_hardware_pin_pad.dart';
import './step/the_app_fires_the_payment_to_the_onus_internal_endpoint.dart';
import './step/the_agent_enters_the_customers_astro_rpn_account_number.dart';
import './step/the_biller_inquiry_confirms_the_account_and_outstanding_amount.dart';
import './step/the_app_fires_post_apiv1billpay_billercodeastro_fundingsourcecash.dart';
import './step/a_biller_receipt_with_astro_acknowledgment_number_is_issued.dart';
import './step/the_agent_enters_the_astro_rpn_account_and_biller_inquiry_passes.dart';
import './step/the_app_fires_post_apiv1billpay_billercodeastro_fundingsourcecard_emv.dart';
import './step/a_biller_receipt_is_issued.dart';
import './step/the_agent_enters_the_customers_tm_account_number_ref1.dart';
import './step/the_biller_inquiry_confirms_validity.dart';
import './step/the_app_fires_post_apiv1billpay_billercodetm_fundingsourcecash.dart';
import './step/a_biller_receipt_with_tm_acknowledgment_reference_is_issued.dart';
import './step/the_tm_biller_inquiry_passes.dart';
import './step/the_app_fires_post_apiv1billpay_billercodetm_fundingsourcecard_emv.dart';
import './step/the_agent_selects_epf_and_the_customer_chooses_contribution_type_isaraanisuri.dart';
import './step/the_epf_account_reference_is_validated.dart';
import './step/the_app_fires_post_apiv1billpay_billercodeepf_fundingsourcecash.dart';
import './step/an_epf_contribution_receipt_is_printed.dart';
import './step/the_app_fires_post_apiv1billpay_billercodeepf_fundingsourcecard_emv.dart';
import './step/an_epf_receipt_is_printed.dart';
import './step/the_agent_enters_the_customers_celcom_phone_number_and_it_is_validated.dart';
import './step/the_app_fires_post_apiv1topup_telcocelcom_fundingsourcecard_emv.dart';
import './step/the_topup_is_applied_instantly_to_the_phone_number.dart';
import './step/a_topup_receipt_is_printed.dart';
import './step/the_agent_enters_the_customers_m1_phone_number_and_it_is_validated.dart';
import './step/the_app_fires_post_apiv1topup_telcom1_fundingsourcecash.dart';
import './step/the_topup_is_applied_to_the_m1_number.dart';
import './step/the_m1_phone_number_is_validated.dart';
import './step/the_app_fires_post_apiv1topup_telcom1_fundingsourcecard_emv.dart';
import './step/the_customer_provides_their_sarawak_pay_account_identifier.dart';
import './step/the_ewallet_account_is_validated_and_has_sufficient_balance.dart';
import './step/the_customer_confirms_the_withdrawal_amount_onscreen.dart';
import './step/the_app_fires_post_apiv1ewalletwithdraw_walletsarawak_pay_fundingsourcecash.dart';
import './step/the_agent_hands_over_physical_cash_from_their_float.dart';
import './step/the_agents_float_increases_bank_credits_agent_for_cash_disbursed.dart';
import './step/the_app_fires_post_apiv1ewalletwithdraw_walletsarawak_pay_fundingsourcecard_emv.dart';
import './step/the_agent_hands_over_physical_cash.dart';
import './step/the_app_fires_post_apiv1ewallettopup_walletsarawak_pay_fundingsourcecash.dart';
import './step/the_agents_float_decreases_agent_is_now_holding_banks_money.dart';
import './step/the_customers_sarawak_pay_ewallet_is_credited.dart';
import './step/the_app_fires_post_apiv1ewallettopup_walletsarawak_pay_fundingsourcecard_emv.dart';
import './step/the_agent_selects_essp_and_enters_the_customers_nric_and_essp_certificate_type.dart';
import './step/the_customer_pays_physical_cash_to_the_agent.dart';
import './step/the_agent_clicks_confirm_cash_collected.dart';
import './step/the_app_fires_post_apiv1essppurchase_fundingsourcecash.dart';
import './step/a_printed_essp_certificate_slip_is_issued_to_the_customer.dart';
import './step/the_agents_float_decreases.dart';
import './step/the_essp_certificate_type_and_nric_are_entered_and_validated.dart';
import './step/the_app_fires_post_apiv1essppurchase_fundingsourcecard_emv.dart';
import './step/a_printed_essp_certificate_slip_is_issued.dart';
import './step/the_agent_selects_pin_purchase_and_chooses_the_voucher_type_eg_digi_rm10.dart';
import './step/the_app_fires_post_apiv1retailpinpurchase_with_fundingsourcecard_emv.dart';
import './step/the_agents_float_decreases_by_rm10.dart';
import './step/the_terminal_prints_a_slip_with_the16digit_pin_code.dart';
import './step/the_agent_earns_a_commission_on_the_sale.dart';
import './step/any_cardfunded_service_bill_topup_essp_sarawak_pay_pin_voucher.dart';
import './step/the_servicespecific_validation_ref1_or_phone_check_has_passed.dart';
import './step/the_hardware_pin_pad_is_activated_only_after_validation.dart';
import './step/the_app_sends_the_encrypted_pin_block_via_dukpt_in_the_api_request_body.dart';
import './step/the_agent_never_has_access_to_the_raw_pin.dart';
import './step/any_cashfunded_service_where_the_agent_collects_rm3000_in_cash.dart';
import './step/the_app_interrupts_and_requires_a_mykad_scan_to_record_the_customers_identity_for_aml.dart';
import './step/only_then_submits_the_api_call_with_the_mykad_reference_number.dart';

void main() {
  group('''All 31 Financial Services by Funding Method''', () {
    Future<void> bddSetUp(WidgetTester tester) async {
      await theAgentIsLoggedInWithAnActiveSession(tester);
    }

    testWidgets('''Balance Inquiry using ATM Card''', (tester) async {
      await bddSetUp(tester);
      await theCustomerInsertsTheirEmvCard(tester);
      await entersTheirPinOnTheHardwarePinPad(tester);
      await theAgentSelectsBalanceInquiryAndTheAppCallsPostApiv1balanceinquiry(
          tester);
      await theCustomerBalanceIsShownOnTheCustomerfacingDisplayMaskedRm(tester);
      await noFundsAreDeducted(tester);
      await aReceiptIsPrintedOnRequest(tester);
    }, tags: ['US_CA_23', 'FR_CA_3_1', 'FR_CA_4_5', 'MVP']);
    testWidgets('''Cash Withdrawal using MyKad biometric (no ATM card)''',
        (tester) async {
      await bddSetUp(tester);
      await theCustomerDoesNotHaveTheirAtmCard(tester);
      await theCustomerPlacesTheirMykadInTheReaderAndPressesThumbOnBiometricScanner(
          tester);
      await theMatchoncardReturnsMatch(tester);
      await theAppFiresPostApiv1withdrawalWithFundingsourcemykadBiometric(
          tester);
      await theAgentHandsOverTheRequestedCashAmount(tester);
    }, tags: ['US_CA_24', 'FR_CA_5_2', 'FR_CA_4_5', 'Phase2']);
    testWidgets('''Cash Deposit funded by ATM Card''', (tester) async {
      await bddSetUp(tester);
      await theAgentRunsProxyenquiryAndShowsMaskedDestinationNameToCustomer(
          tester);
      await theCustomerConfirmsTheDestinationIsCorrect(tester);
      await theCustomerInsertsTheirAtmCardAndEntersTheirPinOnTheHardwarePinPad(
          tester);
      await theAppFiresPostApiv1depositWithFundingsourcecardEmv(tester);
      await theDestinationAccountIsCredited(tester);
      await theAgentReceivesAnSmsConfirmation(tester);
    }, tags: ['US_CA_25', 'FR_CA_3_1', 'FR_CA_4_3', 'FR_CA_4_7', 'Phase2']);
    testWidgets('''JomPAY OFF-US bill payment — cash funding''',
        (tester) async {
      await bddSetUp(tester);
      await theAgentSelectsJompayAndEntersTheBillerCodeAndCustomerRef1(tester);
      await theBillerInquiryReturnsBillerroutingoffUsAndValidationstatusvalid(
          tester);
      await theAgentAcceptsCashFromTheCustomerAndClicksConfirmCashCollected(
          tester);
      await theAppFiresPostApiv1billpayWithFundingsourcecashBillerroutingoffUs(
          tester);
      await aJompayPaymentReceiptIsPrinted(tester);
    }, tags: ['US_CA_07', 'FR_CA_4_1', 'FR_CA_4_8', 'Phase2']);
    testWidgets('''JomPAY OFF-US bill payment — card funding''',
        (tester) async {
      await bddSetUp(tester);
      await theAgentValidatesRef1AndBillerInquiryReturnsBillerroutingoffUs(
          tester);
      await theCustomerInsertsTheirAtmCardAndEntersTheirPinOnTheHardwarePinPad(
          tester);
      await theAppFiresPostApiv1billpayWithFundingsourcecardEmvBillerroutingoffUs(
          tester);
      await aJompayPaymentReceiptIsPrinted(tester);
    }, tags: ['US_CA_26', 'FR_CA_4_1', 'FR_CA_4_7', 'Phase2']);
    testWidgets(
        '''JomPAY ON-US bill payment — cash funding (internal routing)''',
        (tester) async {
      await bddSetUp(tester);
      await theBillerInquiryReturnsBillerroutingonUs(tester);
      await theAgentAcceptsCashAndClicksConfirmCashCollected(tester);
      await theAppFiresThePaymentToTheOnusInternalEndpointSkippingPaynetSwitch(
          tester);
      await settlementIsFasterThanOffusRouting(tester);
      await aBillerReceiptIsPrinted(tester);
    }, tags: ['US_CA_27', 'FR_CA_4_1', 'FR_CA_4_8', 'FR_CA_4_9', 'Phase2']);
    testWidgets(
        '''JomPAY ON-US bill payment — card funding (internal routing)''',
        (tester) async {
      await bddSetUp(tester);
      await theBillerInquiryReturnsBillerroutingonUs(tester);
      await theCustomerInsertsAtmCardAndEntersTheirPinOnTheHardwarePinPad(
          tester);
      await theAppFiresThePaymentToTheOnusInternalEndpoint(tester);
      await aBillerReceiptIsPrinted(tester);
    }, tags: ['US_CA_28', 'FR_CA_4_1', 'FR_CA_4_7', 'FR_CA_4_9', 'Phase2']);
    testWidgets('''ASTRO RPN bill payment — cash funding''', (tester) async {
      await bddSetUp(tester);
      await theAgentEntersTheCustomersAstroRpnAccountNumber(tester);
      await theBillerInquiryConfirmsTheAccountAndOutstandingAmount(tester);
      await theAgentAcceptsCashAndClicksConfirmCashCollected(tester);
      await theAppFiresPostApiv1billpayBillercodeastroFundingsourcecash(tester);
      await aBillerReceiptWithAstroAcknowledgmentNumberIsIssued(tester);
    }, tags: ['US_CA_29', 'FR_CA_4_1', 'FR_CA_4_8', 'Phase2']);
    testWidgets('''ASTRO RPN bill payment — card funding''', (tester) async {
      await bddSetUp(tester);
      await theAgentEntersTheAstroRpnAccountAndBillerInquiryPasses(tester);
      await theCustomerInsertsTheirAtmCardAndEntersTheirPinOnTheHardwarePinPad(
          tester);
      await theAppFiresPostApiv1billpayBillercodeastroFundingsourcecardEmv(
          tester);
      await aBillerReceiptIsIssued(tester);
    }, tags: ['US_CA_30', 'FR_CA_4_1', 'FR_CA_4_7', 'Phase2']);
    testWidgets('''TM Unifi bill payment — cash funding''', (tester) async {
      await bddSetUp(tester);
      await theAgentEntersTheCustomersTmAccountNumberRef1(tester);
      await theBillerInquiryConfirmsValidity(tester);
      await theAgentAcceptsCashAndClicksConfirmCashCollected(tester);
      await theAppFiresPostApiv1billpayBillercodetmFundingsourcecash(tester);
      await aBillerReceiptWithTmAcknowledgmentReferenceIsIssued(tester);
    }, tags: ['US_CA_31', 'FR_CA_4_1', 'FR_CA_4_8', 'Phase2']);
    testWidgets('''TM Unifi bill payment — card funding''', (tester) async {
      await bddSetUp(tester);
      await theTmBillerInquiryPasses(tester);
      await theCustomerInsertsTheirAtmCardAndEntersTheirPinOnTheHardwarePinPad(
          tester);
      await theAppFiresPostApiv1billpayBillercodetmFundingsourcecardEmv(tester);
      await aBillerReceiptIsIssued(tester);
    }, tags: ['US_CA_32', 'FR_CA_4_1', 'FR_CA_4_7', 'Phase2']);
    testWidgets('''EPF i-SARAAN contribution — cash funding''', (tester) async {
      await bddSetUp(tester);
      await theAgentSelectsEpfAndTheCustomerChoosesContributionTypeIsaraanisuri(
          tester);
      await theEpfAccountReferenceIsValidated(tester);
      await theAgentAcceptsCashAndClicksConfirmCashCollected(tester);
      await theAppFiresPostApiv1billpayBillercodeepfFundingsourcecash(tester);
      await anEpfContributionReceiptIsPrinted(tester);
    }, tags: ['US_CA_33', 'FR_CA_4_1', 'FR_CA_4_8', 'Phase2']);
    testWidgets('''EPF i-SARAAN contribution — card funding''', (tester) async {
      await bddSetUp(tester);
      await theEpfAccountReferenceIsValidated(tester);
      await theCustomerInsertsTheirAtmCardAndEntersTheirPinOnTheHardwarePinPad(
          tester);
      await theAppFiresPostApiv1billpayBillercodeepfFundingsourcecardEmv(
          tester);
      await anEpfReceiptIsPrinted(tester);
    }, tags: ['US_CA_34', 'FR_CA_4_1', 'FR_CA_4_7', 'Phase2']);
    testWidgets('''CELCOM prepaid top-up — card funding''', (tester) async {
      await bddSetUp(tester);
      await theAgentEntersTheCustomersCelcomPhoneNumberAndItIsValidated(tester);
      await theCustomerInsertsTheirAtmCardAndEntersTheirPinOnTheHardwarePinPad(
          tester);
      await theAppFiresPostApiv1topupTelcocelcomFundingsourcecardEmv(tester);
      await theTopupIsAppliedInstantlyToThePhoneNumber(tester);
      await aTopupReceiptIsPrinted(tester);
    }, tags: ['US_CA_35', 'FR_CA_4_2', 'FR_CA_4_7', 'Phase2']);
    testWidgets('''M1 prepaid top-up — cash funding''', (tester) async {
      await bddSetUp(tester);
      await theAgentEntersTheCustomersM1PhoneNumberAndItIsValidated(tester);
      await theAgentAcceptsCashAndClicksConfirmCashCollected(tester);
      await theAppFiresPostApiv1topupTelcom1Fundingsourcecash(tester);
      await theTopupIsAppliedToTheM1Number(tester);
      await aTopupReceiptIsPrinted(tester);
    }, tags: ['US_CA_36', 'FR_CA_4_2', 'FR_CA_4_8', 'Phase2']);
    testWidgets('''M1 prepaid top-up — card funding''', (tester) async {
      await bddSetUp(tester);
      await theM1PhoneNumberIsValidated(tester);
      await theCustomerInsertsTheirAtmCardAndEntersTheirPinOnTheHardwarePinPad(
          tester);
      await theAppFiresPostApiv1topupTelcom1FundingsourcecardEmv(tester);
      await aTopupReceiptIsPrinted(tester);
    }, tags: ['US_CA_37', 'FR_CA_4_2', 'FR_CA_4_7', 'Phase2']);
    testWidgets(
        '''Sarawak Pay e-Wallet withdrawal — agent disburses physical cash''',
        (tester) async {
      await bddSetUp(tester);
      await theCustomerProvidesTheirSarawakPayAccountIdentifier(tester);
      await theEwalletAccountIsValidatedAndHasSufficientBalance(tester);
      await theCustomerConfirmsTheWithdrawalAmountOnscreen(tester);
      await theAppFiresPostApiv1ewalletwithdrawWalletsarawakPayFundingsourcecash(
          tester);
      await theAgentHandsOverPhysicalCashFromTheirFloat(tester);
      await theAgentsFloatIncreasesBankCreditsAgentForCashDisbursed(tester);
    }, tags: ['US_CA_38', 'FR_CA_4_6', 'FR_CA_4_8', 'Phase2']);
    testWidgets('''Sarawak Pay e-Wallet withdrawal — card authentication''',
        (tester) async {
      await bddSetUp(tester);
      await theCustomerProvidesTheirSarawakPayAccountIdentifier(tester);
      await theCustomerInsertsTheirAtmCardAndEntersTheirPinOnTheHardwarePinPad(
          tester);
      await theAppFiresPostApiv1ewalletwithdrawWalletsarawakPayFundingsourcecardEmv(
          tester);
      await theAgentHandsOverPhysicalCash(tester);
    }, tags: ['US_CA_39', 'FR_CA_4_6', 'FR_CA_4_7', 'Phase2']);
    testWidgets('''Sarawak Pay e-Wallet top-up — customer pays cash to agent''',
        (tester) async {
      await bddSetUp(tester);
      await theCustomerProvidesTheirSarawakPayAccountIdentifier(tester);
      await theAgentAcceptsCashFromTheCustomerAndClicksConfirmCashCollected(
          tester);
      await theAppFiresPostApiv1ewallettopupWalletsarawakPayFundingsourcecash(
          tester);
      await theAgentsFloatDecreasesAgentIsNowHoldingBanksMoney(tester);
      await theCustomersSarawakPayEwalletIsCredited(tester);
    }, tags: ['US_CA_40', 'FR_CA_4_6', 'FR_CA_4_8', 'Phase2']);
    testWidgets('''Sarawak Pay e-Wallet top-up — card funding''',
        (tester) async {
      await bddSetUp(tester);
      await theCustomerProvidesTheirSarawakPayAccountIdentifier(tester);
      await theCustomerInsertsTheirAtmCardAndEntersTheirPinOnTheHardwarePinPad(
          tester);
      await theAppFiresPostApiv1ewallettopupWalletsarawakPayFundingsourcecardEmv(
          tester);
      await theCustomersSarawakPayEwalletIsCredited(tester);
    }, tags: ['US_CA_41', 'FR_CA_4_6', 'FR_CA_4_7', 'Phase2']);
    testWidgets('''eSSP certificate purchase — cash funding''', (tester) async {
      await bddSetUp(tester);
      await theAgentSelectsEsspAndEntersTheCustomersNricAndEsspCertificateType(
          tester);
      await theCustomerPaysPhysicalCashToTheAgent(tester);
      await theAgentClicksConfirmCashCollected(tester);
      await theAppFiresPostApiv1essppurchaseFundingsourcecash(tester);
      await aPrintedEsspCertificateSlipIsIssuedToTheCustomer(tester);
      await theAgentsFloatDecreases(tester);
    }, tags: ['US_CA_42', 'FR_CA_4_6', 'FR_CA_4_8', 'Phase2']);
    testWidgets('''eSSP certificate purchase — card funding''', (tester) async {
      await bddSetUp(tester);
      await theEsspCertificateTypeAndNricAreEnteredAndValidated(tester);
      await theCustomerInsertsTheirAtmCardAndEntersTheirPinOnTheHardwarePinPad(
          tester);
      await theAppFiresPostApiv1essppurchaseFundingsourcecardEmv(tester);
      await aPrintedEsspCertificateSlipIsIssued(tester);
    }, tags: ['US_CA_43', 'FR_CA_4_6', 'FR_CA_4_7', 'Phase2']);
    testWidgets('''PIN Purchase (digital voucher) — card funding''',
        (tester) async {
      await bddSetUp(tester);
      await theAgentSelectsPinPurchaseAndChoosesTheVoucherTypeEgDigiRm10(
          tester);
      await theCustomerInsertsTheirAtmCardAndEntersTheirPinOnTheHardwarePinPad(
          tester);
      await theAppFiresPostApiv1retailpinpurchaseWithFundingsourcecardEmv(
          tester);
      await theAgentsFloatDecreasesByRm10(tester);
      await theTerminalPrintsASlipWithThe16digitPinCode(tester);
      await theAgentEarnsACommissionOnTheSale(tester);
    }, tags: ['US_CA_44', 'FR_CA_9_2', 'FR_CA_4_7', 'Phase2']);
    testWidgets(
        '''Card-funded service — DUKPT PIN entry always before API call''',
        (tester) async {
      await bddSetUp(tester);
      await anyCardfundedServiceBillTopupEsspSarawakPayPinVoucher(tester);
      await theServicespecificValidationRef1OrPhoneCheckHasPassed(tester);
      await theHardwarePinPadIsActivatedOnlyAfterValidation(tester);
      await theAppSendsTheEncryptedPinBlockViaDukptInTheApiRequestBody(tester);
      await theAgentNeverHasAccessToTheRawPin(tester);
    }, tags: ['US_CA_26', 'US_CA_30', 'FR_CA_4_7', 'Phase2']);
    testWidgets(
        '''Cash-funded service — MyKad required for large cash collections''',
        (tester) async {
      await bddSetUp(tester);
      await anyCashfundedServiceWhereTheAgentCollectsRm3000InCash(tester);
      await theAgentClicksConfirmCashCollected(tester);
      await theAppInterruptsAndRequiresAMykadScanToRecordTheCustomersIdentityForAml(
          tester);
      await onlyThenSubmitsTheApiCallWithTheMykadReferenceNumber(tester);
    }, tags: ['US_CA_07', 'US_CA_08', 'FR_CA_4_8', 'Phase2']);
  });
}
