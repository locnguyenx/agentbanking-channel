import 'package:flutter/material.dart';
import 'package:agentbanking_channel/features/transactions/models/transaction_models.dart';

class FundingSourceSelector extends StatelessWidget {
  final FundingSource selectedSource;
  final Function(FundingSource) onSourceChanged;
  final List<FundingSource> availableSources;

  const FundingSourceSelector({
    Key? key,
    required this.selectedSource,
    required this.onSourceChanged,
    this.availableSources = FundingSource.values,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        const Text(
          'SELECT FUNDING SOURCE',
          style: TextStyle(
            fontSize: 10,
            fontWeight: FontWeight.bold,
            color: Colors.grey,
            letterSpacing: 1.2,
          ),
        ),
        const SizedBox(height: 12),
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: availableSources.map((source) {
            final isSelected = source == selectedSource;
            return Expanded(
              child: GestureDetector(
                key: Key('funding_source_${source.name}'),
                onTap: () => onSourceChanged(source),
                child: Container(
                  margin: const EdgeInsets.symmetric(horizontal: 4),
                  padding: const EdgeInsets.symmetric(vertical: 12),
                  decoration: BoxDecoration(
                    color: isSelected ? Colors.indigo.shade50 : Colors.white,
                    borderRadius: BorderRadius.circular(12),
                    border: Border.all(
                      color: isSelected ? Colors.indigo : Colors.grey.shade200,
                      width: isSelected ? 2 : 1,
                    ),
                  ),
                  child: Column(
                    children: [
                      Icon(
                        _getIcon(source),
                        color: isSelected ? Colors.indigo : Colors.grey,
                        size: 20,
                      ),
                      const SizedBox(height: 4),
                      Text(
                        _getLabel(source),
                        style: TextStyle(
                          fontSize: 10,
                          fontWeight: FontWeight.bold,
                          color: isSelected ? Colors.indigo : Colors.grey,
                        ),
                      ),
                    ],
                  ),
                ),
              ),
            );
          }).toList(),
        ),
      ],
    );
  }

  IconData _getIcon(FundingSource source) {
    switch (source) {
      case FundingSource.CASH:
        return Icons.money;
      case FundingSource.CARD_EMV:
        return Icons.credit_card;
      case FundingSource.DUITNOW_MOBILE:
      case FundingSource.DUITNOW_MYKAD:
      case FundingSource.DUITNOW_BRN:
        return Icons.qr_code;
      case FundingSource.MYKAD_BIOMETRIC:
        return Icons.fingerprint;
    }
  }

  String _getLabel(FundingSource source) {
    switch (source) {
      case FundingSource.CASH:
        return 'CASH';
      case FundingSource.CARD_EMV:
        return 'CARD';
      case FundingSource.DUITNOW_MOBILE:
        return 'DUITNOW (TEL)';
      case FundingSource.DUITNOW_MYKAD:
        return 'DUITNOW (IC)';
      case FundingSource.DUITNOW_BRN:
        return 'DUITNOW (BRN)';
      case FundingSource.MYKAD_BIOMETRIC:
        return 'MYKAD';
    }
  }
}
