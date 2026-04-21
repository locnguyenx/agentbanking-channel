import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:intl/intl.dart';
import 'package:agentbanking_channel/features/transactions/providers/transaction_provider.dart';
import 'package:agentbanking_channel/features/auth/providers/auth_provider.dart';
import 'package:agentbanking_channel/core/offline/widgets/offline_indicator.dart';
import 'package:agentbanking_channel/features/transactions/screens/bill_payment_form.dart';
import 'package:agentbanking_channel/features/transactions/screens/topup_form.dart';
import 'package:agentbanking_channel/features/transactions/models/transaction_models.dart';
import 'package:agentbanking_channel/features/transactions/screens/cashless_payment_form.dart';
import 'package:agentbanking_channel/features/transactions/screens/special_services_form.dart';
import 'package:agentbanking_channel/features/transactions/screens/jompay_form.dart';
import 'package:agentbanking_channel/features/transactions/screens/ewallet_form.dart';
import 'package:agentbanking_channel/features/transactions/widgets/funding_source_selector.dart';
import 'package:agentbanking_channel/features/transactions/widgets/balance_inquiry_result.dart';

// Provider for the amount input
final transactionAmountProvider = StateProvider.autoDispose<String>((ref) => '');

// Provider for the selected funding source
final fundingSourceProvider = StateProvider.autoDispose<FundingSource>((ref) => FundingSource.CASH);

// Provider for DuitNow Proxy ID
final duitNowProxyProvider = StateProvider.autoDispose<String>((ref) => '');

// Provider for Proxy Type (ACCOUNT or MOBILE)
final proxyTypeProvider = StateProvider.autoDispose<String>((ref) => 'ACCOUNT');

// Provider for metadata (e.g. destinationAccount)
final transactionMetadataProvider = StateProvider<Map<String, String>>((ref) => {});

// Provider to toggle between Agent and Customer view (for dual-display simulation/BDD)
final isCustomerViewProvider = StateProvider<bool>((ref) => false);

class TransactionFlowScreen extends ConsumerWidget {
  final String title;
  final String serviceCode;

  const TransactionFlowScreen({
    super.key,
    required this.title,
    required this.serviceCode,
  });

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final state = ref.watch(transactionProvider);
    
    final authState = ref.watch(authProvider);
    final agentId = authState.user?.agentId ?? 'AGENT_UNKNOWN';
    final amountText = ref.watch(transactionAmountProvider);
    final selectedSource = ref.watch(fundingSourceProvider);
    final isCustomerView = ref.watch(isCustomerViewProvider);
    
    // Auto-update funding source if it's the first build (or if current source is not allowed)
    if (state.status == TransactionStatus.idle) {
      final allowed = FundingSource.allowedFor(serviceCode);
      if (!allowed.contains(selectedSource)) {
        WidgetsBinding.instance.addPostFrameCallback((_) {
          ref.read(fundingSourceProvider.notifier).state = allowed.first;
        });
      }
    }

    return Scaffold(
      backgroundColor: const Color(0xFFF8F9FA),
      appBar: AppBar(
        title: Text(title, style: const TextStyle(fontWeight: FontWeight.bold, fontSize: 18)),
        backgroundColor: Colors.white,
        elevation: 0,
        centerTitle: true,
        actions: const [OfflineIndicator()],
      ),
      body: SingleChildScrollView(
        child: Padding(
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
                      _buildStateView(context, ref, state, agentId, amountText, selectedSource, isCustomerView),
                      // Hidden state for BDD tests to verify
                      Opacity(
                        opacity: 0.0,
                        child: Text(
                          'Status: ${state.status.name}${state.error != null ? " Error: ${state.error}" : ""}', 
                          key: const Key('bdd_status_token')
                        ),
                      ),
                    ],
                  ),
                ),
              ),
            ),
          ),
        ),
      ),
    );
  }

  Widget _buildStateView(BuildContext context, WidgetRef ref, TransactionState state, String agentId, String amountText, FundingSource selectedSource, bool isCustomerView) {
    final currencyFormat = NumberFormat.currency(symbol: 'RM ', decimalDigits: 2);

    switch (state.status) {
      case TransactionStatus.idle:
        return Column(
          children: [
            const SizedBox(height: 16),
            FundingSourceSelector(
              key: const Key('funding_selector'),
              selectedSource: selectedSource,
              availableSources: FundingSource.allowedFor(serviceCode),
              onSourceChanged: (source) {
                ref.read(fundingSourceProvider.notifier).state = source;
              },
            ),
            const SizedBox(height: 24),
            _buildServiceSpecificInput(context, ref, agentId, amountText, selectedSource),
            if (!['BILL_PAYMENT', 'JOMPAY', 'PREPAID_TOPUP', 'SARAWAK_PAY', 'CASHLESS_PAYMENT', 'ESSP_PURCHASE', 'PIN_PURCHASE'].contains(serviceCode)) ...[
              const SizedBox(height: 32),
              _buildSharedAction(context, ref, state, agentId, amountText, selectedSource),
            ],
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
              _buildSummaryRow('Amount', currencyFormat.format(state.quote?.amount.toDouble() ?? 0)),
              if (state.metadata?['customerName'] != null) ...[
                const Divider(height: 24),
                _buildSummaryRow('Recipient', state.metadata!['customerName']!),
              ],
              const Divider(height: 24),
              _buildSummaryRow('Transaction Fee', currencyFormat.format(state.quote?.fee.toDouble() ?? 0)),
              const Divider(height: 24),
              _buildSummaryRow('Total to Deduct', currencyFormat.format(state.quote?.total.toDouble() ?? 0), isBold: true),
              const SizedBox(height: 32),
              if (selectedSource == FundingSource.CASH) 
                Container(
                  padding: const EdgeInsets.all(16),
                  margin: const EdgeInsets.only(bottom: 24),
                  decoration: BoxDecoration(color: Colors.green.shade50, borderRadius: BorderRadius.circular(12), border: Border.all(color: Colors.green.shade100)),
                  child: const Row(
                    children: [
                      Icon(Icons.monetization_on, color: Colors.green),
                      SizedBox(width: 12),
                      Expanded(child: Text('Confirm Cash Received from Customer', style: TextStyle(color: Colors.green, fontWeight: FontWeight.bold))),
                    ],
                  ),
                ),
              
              if (!isCustomerView && state.quote?.commission != null)
                Container(
                  padding: const EdgeInsets.symmetric(vertical: 12, horizontal: 16),
                  margin: const EdgeInsets.only(top: 16),
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
                        'RM ${state.quote?.commission.toDouble().toStringAsFixed(2) ?? "0.00"}',
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
                    child: const Text('AGREE'),
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
            Text('Insert Customer Card', key: Key('status_waiting_card'), style: TextStyle(fontWeight: FontWeight.bold, fontSize: 18)),
            SizedBox(height: 8),
            Text('Please use the attached card reader', style: TextStyle(color: Colors.grey, fontSize: 13)),
          ],
        );
      case TransactionStatus.waitingPin:
        return const Column(
          children: [
            Icon(Icons.pin_outlined, size: 80, color: Colors.indigo),
            SizedBox(height: 24),
            Text('Enter Secure PIN', key: Key('status_waiting_pin'), style: TextStyle(fontWeight: FontWeight.bold, fontSize: 18)),
            SizedBox(height: 8),
            Text('Customer should enter PIN on the PinPad', style: TextStyle(color: Colors.grey, fontSize: 13)),
          ],
        );
      case TransactionStatus.waitingMyKadScan:
        return Column(
          children: [
            Icon(Icons.fingerprint, size: 80, color: Colors.indigo),
            SizedBox(height: 24),
            Text('Please Scan MyKad & Thumb', key: Key('status_waiting_mykad_scan'), style: TextStyle(fontWeight: FontWeight.bold, fontSize: 18)),
            SizedBox(height: 8),
            Text('Insert MyKad into mobile reader and verify thumbprint', style: TextStyle(color: Colors.grey, fontSize: 13)),
            const SizedBox(height: 32),
            SizedBox(
              width: double.infinity,
              height: 56,
              child: ElevatedButton(
                key: const Key('btn_main_action'),
                onPressed: () => ref.read(transactionProvider.notifier).completeMyKadScan(),
                child: const Text('SUBMIT TRANSACTION'),
              ),
            ),
          ],
        );
      case TransactionStatus.processingDuitNow:
      case TransactionStatus.processingBiller:
        return Center(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              const CircularProgressIndicator(),
              const SizedBox(height: 24),
              Text(
                ref.read(transactionProvider.notifier).getPollingStatusLabel(), 
                key: const Key('status_processing_biller'),
                style: const TextStyle(fontSize: 18, fontWeight: FontWeight.bold)
              ),
              const SizedBox(height: 8),
              const Text(
                'Checking transaction status with provider',
                style: TextStyle(color: Colors.grey, fontSize: 13)
              ),
            ],
          ),
        );
      case TransactionStatus.displayingQr:
        return Column(
          children: [
            const Icon(Icons.qr_code_scanner, size: 80, color: Colors.indigo),
            const SizedBox(height: 24),
            const Text('Scan to Pay', key: Key('status_displaying_qr'), style: TextStyle(fontWeight: FontWeight.bold, fontSize: 18)),
            SizedBox(height: 8),
            const Text('Customer should scan this QR with their DuitNow app', style: TextStyle(color: Colors.grey, fontSize: 13)),
            const SizedBox(height: 32),
            Container(
              padding: const EdgeInsets.all(16),
              decoration: BoxDecoration(
                color: Colors.white,
                borderRadius: BorderRadius.circular(24),
                border: Border.all(color: Colors.grey.shade200, width: 2),
                boxShadow: [
                  BoxShadow(color: Colors.black.withValues(alpha: 0.05), blurRadius: 10, offset: const Offset(0, 4)),
                ],
              ),
              child: Column(
                children: [
                  // Simulated QR Payload Display
                  Container(
                    width: 200,
                    height: 200,
                    decoration: BoxDecoration(
                      color: Colors.grey.shade100,
                      borderRadius: BorderRadius.circular(12),
                    ),
                    child: const Icon(Icons.qr_code_2, size: 150, color: Colors.black87),
                  ),
                  const SizedBox(height: 16),
                  Text(
                    'Ref: ${state.result?.referenceId}',
                    style: const TextStyle(fontSize: 10, color: Colors.grey, fontWeight: FontWeight.bold),
                  ),
                ],
              ),
            ),
            const SizedBox(height: 48),
            const CircularProgressIndicator(),
            const SizedBox(height: 16),
            const Text('Waiting for Payment Notification...', style: TextStyle(fontSize: 12, color: Colors.blue, fontWeight: FontWeight.w500)),
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
                  _buildSummaryRow('Service', state.serviceCode ?? 'N/A', small: true),
                  if (state.quote?.commission != null && !isCustomerView) ...[
                    const Divider(height: 16),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        const Text('AGENT COMMISSION', style: TextStyle(fontSize: 10, fontWeight: FontWeight.bold, color: Colors.blue)),
                        Text('RM ${state.quote!.commission.toDouble().toStringAsFixed(2)}', style: const TextStyle(fontSize: 12, fontWeight: FontWeight.bold, color: Colors.blue)),
                      ],
                    ),
                  ],
                  if (state.quote != null) ...[
                    _buildSummaryRow('Commission', 'RM ${state.quote!.commission.toStringAsFixed(2)}', isBold: true, small: true),
                  ],
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
            const SizedBox(height: 12),
            Text(
              state.error ?? 'An unexpected error occurred',
              textAlign: TextAlign.center,
              style: const TextStyle(color: Colors.grey, fontSize: 13),
            ),
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
    if (serviceCode == 'BILL_PAYMENT') {
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
    } else if (serviceCode == 'JOMPAY') {
      return JomPayForm(
        onSubmit: (req) {
          ref.read(transactionProvider.notifier).jomPay(
            req.billerCode,
            req.ref1,
            req.ref2,
            Decimal.parse(req.amount.toString()),
            agentId,
          );
        },
      );
    } else if (serviceCode == 'PREPAID_TOPUP') {
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
    } else if (serviceCode == 'CASHLESS_PAYMENT') {
      return CashlessPaymentForm(
        onSubmit: (_, amount) {
          final source = ref.read(fundingSourceProvider);
          final method = source == FundingSource.DUITNOW_QR ? 'QR_CODE' : 'DEBIT_CARD';
          
          ref.read(transactionProvider.notifier).startTransaction(
            amount, 
            agentId, 
            serviceCode: serviceCode,
            fundingSource: source,
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
            color: Theme.of(context).colorScheme.primary.withValues(alpha: 0.1),
            shape: BoxShape.circle,
          ),
          child: Icon(
            needsAmount ? Icons.payments_outlined : Icons.account_balance_wallet_outlined,
            size: 32,
            color: Theme.of(context).colorScheme.primary,
          ),
        ),
        const SizedBox(height: 24),
        if (serviceCode == 'CASH_DEPOSIT' || serviceCode == 'DUITNOW_TRANSFER') ...[
          const Text('Identifier Type', style: TextStyle(fontWeight: FontWeight.bold, fontSize: 16)),
          const SizedBox(height: 12),
          Wrap(
            spacing: 8,
            runSpacing: 8,
            children: [
              ChoiceChip(
                label: const Text('Account Number'),
                selected: ref.watch(proxyTypeProvider) == 'ACCOUNT',
                onSelected: (selected) {
                  if (selected) {
                    ref.read(proxyTypeProvider.notifier).state = 'ACCOUNT';
                    ref.read(transactionMetadataProvider.notifier).state = {
                      ...ref.read(transactionMetadataProvider),
                      'proxyType': 'ACCOUNT',
                    };
                  }
                },
              ),
              ChoiceChip(
                label: const Text('Mobile (DuitNow)'),
                selected: ref.watch(proxyTypeProvider) == 'MOBILE',
                onSelected: (selected) {
                  if (selected) {
                    ref.read(proxyTypeProvider.notifier).state = 'MOBILE';
                    ref.read(transactionMetadataProvider.notifier).state = {
                      ...ref.read(transactionMetadataProvider),
                      'proxyType': 'MOBILE',
                    };
                  }
                },
              ),
            ],
          ),
          const SizedBox(height: 24),
          Text(serviceCode == 'DUITNOW_TRANSFER' ? 'DuitNow Proxy' : 'Destination Account', style: const TextStyle(fontWeight: FontWeight.bold, fontSize: 16)),
          const SizedBox(height: 12),
          TextField(
            key: Key(serviceCode == 'DUITNOW_TRANSFER' ? 'field_duitnow_proxy' : 'field_destination_account'),
            onChanged: (v) {
              ref.read(transactionMetadataProvider.notifier).state = {...ref.read(transactionMetadataProvider), 'destinationAccount': v};
            },
            decoration: InputDecoration(
              hintText: 'Enter Account Number',
              filled: true,
              fillColor: Colors.grey.shade50,
              border: OutlineInputBorder(borderRadius: BorderRadius.circular(12), borderSide: BorderSide.none),
            ),
          ),
          const SizedBox(height: 24),
        ],
        if (needsAmount) ...[
          const Text('Enter Amount', style: TextStyle(fontWeight: FontWeight.bold, fontSize: 16)),
          const Text('Enter amount to continue', style: TextStyle(color: Colors.grey, fontSize: 12)),
          const SizedBox(height: 32),
          TextField(
            key: const Key('field_amount'),
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
        ],
        // NRIC for MyKad Withdrawal
        if (serviceCode == 'CASH_WITHDRAWAL' && selectedSource == FundingSource.MYKAD_BIOMETRIC) ...[
           const Text('NRIC Number', style: TextStyle(fontWeight: FontWeight.bold, fontSize: 16)),
           const SizedBox(height: 12),
           TextField(
             key: const Key('nric'),
             onChanged: (v) {
               ref.read(transactionMetadataProvider.notifier).state = {
                 ...ref.read(transactionMetadataProvider),
                 'nric': v,
               };
             },
             decoration: InputDecoration(
               hintText: 'e.g. 850101-01-5678',
               filled: true,
               fillColor: Colors.grey.shade50,
               border: OutlineInputBorder(borderRadius: BorderRadius.circular(12), borderSide: BorderSide.none),
             ),
           ),
           const SizedBox(height: 24),
        ],
          const Column(
            children: [
              Text('Balance Inquiry', style: TextStyle(fontWeight: FontWeight.bold, fontSize: 18)),
              SizedBox(height: 8),
              Text('Check customer account balance securely', textAlign: TextAlign.center, style: TextStyle(color: Colors.grey, fontSize: 13)),
              SizedBox(height: 32),
            ],
          ),
          
      ],
    );
  }

  Widget _buildSharedAction(BuildContext context, WidgetRef ref, TransactionState state, String agentId, String amountText, FundingSource selectedSource) {
    return SizedBox(
      width: double.infinity,
      height: 56,
      child: ElevatedButton(
        onPressed: () {
                final amount = Decimal.tryParse(amountText) ?? Decimal.zero;
          if (amount <= Decimal.zero && serviceCode != 'BALANCE_INQUIRY') {
            ScaffoldMessenger.of(context).showSnackBar(const SnackBar(content: Text('Please enter a valid amount')));
            return;
          }
          final metadata = ref.read(transactionMetadataProvider);
          if (state.status == TransactionStatus.waitingConsent) {
            ref.read(transactionProvider.notifier).confirmConsent();
          } else if (serviceCode == 'BALANCE_INQUIRY') {
            ref.read(transactionProvider.notifier).balanceInquiry(agentId);
          } else {
            ref.read(transactionProvider.notifier).startTransaction(
              amount, 
              agentId, 
              serviceCode: serviceCode,
              fundingSource: selectedSource,
              metadata: metadata,
            );
          }
        },
        key: const Key('btn_main_action'),
        child: Text(
          serviceCode == 'BALANCE_INQUIRY' ? 'PROCEED' : 
          (state.status == TransactionStatus.waitingConsent) ? (selectedSource == FundingSource.CASH ? 'CONFIRM CASH' : 'AGREE & PROCEED') : 'GET QUOTE'
        ),
      ),
    );
  }

  Widget _buildSummaryRow(String label, String value, {bool isBold = false, Color? color, bool small = false}) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Expanded(
          flex: 2,
          child: Text(
            label, 
            style: TextStyle(color: Colors.grey, fontSize: small ? 11 : 14),
            overflow: TextOverflow.ellipsis,
          ),
        ),
        const SizedBox(width: 8),
        Flexible(
          flex: 3,
          child: Text(
            value, 
            textAlign: TextAlign.right,
            style: TextStyle(
              fontWeight: isBold ? FontWeight.bold : FontWeight.w600,
              fontSize: small ? 11 : (isBold ? 18 : 14),
              color: color,
            ),
          ),
        ),
      ],
    );
  }
}
