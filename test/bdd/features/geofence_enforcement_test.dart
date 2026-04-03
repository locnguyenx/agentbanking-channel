// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: type=lint, type=warning

import 'package:bdd_widget_test/data_table.dart' as bdd;
import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';

import './step/the_agents_registered_location_is_at313901016869.dart';
import './step/the_device_gps_shows313951016872.dart';
import './step/the_agent_attempts_to_initiate_any_stp_transaction.dart';
import './step/the_geofence_check_passes_distance100m.dart';
import './step/the_transaction_proceeds_to_the_dual_handshake_workflow.dart';
import './step/the_device_gps_shows315001017000.dart';
import './step/the_agent_attempts_to_initiate_a_transaction.dart';
import './step/the_geofence_check_fails.dart';
import './step/the_app_displays_error_err_val_geofence_breach.dart';
import './step/the_transaction_is_instantly_blocked.dart';
import './step/the_agent_is_within_geofence.dart';
import './step/any_transaction_request_is_sent_to_the_backend.dart';
import './step/the_request_contains_headers.dart';
import './step/the_device_gps_is_unavailable_hardware_off_or_denied_permission.dart';
import './step/the_app_displays_err_val_gps_unavailable.dart';
import './step/all_stp_transactions_are_blocked_until_gps_is_restored.dart';

void main() {
  group('''Geofence Enforcement''', () {
    testWidgets('''Transaction allowed within 100m geofence''', (tester) async {
      await theAgentsRegisteredLocationIsAt313901016869(tester);
      await theDeviceGpsShows313951016872(tester);
      await theAgentAttemptsToInitiateAnyStpTransaction(tester);
      await theGeofenceCheckPassesDistance100m(tester);
      await theTransactionProceedsToTheDualHandshakeWorkflow(tester);
    }, tags: ['US_CA_02', 'FR_CA_1_2', 'MVP']);
    testWidgets('''Transaction blocked outside 100m geofence''',
        (tester) async {
      await theAgentsRegisteredLocationIsAt313901016869(tester);
      await theDeviceGpsShows315001017000(tester);
      await theAgentAttemptsToInitiateATransaction(tester);
      await theGeofenceCheckFails(tester);
      await theAppDisplaysErrorErrValGeofenceBreach(tester);
      await theTransactionIsInstantlyBlocked(tester);
    }, tags: ['US_CA_02', 'FR_CA_1_2', 'MVP']);
    testWidgets('''GPS coordinates sent in all API request headers''',
        (tester) async {
      await theAgentIsWithinGeofence(tester);
      await anyTransactionRequestIsSentToTheBackend(tester);
      await theRequestContainsHeaders(
          tester,
          const bdd.DataTable([
            ["X_GPS_Latitude", "Decimal(9,6)"],
            ["X_GPS_Longitude", "Decimal(9,6)"]
          ]));
    }, tags: ['US_CA_02', 'FR_CA_1_2', 'MVP']);
    testWidgets('''GPS unavailable blocks transaction''', (tester) async {
      await theDeviceGpsIsUnavailableHardwareOffOrDeniedPermission(tester);
      await theAgentAttemptsToInitiateATransaction(tester);
      await theAppDisplaysErrValGpsUnavailable(tester);
      await allStpTransactionsAreBlockedUntilGpsIsRestored(tester);
    }, tags: ['US_CA_02', 'FR_CA_1_2', 'MVP']);
  });
}
