import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:agentbanking_channel/features/transactions/providers/transaction_provider.dart';
import 'package:agentbanking_channel/features/transactions/models/transaction_models.dart';

class DuitNowTransferScreen extends ConsumerStatefulWidget {
  const DuitNowTransferScreen({super.key});

  @override
  ConsumerState<DuitNowTransferScreen> createState() => _DuitNowTransferScreenState();
}

class _DuitNowTransferScreenState extends ConsumerState<DuitNowTransferScreen> {
  FundingSource _selectedSource = FundingSource.DUITNOW_MOBILE;
  final _proxyController = TextEditingController();
  String? _errorText;

  @override
  void dispose() {
    _proxyController.dispose();
    super.dispose();
  }

  void _validate(String value) {
    setState(() {
      if (value.isEmpty) {
        _errorText = null; // No error if empty, just disabled button
        return;
      }
      
      switch (_selectedSource) {
        case FundingSource.DUITNOW_MOBILE:
          if (!RegExp(r'^01[0-9]{8,10}$').hasMatch(value)) {
            _errorText = 'Invalid Mobile Number (e.g. 0123456789)';
          } else {
            _errorText = null;
          }
          break;
        case FundingSource.DUITNOW_MYKAD:
          if (!RegExp(r'^[0-9]{12}$').hasMatch(value)) {
            _errorText = 'Invalid MyKad (12 digits)';
          } else {
            _errorText = null;
          }
          break;
        case FundingSource.DUITNOW_BRN:
          if (value.length < 5) {
            _errorText = 'Invalid BRN (min 5 chars)';
          } else {
            _errorText = null;
          }
          break;
        default:
          _errorText = null;
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    final state = ref.watch(transactionProvider);

    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
        title: const Text('DuitNow Transfer', style: TextStyle(fontWeight: FontWeight.bold)),
        backgroundColor: Colors.white,
        elevation: 0,
        foregroundColor: Colors.black,
      ),
      body: Padding(
        padding: const EdgeInsets.all(24.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            const Text(
              'Select Proxy Type',
              style: TextStyle(fontWeight: FontWeight.bold, fontSize: 16),
            ),
            const SizedBox(height: 16),
            _buildProxySelector(),
            const SizedBox(height: 32),
            const Text(
              'Proxy ID',
              style: TextStyle(fontWeight: FontWeight.bold, fontSize: 16),
            ),
            const SizedBox(height: 12),
            TextField(
              controller: _proxyController,
              onChanged: _validate,
              keyboardType: _selectedSource == FundingSource.DUITNOW_BRN 
                ? TextInputType.text 
                : TextInputType.number,
              decoration: InputDecoration(
                hintText: _getProxyHint(),
                errorText: _errorText,
                prefixIcon: const Icon(Icons.perm_identity),
                filled: true,
                fillColor: Colors.grey.shade50,
                border: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(12),
                  borderSide: BorderSide(color: Colors.grey.shade200),
                ),
                enabledBorder: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(12),
                  borderSide: BorderSide(color: Colors.grey.shade200),
                ),
              ),
            ),
            const Spacer(),
            _buildActionArea(state),
          ],
        ),
      ),
    );
  }

  Widget _buildProxySelector() {
    return SingleChildScrollView(
      scrollDirection: Axis.horizontal,
      child: Row(
        children: [
          _proxyOption('Mobile Number', FundingSource.DUITNOW_MOBILE),
          const SizedBox(width: 8),
          _proxyOption('NRIC / MyKad', FundingSource.DUITNOW_MYKAD),
          const SizedBox(width: 8),
          _proxyOption('BRN', FundingSource.DUITNOW_BRN),
        ],
      ),
    );
  }

  Widget _proxyOption(String label, FundingSource source) {
    final isSelected = _selectedSource == source;
    return ChoiceChip(
      key: Key('funding_source_${source.name}'),
      label: Text(label),
      selected: isSelected,
      onSelected: (val) {
        if (val) {
          setState(() {
            _selectedSource = source;
            _validate(_proxyController.text);
          });
        }
      },
      selectedColor: Theme.of(context).primaryColor,
      labelStyle: TextStyle(
        color: isSelected ? Colors.white : Colors.black,
        fontWeight: isSelected ? FontWeight.bold : FontWeight.normal,
      ),
    );
  }

  String _getProxyHint() {
    switch (_selectedSource) {
      case FundingSource.DUITNOW_MOBILE: return 'e.g. 0123456789';
      case FundingSource.DUITNOW_MYKAD: return 'e.g. 900101015566';
      case FundingSource.DUITNOW_BRN:   return 'e.g. 1234567-X';
      default: return 'Enter Proxy ID';
    }
  }

  Widget _buildActionArea(TransactionState state) {
    if (state.status == TransactionStatus.processingDuitNow) {
      return Container(
        padding: const EdgeInsets.all(24),
        decoration: BoxDecoration(
          color: Colors.blue.shade50,
          borderRadius: BorderRadius.circular(16),
          border: Border.all(color: Colors.blue.shade100),
        ),
        child: const Column(
          children: [
            CircularProgressIndicator(),
            SizedBox(height: 16),
            Text(
              'Awaiting Confirmation',
              style: TextStyle(fontWeight: FontWeight.bold, fontSize: 16),
            ),
            SizedBox(height: 8),
            Text(
              'Customer must approve the Request for Payment in their bank app.',
              textAlign: TextAlign.center,
              style: TextStyle(fontSize: 13, color: Colors.blueGrey),
            ),
          ],
        ),
      );
    }

    final bool canConfirm = _errorText == null && _proxyController.text.isNotEmpty && state.status != TransactionStatus.processing;

    return SizedBox(
      width: double.infinity,
      height: 56,
      child: ElevatedButton(
        onPressed: canConfirm
            ? () => ref.read(transactionProvider.notifier).confirmConsent(
                  duitNowProxyId: _proxyController.text,
                )
            : null,
        style: ElevatedButton.styleFrom(
          shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(16)),
        ),
        child: state.status == TransactionStatus.processing
            ? const SizedBox(height: 20, width: 20, child: CircularProgressIndicator(strokeWidth: 2, color: Colors.white))
            : const Text('Confirm', style: TextStyle(fontWeight: FontWeight.bold, fontSize: 16)),
      ),
    );
  }
}
