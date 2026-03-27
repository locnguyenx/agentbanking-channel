import 'package:decimal/decimal.dart';

class FloatLedger {
  final Decimal currentBalance;
  final Decimal limit;
  final List<FloatEntry> entries;

  FloatLedger({
    required this.currentBalance,
    required this.limit,
    this.entries = const [],
  });

  FloatLedger copyWith({
    Decimal? currentBalance,
    Decimal? limit,
    List<FloatEntry>? entries,
  }) {
    return FloatLedger(
      currentBalance: currentBalance ?? this.currentBalance,
      limit: limit ?? this.limit,
      entries: entries ?? this.entries,
    );
  }
}

class FloatEntry {
  final String id;
  final String transactionId;
  final Decimal amount;
  final FloatEntryType type;
  final DateTime timestamp;

  FloatEntry({
    required this.id,
    required this.transactionId,
    required this.amount,
    required this.type,
    required this.timestamp,
  });
}

enum FloatEntryType { DEBIT, CREDIT }
