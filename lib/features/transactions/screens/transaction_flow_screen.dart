import 'package:flutter/material.dart';
import 'package:decimal/decimal.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:agentbanking_channel/features/transactions/providers/transaction_provider.dart';
import 'package:agentbanking_channel/features/auth/providers/auth_provider.dart';
import 'package:agentbanking_channel/core/offline/widgets/offline_indicator.dart';
import 'package:agentbanking_channel/features/transactions/screens/bill_payment_form.dart';
import 'package:agentbanking_channel/features/transactions/screens/topup_form.dart';
import 'package:agentbanking_channel/features/transactions/models/transaction_models.dart';
import 'package:agentbanking_channel/features/transactions/screens/cashless_payment_form.dart';
import 'package:agentbanking_channel/features/transactions/screens/special_services_form.dart';
import 'package:agentbanking_channel/features/transactions/screens/ewallet_form.dart';
import 'package:agentbanking_channel/features/transactions/widgets/funding_source_selector.dart';
import 'package:agentbanking_channel/features/transactions/widgets/balance_inquiry_result.dart';

// Provider for the amount input
final transactionAmountProvider = StateProvider.autoDispose<String>((ref) => '100.00');

// Provider for the selected funding source
final fundingSourceProvider = StateProvider.autoDispose<FundingSource>((ref) => FundingSource.CASH);

// Provider for DuitNow Proxy ID
final duitNowProxyProvider = StateProvider.autoDispose<String>((ref) => '0123456789');

class TransactionFlowScreen extends ConsumerWidget {
  final String title;
  final String serviceCode;

  const TransactionFlowScreen({
    Key? key,
    required this.title,
    required this.serviceCode,
  }) : super(key: key);

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final state = ref.watch(transactionProvider);
    final authState = ref.watch(authProvider);
    final agentId = authState.user?.agentId ?? 'AGENT_UNKNOWN';
    final amountText = ref.watch(transactionAmountProvider);
    final selectedSource = ref.watch(fundingSourceProvider);

    return Scaffold(
      backgroundColor: const Color(0xFFF8F9FA),
      appBar: AppBar(
        title: Text(title, style: const TextStyle(fontWeight: FontWeight.bold, fontSize: 18)),
        backgroundColor: Colors.white,
        elevation: 0,
        centerTitle: true,
        actions: const [OfflineIndicator()],
      ),
      body: Padding(
        padding: const EdgeInsets.all(24.0),
        child: Center(
          child: ConstrainedBox(
            constraints: const BoxConstraints(maxWidth: 500),
            child: Card(
              elevation: 0,
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(32),
                side: BorderSide(color: Colors.grey.shade200),
              ),
              child: Padding(
                padding: const EdgeInsets.all(32.0),
                child: Column(
                  mainAxisSize: MainAxisSize.min,
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    _buildStateView(context, ref, state, agentId, amountText, selectedSource),
                    if (state.status == TransactionStatus.failed)
                      Padding(
                        padding: const EdgeInsets.only(top: 24),
                        child: Text(
                          state.error ?? 'Unknown Error', 
                          style: const TextStyle(color: Colors.red, fontSize: 13),
                          textAlign: TextAlign.center,
                        ),
                      ),
                  ],
                ),
              ),
            ),
          ),
        ),
      ),
    );
  }

  Widget _buildStateView(BuildContext context, WidgetRef ref, TransactionState state, String agentId, String amountText, FundingSource selectedSource) {
    switch (state.status) {
      case TransactionStatus.idle:
        final bool supportsMultiSource = ['BILL_PAY', 'TOP_UP', 'CASH_DEP', 'ESSP_PURCHASE', 'PIN_PURCHASE', 'SARAWAK_PAY', 'CASHLESS_PAY'].contains(serviceCode);
        
        return Column(
          children: [
            if (supportsMultiSource) ...[
              FundingSourceSelector(
                key: const Key('funding_selector'),
                selectedSource: selectedSource,
                onSourceChanged: (source) => ref.read(fundingSourceProvider.notifier).state = source,
              ),
              const SizedBox(height: 16),
              if (selectedSource == FundingSource.DUITNOW_MOBILE) ...[
                TextField(
                  onChanged: (v) => ref.read(duitNowProxyProvider.notifier).state = v,
                  decoration: InputDecoration(
                    labelText: 'DuitNow Proxy ID (Mobile/IC)',
                    hintText: 'e.g. 0123456789',
                    prefixIcon: const Icon(Icons.perm_identity),
                    filled: true,
                    fillColor: Colors.white,
                    border: OutlineInputBorder(borderRadius: BorderRadius.circular(12)),
                  ),
                ),
                const SizedBox(height: 24),
              ],
              const SizedBox(height: 16),
            ],
            _buildServiceSpecificInput(context, ref, agentId, amountText, selectedSource),
          ],
        );
      case TransactionStatus.quoting:
      case TransactionStatus.processing:
        return Column(
          children: [
            const CircularProgressIndicator(),
            const SizedBox(height: 24),
            Text(
              state.status == TransactionStatus.quoting ? 'Calculating Fees...' : 'Processing Transaction...',
              style: const TextStyle(color: Colors.grey, fontWeight: FontWeight.w500),
            ),
          ],
        );
      case TransactionStatus.waitingConsent:
        return Column(
          children: [
            const Text('Confirm Details', style: TextStyle(fontWeight: FontWeight.bold, fontSize: 18)),
            const SizedBox(height: 24),
            if (serviceCode != 'BALANCE_INQUIRY') ...[
              _buildSummaryRow('Amount', 'RM ${state.quote?.amount}'),
              const Divider(height: 24),
              _buildSummaryRow('Transaction Fee', 'RM ${state.quote?.fee}'),
              const Divider(height: 24),
              _buildSummaryRow('Total to Charged', 'RM ${state.quote?.total}', isBold: true),
              const SizedBox(height: 32),
              Container(
                padding: const EdgeInsets.symmetric(vertical: 12, horizontal: 16),
                decoration: BoxDecoration(
                  color: Colors.blue.shade50,
                  borderRadius: BorderRadius.circular(12),
                  border: Border.all(color: Colors.blue.shade100),
                ),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    const Text(
                      'AGENT COMMISSION',
                      style: TextStyle(
                        fontSize: 10,
                        fontWeight: FontWeight.bold,
                        color: Colors.blue,
                        letterSpacing: 0.5,
                      ),
                    ),
                    Text(
                      'RM ${state.quote?.commission}',
                      style: const TextStyle(
                        fontSize: 14,
                        fontWeight: FontWeight.bold,
                        color: Colors.blue,
                      ),
                    ),
                  ],
                ),
              ),
            ] else 
              const Text('Secure balance check initiated.', style: TextStyle(fontSize: 14)),
              
            const SizedBox(height: 48),
            Row(
              children: [
                Expanded(
                  child: OutlinedButton(
                    onPressed: () => ref.read(transactionProvider.notifier).reset(),
                    child: const Text('Cancel'),
                  ),
                ),
                const SizedBox(width: 16),
                Expanded(
                  child: ElevatedButton(
                    key: const Key('btn_confirm'),
                    onPressed: () => ref.read(transactionProvider.notifier).confirmConsent(
                      duitNowProxyId: ref.read(duitNowProxyProvider),
                    ),
                    child: const Text('Confirm'),
                  ),
                ),
              ],
            ),
          ],
        );
      case TransactionStatus.reversalQueued:
        return Column(
          children: [
            const Icon(Icons.history, color: Colors.orange, size: 80),
            const SizedBox(height: 24),
            const Text('Request Timeout', style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold)),
            const SizedBox(height: 8),
            const Text('A reversal has been queued for offline processing.', textAlign: TextAlign.center, style: TextStyle(color: Colors.grey)),
            const SizedBox(height: 48),
            SizedBox(
              width: double.infinity,
              height: 56,
              child: ElevatedButton(
                onPressed: () {
                  ref.read(transactionProvider.notifier).reset();
                  Navigator.pop(context);
                },
                child: const Text('DONE'),
              ),
            ),
          ],
        );
      case TransactionStatus.waitingCard:
        return const Column(
          children: [
            Icon(Icons.credit_card_outlined, size: 80, color: Colors.indigo),
            SizedBox(height: 24),
            Text('Insert Customer Card', key: const Key('status_waiting_card'), style: TextStyle(fontWeight: FontWeight.bold, fontSize: 18)),
            SizedBox(height: 8),
            Text('Please use the attached card reader', style: TextStyle(color: Colors.grey, fontSize: 13)),
          ],
        );
      case TransactionStatus.waitingPin:
        return const Column(
          children: [
            Icon(Icons.pin_outlined, size: 80, color: Colors.indigo),
            SizedBox(height: 24),
            Text('Enter Secure PIN', key: const Key('status_waiting_pin'), style: TextStyle(fontWeight: FontWeight.bold, fontSize: 18)),
            SizedBox(height: 8),
            Text('Customer should enter PIN on the PinPad', style: TextStyle(color: Colors.grey, fontSize: 13)),
          ],
        );
      case TransactionStatus.success:
        if (serviceCode == 'BALANCE_INQUIRY' && state.result?.balance != null) {
          return BalanceInquiryResult(
            balance: state.result!.balance!,
            referenceId: state.result!.referenceId,
            onDone: () {
              ref.read(transactionProvider.notifier).reset();
              Navigator.pop(context);
            },
          );
        }
        return Column(
          children: [
            const Icon(Icons.check_circle, color: Colors.green, size: 80),
            const SizedBox(height: 24),
            Text('Success!', key: const Key('status_success'), style: TextStyle(fontSize: 24, fontWeight: FontWeight.bold, color: Colors.green.shade700)),
            const SizedBox(height: 8),
            Text('${title.toUpperCase()} COMPLETED', style: const TextStyle(fontSize: 12, color: Colors.grey, letterSpacing: 1)),
            const SizedBox(height: 24),
            Container(
              padding: const EdgeInsets.all(16),
              decoration: BoxDecoration(color: Colors.grey.shade50, borderRadius: BorderRadius.circular(16)),
              child: Column(
                children: [
                  _buildSummaryRow('Reference ID', state.result?.referenceId ?? 'N/A', small: true),
                  const SizedBox(height: 8),
                  _buildSummaryRow('Status', 'APPROVED', color: Colors.green, small: true),
                ],
              ),
            ),
            const SizedBox(height: 48),
            SizedBox(
              width: double.infinity,
              height: 56,
              child: ElevatedButton(
                onPressed: () {
                  ref.read(transactionProvider.notifier).reset();
                  Navigator.pop(context);
                },
                child: const Text('DONE'),
              ),
            ),
          ],
        );
      case TransactionStatus.failed:
        return Column(
          children: [
            const Icon(Icons.error_outline, color: Colors.red, size: 80),
            const SizedBox(height: 24),
            const Text('Transaction Failed', style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold)),
            const SizedBox(height: 48),
            SizedBox(
              width: double.infinity,
              height: 56,
              child: ElevatedButton(
                onPressed: () => ref.read(transactionProvider.notifier).reset(),
                child: const Text('TRY AGAIN'),
              ),
            ),
          ],
        );
      default:
        return const SizedBox.shrink();
    }
  }

  Widget _buildServiceSpecificInput(BuildContext context, WidgetRef ref, String agentId, String amountText, FundingSource selectedSource) {
    if (serviceCode == 'BILL_PAY') {
      return BillPaymentForm(
        onSubmit: (biller, ref1, amount) {
          ref.read(transactionProvider.notifier).startTransaction(
            amount, 
            agentId, 
            serviceCode: serviceCode,
            fundingSource: ref.read(fundingSourceProvider),
            metadata: {'billerCode': biller, 'ref1': ref1},
          );
        },
      );
    } else if (serviceCode == 'TOP_UP') {
      return TopUpForm(
        onSubmit: (telco, mobile, amount) {
          ref.read(transactionProvider.notifier).startTransaction(
            amount, 
            agentId, 
            serviceCode: serviceCode,
            fundingSource: ref.read(fundingSourceProvider),
            metadata: {'telco': telco, 'mobileNumber': mobile},
          );
        },
      );
    } else if (serviceCode == 'SARAWAK_PAY') {
      return EWalletForm(
        onSubmit: (type, mobile, amount) {
          ref.read(transactionProvider.notifier).startTransaction(
            amount, 
            agentId, 
            serviceCode: serviceCode,
            fundingSource: ref.read(fundingSourceProvider),
            metadata: {'ewalletType': 'SARAWAK_PAY', 'subType': type, 'mobile': mobile},
          );
        },
      );
    } else if (serviceCode == 'CASHLESS_PAY') {
      return CashlessPaymentForm(
        onSubmit: (method, amount) {
          ref.read(transactionProvider.notifier).startTransaction(
            amount, 
            agentId, 
            serviceCode: serviceCode,
            fundingSource: ref.read(fundingSourceProvider),
            metadata: {'paymentMethod': method},
          );
        },
      );
    } else if (serviceCode == 'ESSP_PURCHASE' || serviceCode == 'PIN_PURCHASE') {
      return SpecialServicesForm(
        serviceType: serviceCode == 'ESSP_PURCHASE' ? 'ESSP' : 'PIN',
        onSubmit: (metadata, amount) {
          ref.read(transactionProvider.notifier).startTransaction(
            amount, 
            agentId, 
            serviceCode: serviceCode,
            fundingSource: ref.read(fundingSourceProvider),
            metadata: metadata.map((k, v) => MapEntry(k, v.toString())),
          );
        },
      );
    }

    final bool needsAmount = serviceCode != 'BALANCE_INQUIRY';
    
    return Column(
      children: [
        Container(
          padding: const EdgeInsets.all(16),
          decoration: BoxDecoration(
            color: Theme.of(context).colorScheme.primary.withOpacity(0.1),
            shape: BoxShape.circle,
          ),
          child: Icon(
            needsAmount ? Icons.payments_outlined : Icons.account_balance_wallet_outlined,
            size: 32,
            color: Theme.of(context).colorScheme.primary,
          ),
        ),
        const SizedBox(height: 24),
        if (needsAmount) ...[
          const Text('Enter Amount', style: TextStyle(fontWeight: FontWeight.bold, fontSize: 16)),
          const Text('Enter amount to continue', style: TextStyle(color: Colors.grey, fontSize: 12)),
          const SizedBox(height: 32),
          TextField(
            onChanged: (value) => ref.read(transactionAmountProvider.notifier).state = value,
            keyboardType: const TextInputType.numberWithOptions(decimal: true),
            textAlign: TextAlign.center,
            controller: TextEditingController.fromValue(
              TextEditingValue(
                text: amountText,
                selection: TextSelection.collapsed(offset: amountText.length),
              ),
            ),
            style: const TextStyle(fontSize: 32, fontWeight: FontWeight.bold),
            decoration: InputDecoration(
              prefixText: 'RM ',
              prefixStyle: const TextStyle(fontSize: 24, fontWeight: FontWeight.bold, color: Colors.grey),
              filled: true,
              fillColor: Colors.grey.shade50,
              border: OutlineInputBorder(borderRadius: BorderRadius.circular(20), borderSide: BorderSide.none),
            ),
          ),
          const SizedBox(height: 32),
        ] else 
          const Column(
            children: [
              Text('Balance Inquiry', style: TextStyle(fontWeight: FontWeight.bold, fontSize: 18)),
              SizedBox(height: 8),
              Text('Check customer account balance securely', textAlign: TextAlign.center, style: TextStyle(color: Colors.grey, fontSize: 13)),
              SizedBox(height: 32),
            ],
          ),
          
        SizedBox(
          width: double.infinity,
          height: 56,
          child: ElevatedButton(
            onPressed: () {
              final amount = Decimal.tryParse(amountText) ?? Decimal.zero;
              if (needsAmount && amount <= Decimal.zero) {
                ScaffoldMessenger.of(context).showSnackBar(const SnackBar(content: Text('Please enter a valid amount')));
                return;
              }
              ref.read(transactionProvider.notifier).startTransaction(
                amount, 
                agentId, 
                serviceCode: serviceCode,
                fundingSource: selectedSource,
              );
            },
            child: Text(needsAmount ? 'GET QUOTE' : 'PROCEED'),
          ),
        ),
      ],
    );
  }

  Widget _buildSummaryRow(String label, String value, {bool isBold = false, Color? color, bool small = false}) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Expanded(
          child: Text(
            label, 
            style: TextStyle(color: Colors.grey, fontSize: small ? 11 : 14),
            overflow: TextOverflow.ellipsis,
          ),
        ),
        const SizedBox(width: 8),
        Text(
          value, 
          textAlign: TextAlign.right,
          style: TextStyle(
            fontWeight: isBold ? FontWeight.bold : FontWeight.w600,
            fontSize: small ? 11 : (isBold ? 18 : 14),
            color: color,
          ),
        ),
      ],
    );
  }
}
