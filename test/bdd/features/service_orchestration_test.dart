// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: type=lint, type=warning

import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';

import './step/the_agent_is_logged_in_with_an_active_session.dart';
import './step/the_agent_types_a_destination_account_number.dart';
import './step/the_app_queries_the_backend_proxyenquiry.dart';
import './step/the_customer_display_shows_a_masked_recipient_name_like_mohd_ad_bin_al.dart';
import './step/the_customer_must_verbally_or_digitally_confirm_ownership_before_funds_are_collected.dart';
import './step/the_customer_requests_a_cash_withdrawal_of_rm6000.dart';
import './step/the_app_performs_the_client_side_limit_pre_check.dart';
import './step/the_app_detects_a_breach_of_the_rm5000_per_transaction_hard_cap.dart';
import './step/displays_err_val_amount_exceeds_limit_maximum_rm5000_per_transaction.dart';
import './step/does_not_call_the_backend_api.dart';
import './step/the_agent_selected_the_bill_payment_feature.dart';
import './step/the_agent_keys_in_the_customers_ref1_account_number.dart';
import './step/the_app_executes_a_biller_inquiry_pre_check_against_the_backend.dart';
import './step/proceeds_or_blocks_the_financial_handshake_based_on_the_real_time_api_response.dart';
import './step/the_agent_selected_prepaid_rm50_celcom.dart';
import './step/the_agent_keys_in_an_invalid_phone_number_format019999999x.dart';
import './step/the_app_blocks_the_financial_handshake_immediately.dart';
import './step/displays_err_val_invalid_phone_format.dart';
import './step/the_agent_entered_a_correctly_formatted_phone_number.dart';
import './step/the_telco_api_pre_check_returns_a_rejection.dart';
import './step/the_app_blocks_the_financial_handshake.dart';
import './step/displays_err_ext_biller_unavailable_or_number_not_found.dart';

void main() {
  group('''31 Core Services Orchestration Validation''', () {
    Future<void> bddSetUp(WidgetTester tester) async {
      await theAgentIsLoggedInWithAnActiveSession(tester);
    }

    testWidgets('''Cash Deposit — ProxyEnquiry masked name verification''',
        (tester) async {
      await bddSetUp(tester);
      await theAgentTypesADestinationAccountNumber(tester);
      await theAppQueriesTheBackendProxyenquiry(tester);
      await theCustomerDisplayShowsAMaskedRecipientNameLikeMohdAdBinAl(tester);
      await theCustomerMustVerballyOrDigitallyConfirmOwnershipBeforeFundsAreCollected(
          tester);
    }, tags: ['US_CA_11', 'FR_CA_4_3', 'MVP']);
    testWidgets('''Client_side withdrawal limit pre_check''', (tester) async {
      await bddSetUp(tester);
      await theCustomerRequestsACashWithdrawalOfRm6000(tester);
      await theAppPerformsTheClientSideLimitPreCheck(tester);
      await theAppDetectsABreachOfTheRm5000PerTransactionHardCap(tester);
      await displaysErrValAmountExceedsLimitMaximumRm5000PerTransaction(tester);
      await doesNotCallTheBackendApi(tester);
    }, tags: ['US_CA_03', 'FR_CA_4_4', 'MVP']);
    testWidgets('''Bill Payment — JomPAY Ref_1 validation''', (tester) async {
      await bddSetUp(tester);
      await theAgentSelectedTheBillPaymentFeature(tester);
      await theAgentKeysInTheCustomersRef1AccountNumber(tester);
      await theAppExecutesABillerInquiryPreCheckAgainstTheBackend(tester);
      await proceedsOrBlocksTheFinancialHandshakeBasedOnTheRealTimeApiResponse(
          tester);
    }, tags: ['US_CA_07', 'FR_CA_4_1', 'Phase2']);
    testWidgets('''Prepaid Top_Up — invalid phone number blocked''',
        (tester) async {
      await bddSetUp(tester);
      await theAgentSelectedPrepaidRm50Celcom(tester);
      await theAgentKeysInAnInvalidPhoneNumberFormat019999999x(tester);
      await theAppBlocksTheFinancialHandshakeImmediately(tester);
      await displaysErrValInvalidPhoneFormat(tester);
    }, tags: ['US_CA_08', 'FR_CA_4_2', 'Phase2']);
    testWidgets('''Prepaid Top_Up — Telco API rejects number''',
        (tester) async {
      await bddSetUp(tester);
      await theAgentSelectedPrepaidRm50Celcom(tester);
      await theAgentEnteredACorrectlyFormattedPhoneNumber(tester);
      await theTelcoApiPreCheckReturnsARejection(tester);
      await theAppBlocksTheFinancialHandshake(tester);
      await displaysErrExtBillerUnavailableOrNumberNotFound(tester);
    }, tags: ['US_CA_08', 'FR_CA_4_2', 'Phase2']);
  });
}
