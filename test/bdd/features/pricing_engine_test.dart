// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: type=lint, type=warning

import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';

import './step/the_agent_is_logged_in_with_an_active_session.dart';
import './step/the_agent_has_entered_all_required_transaction_inputs.dart';
import './step/the_agent_taps_proceed.dart';
import './step/the_app_automatically_pauses_the_workflow.dart';
import './step/calls_backend_post_apiv1transactionsquote.dart';
import './step/displays_a_loading_indicator_while_awaiting_the_fee_response.dart';
import './step/the_app_has_retrieved_the_transaction_quote_successfully.dart';
import './step/the_dual_handshake_begins.dart';
import './step/the_customer_facing_display_prominently_shows.dart';
import './step/blocks_hardware_pin_entry_until_the_customer_taps_agree.dart';
import './step/the_agent_facing_display_shows_estimated_commission_rm050.dart';
import './step/this_commission_value_is_never_shown_on_the_customer_facing_display.dart';
import './step/a_customer_requests_a_transaction_of_rm4000.dart';
import './step/the_app_performs_the_client_side_stp_hard_cap_pre_check.dart';
import './step/the_app_blocks_the_transaction_before_calling_quote.dart';
import './step/displays_err_val_amount_exceeds_limit_maximum_rm3000_per_stp_transaction.dart';

void main() {
  group('''Parameter Engine''', () {
    Future<void> bddSetUp(WidgetTester tester) async {
      await theAgentIsLoggedInWithAnActiveSession(tester);
    }

    testWidgets('''Transaction initiates fee engine quote API call''',
        (tester) async {
      await bddSetUp(tester);
      await theAgentHasEnteredAllRequiredTransactionInputs(tester);
      await theAgentTapsProceed(tester);
      await theAppAutomaticallyPausesTheWorkflow(tester);
      await callsBackendPostApiv1transactionsquote(tester);
      await displaysALoadingIndicatorWhileAwaitingTheFeeResponse(tester);
    }, tags: ['US_CA_06', 'FR_CA_2_1', 'MVP']);
    testWidgets('''Customer explicitly consents to the transaction fee''',
        (tester) async {
      await bddSetUp(tester);
      await theAppHasRetrievedTheTransactionQuoteSuccessfully(tester);
      await theDualHandshakeBegins(tester);
      await theCustomerFacingDisplayProminentlyShows(tester);
      await blocksHardwarePinEntryUntilTheCustomerTapsAgree(tester);
    }, tags: ['US_CA_06', 'FR_CA_2_2', 'MVP']);
    testWidgets(
        '''Agent views commission earned — never shown on customer display''',
        (tester) async {
      await bddSetUp(tester);
      await theAppHasRetrievedTheTransactionQuoteSuccessfully(tester);
      await theDualHandshakeBegins(tester);
      await theAgentFacingDisplayShowsEstimatedCommissionRm050(tester);
      await thisCommissionValueIsNeverShownOnTheCustomerFacingDisplay(tester);
    }, tags: ['US_CA_06', 'FR_CA_2_3', 'MVP']);
    testWidgets('''STP hard cap pre_check blocks over_limit transaction''',
        (tester) async {
      await bddSetUp(tester);
      await aCustomerRequestsATransactionOfRm4000(tester);
      await theAppPerformsTheClientSideStpHardCapPreCheck(tester);
      await theAppBlocksTheTransactionBeforeCallingQuote(tester);
      await displaysErrValAmountExceedsLimitMaximumRm3000PerStpTransaction(
          tester);
    }, tags: ['US_CA_06', 'FR_CA_2_1', 'MVP']);
  });
}
