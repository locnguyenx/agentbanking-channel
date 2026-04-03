// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: type=lint, type=warning

import 'package:bdd_widget_test/data_table.dart' as bdd;
import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';

import './step/the_agent_is_logged_in_with_an_active_session.dart';
import './step/the_agent_enters_merchant_mode_on_the_pos.dart';
import './step/the_customer_pays_rm100_for_groceries_by_inserting_their_card_and_entering_pin.dart';
import './step/the_card_authorization_succeeds.dart';
import './step/the_backend_credits_the_agents_float_with_rm9900_rm100_minus1_mdr_rm100.dart';
import './step/the_app_shows_float_credited_rm9900_mdr_rm100.dart';
import './step/a_sales_receipt_is_issued_to_the_customer.dart';
import './step/the_agent_is_in_merchant_mode.dart';
import './step/the_terminal_generates_a_dynamic_qr_code_for_rm50.dart';
import './step/the_customer_scans_the_qr_code_with_their_banking_app_and_confirms_payment.dart';
import './step/paynet_notifies_the_backend.dart';
import './step/the_agents_float_is_credited_with_rm50_minus_mdr.dart';
import './step/a_sales_receipt_is_issued.dart';
import './step/the_agent_selects_pin_purchase_and_chooses_digi_rm10.dart';
import './step/the_customer_pays_rm10_physical_cash_to_the_agent.dart';
import './step/the_agent_confirms_cash_received.dart';
import './step/the_system_debits_the_agents_float_by_rm10.dart';
import './step/the_terminal_prints_a_slip_with_the16_digit_pin_code.dart';
import './step/the_agent_earns_a_commission_on_the_sale.dart';
import './step/the_customer_wants_to_buy_rm20_of_goods_and_get_rm50_cash_back.dart';
import './step/the_agent_swipes_the_customers_card_for_rm70_total.dart';
import './step/the_customer_enters_their_pin.dart';
import './step/the_backend_performs_split_accounting_automatically.dart';
import './step/the_agents_float_movement_reflects_the_net_position.dart';
import './step/a_combined_sales_cash_back_receipt_is_issued.dart';

void main() {
  group('''Merchant Services (Retail, PIN, Cash_Back)''', () {
    Future<void> bddSetUp(WidgetTester tester) async {
      await theAgentIsLoggedInWithAnActiveSession(tester);
    }

    testWidgets('''Retail Sale — agent accepts card payment as merchant''',
        (tester) async {
      await bddSetUp(tester);
      await theAgentEntersMerchantModeOnThePos(tester);
      await theCustomerPaysRm100ForGroceriesByInsertingTheirCardAndEnteringPin(
          tester);
      await theCardAuthorizationSucceeds(tester);
      await theBackendCreditsTheAgentsFloatWithRm9900Rm100Minus1MdrRm100(
          tester);
      await theAppShowsFloatCreditedRm9900MdrRm100(tester);
      await aSalesReceiptIsIssuedToTheCustomer(tester);
    }, tags: ['US_CA_17', 'FR_CA_9_1', 'FR_CA_9_4', 'Phase2']);
    testWidgets('''Retail Sale — agent accepts DuitNow QR payment''',
        (tester) async {
      await bddSetUp(tester);
      await theAgentIsInMerchantMode(tester);
      await theTerminalGeneratesADynamicQrCodeForRm50(tester);
      await theCustomerScansTheQrCodeWithTheirBankingAppAndConfirmsPayment(
          tester);
      await paynetNotifiesTheBackend(tester);
      await theAgentsFloatIsCreditedWithRm50MinusMdr(tester);
      await aSalesReceiptIsIssued(tester);
    }, tags: ['US-CA-17', 'FR_CA_9_1', 'Phase2']);
    testWidgets(
        '''PIN Voucher Purchase — agent sells digital voucher for cash''',
        (tester) async {
      await bddSetUp(tester);
      await theAgentSelectsPinPurchaseAndChoosesDigiRm10(tester);
      await theCustomerPaysRm10PhysicalCashToTheAgent(tester);
      await theAgentConfirmsCashReceived(tester);
      await theSystemDebitsTheAgentsFloatByRm10(tester);
      await theTerminalPrintsASlipWithThe16DigitPinCode(tester);
      await theAgentEarnsACommissionOnTheSale(tester);
    }, tags: ['US_CA_18', 'FR_CA_9_2', 'FR_CA_9_5', 'Phase2']);
    testWidgets(
        '''Cash_Back Hybrid — single card swipe for purchase + cash_back''',
        (tester) async {
      await bddSetUp(tester);
      await theCustomerWantsToBuyRm20OfGoodsAndGetRm50CashBack(tester);
      await theAgentSwipesTheCustomersCardForRm70Total(tester);
      await theCustomerEntersTheirPin(tester);
      await theBackendPerformsSplitAccountingAutomatically(
          tester,
          const bdd.DataTable([
            ["Purchase Amount", "RM 20 credited to merchant sale"],
            ["Cash_Back Amount", "RM 50 to be handed over by agent"]
          ]));
      await theAgentsFloatMovementReflectsTheNetPosition(tester);
      await aCombinedSalesCashBackReceiptIsIssued(tester);
    }, tags: ['US_CA_19', 'FR_CA_9_3', 'Phase2']);
  });
}
