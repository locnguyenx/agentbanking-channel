// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: type=lint, type=warning

import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';

import './step/the_agent_is_logged_in_with_an_active_session.dart';
import './step/the_agent_is_logged_in_and_active.dart';
import './step/a_cash_withdrawal_authorization_request_is_sent_to_the_backend.dart';
import './step/the_backend_does_not_respond_within_the_timeout_threshold25_seconds.dart';
import './step/the_app_does_not_retry_the_financial_request.dart';
import './step/immediately_queues_an_mti0400_reversal_payload_with_the_original_x_idempotency_key.dart';
import './step/the_agent_float_is_not_manually_adjusted_locally.dart';
import './step/the_backend_returned_http200_ok_for_a_cash_withdrawal.dart';
import './step/the_physical_pos_printer_detects_out_of_paper_or_paper_jam.dart';
import './step/the_app_queues_an_mti0400_reversal_payload_in_the_encrypted_sqlite_queue.dart';
import './step/the_agent_float_is_not_adjusted_locally_defers_to_backend_resolution.dart';
import './step/an_mti0400_reversal_is_queued_in_the_encrypted_offline_store.dart';
import './step/the_pos_recovers_network_connectivity.dart';
import './step/the_app_continuously_retries_the_reversal_every60_seconds.dart';
import './step/uses_the_original_xidempotencykey_to_prevent_duplicate_reversals.dart';
import './step/permanently_clears_the_sqlite_cache_upon_http200_reversal_confirmation.dart';
import './step/a_non_financial_request_eg_balance_inquiry_proxyenquiry_fails.dart';
import './step/the_app_retries_the_request.dart';
import './step/it_uses_exponential_backoff1s_wait_then2s_then4s.dart';
import './step/makes_a_maximum_of3_retry_attempts_before_displaying_an_error.dart';

void main() {
  group('''Store & Forward _ Reversals and Retries''', () {
    Future<void> bddSetUp(WidgetTester tester) async {
      await theAgentIsLoggedInWithAnActiveSession(tester);
    }

    testWidgets(
        '''ZERO retries on financial authorization — immediate reversal on timeout''',
        (tester) async {
      await bddSetUp(tester);
      await theAgentIsLoggedInAndActive(tester);
      await aCashWithdrawalAuthorizationRequestIsSentToTheBackend(tester);
      await theBackendDoesNotRespondWithinTheTimeoutThreshold25Seconds(tester);
      await theAppDoesNotRetryTheFinancialRequest(tester);
      await immediatelyQueuesAnMti0400ReversalPayloadWithTheOriginalXIdempotencyKey(
          tester);
      await theAgentFloatIsNotManuallyAdjustedLocally(tester);
    }, tags: ['US_CA_15', 'FR_CA_7_1', 'FR_CA_7_2', 'MVP']);
    testWidgets(
        '''Printer jam after HTTP 200 triggers automatic MTI 0400 Reversal''',
        (tester) async {
      await bddSetUp(tester);
      await theAgentIsLoggedInAndActive(tester);
      await theBackendReturnedHttp200OkForACashWithdrawal(tester);
      await thePhysicalPosPrinterDetectsOutOfPaperOrPaperJam(tester);
      await theAppQueuesAnMti0400ReversalPayloadInTheEncryptedSqliteQueue(
          tester);
      await theAgentFloatIsNotAdjustedLocallyDefersToBackendResolution(tester);
    }, tags: ['US_CA_15', 'FR_CA_7_3', 'MVP']);
    testWidgets(
        '''Store & Forward re-transmits reversal every 60 seconds via X-Idempotency-Key''',
        (tester) async {
      await bddSetUp(tester);
      await anMti0400ReversalIsQueuedInTheEncryptedOfflineStore(tester);
      await thePosRecoversNetworkConnectivity(tester);
      await theAppContinuouslyRetriesTheReversalEvery60Seconds(tester);
      await usesTheOriginalXidempotencykeyToPreventDuplicateReversals(tester);
      await permanentlyClearsTheSqliteCacheUponHttp200ReversalConfirmation(
          tester);
    }, tags: ['US_CA_15', 'FR_CA_7_4', 'MVP']);
    testWidgets('''Non_financial requests use exponential backoff''',
        (tester) async {
      await bddSetUp(tester);
      await theAgentIsLoggedInAndActive(tester);
      await aNonFinancialRequestEgBalanceInquiryProxyenquiryFails(tester);
      await theAppRetriesTheRequest(tester);
      await itUsesExponentialBackoff1sWaitThen2sThen4s(tester);
      await makesAMaximumOf3RetryAttemptsBeforeDisplayingAnError(tester);
    }, tags: ['US_CA_15', 'FR_CA_7_5', 'MVP']);
  });
}
