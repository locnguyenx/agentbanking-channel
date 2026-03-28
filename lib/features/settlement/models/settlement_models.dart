import 'package:decimal/decimal.dart';

class ServiceTotal {
  final String serviceName;
  final int count;
  final Decimal totalAmount;
  final Decimal totalCommission;

  ServiceTotal({
    required this.serviceName,
    required this.count,
    required this.totalAmount,
    required this.totalCommission,
  });
}

class SettlementSummary {
  final List<ServiceTotal> services;
  final Decimal netVolume;
  final Decimal totalCommission;
  final String terminalId;
  final DateTime timestamp;

  SettlementSummary({
    required this.services,
    required this.netVolume,
    required this.totalCommission,
    required this.terminalId,
    required this.timestamp,
  });

  Decimal get grandTotal => netVolume;
}

class SettlementClosureResponse {
  final bool success;
  final String batchNumber;
  final String reference;

  SettlementClosureResponse({
    required this.success, 
    required this.batchNumber, 
    required this.reference
  });
}
