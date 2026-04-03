// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: type=lint, type=warning

import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';

import './step/the_pos_terminal_local_clock_reaches235500_myt.dart';
import './step/the_agent_is_logged_in_and_active.dart';
import './step/the_app_displays_a_warning_banner.dart';
import './step/the_pos_terminal_local_clock_reaches235959_myt.dart';
import './step/the_agent_attempts_to_initiate_any_financial_transaction.dart';
import './step/all_stp_workflows_are_disabled.dart';
import './step/the_ui_shows_settlement_in_progress_please_wait.dart';
import './step/the_terminal_is_in_the_settlement_in_progress_state.dart';
import './step/the_backend_signals_settlement_finalization_expected_by0200_am_myt.dart';
import './step/the_app_displays_settlement_complete_new_business_day_has_started.dart';
import './step/all_stp_financial_workflows_are_re_enabled.dart';

void main() {
  group('''EOD Cut_Off Operations''', () {
    testWidgets('''23:55 MYT warning displayed to agent''', (tester) async {
      await thePosTerminalLocalClockReaches235500Myt(tester);
      await theAgentIsLoggedInAndActive(tester);
      await theAppDisplaysAWarningBanner(tester);
    }, tags: ['US_CA_22', 'FR_CA_8_2', 'Phase2']);
    testWidgets('''23:59:59 MYT — all STP financial workflows disabled''',
        (tester) async {
      await thePosTerminalLocalClockReaches235959Myt(tester);
      await theAgentAttemptsToInitiateAnyFinancialTransaction(tester);
      await allStpWorkflowsAreDisabled(tester);
      await theUiShowsSettlementInProgressPleaseWait(tester);
    }, tags: ['US_CA_22', 'FR_CA_8_3', 'Phase2']);
    testWidgets(
        '''Settlement finalization notification re_enables operations''',
        (tester) async {
      await theTerminalIsInTheSettlementInProgressState(tester);
      await theBackendSignalsSettlementFinalizationExpectedBy0200AmMyt(tester);
      await theAppDisplaysSettlementCompleteNewBusinessDayHasStarted(tester);
      await allStpFinancialWorkflowsAreReEnabled(tester);
    }, tags: ['US_CA_22', 'FR_CA_8_4', 'Phase2']);
  });
}
