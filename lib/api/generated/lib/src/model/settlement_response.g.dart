// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'settlement_response.dart';

// **************************************************************************
// BuiltValueGenerator
// **************************************************************************

class _$SettlementResponse extends SettlementResponse {
  @override
  final String? settlementId;
  @override
  final String? agentId;
  @override
  final Date? date;
  @override
  final int? totalTransactions;
  @override
  final String? totalAmount;
  @override
  final String? commission;
  @override
  final String? status;

  factory _$SettlementResponse(
          [void Function(SettlementResponseBuilder)? updates]) =>
      (SettlementResponseBuilder()..update(updates))._build();

  _$SettlementResponse._(
      {this.settlementId,
      this.agentId,
      this.date,
      this.totalTransactions,
      this.totalAmount,
      this.commission,
      this.status})
      : super._();
  @override
  SettlementResponse rebuild(
          void Function(SettlementResponseBuilder) updates) =>
      (toBuilder()..update(updates)).build();

  @override
  SettlementResponseBuilder toBuilder() =>
      SettlementResponseBuilder()..replace(this);

  @override
  bool operator ==(Object other) {
    if (identical(other, this)) return true;
    return other is SettlementResponse &&
        settlementId == other.settlementId &&
        agentId == other.agentId &&
        date == other.date &&
        totalTransactions == other.totalTransactions &&
        totalAmount == other.totalAmount &&
        commission == other.commission &&
        status == other.status;
  }

  @override
  int get hashCode {
    var _$hash = 0;
    _$hash = $jc(_$hash, settlementId.hashCode);
    _$hash = $jc(_$hash, agentId.hashCode);
    _$hash = $jc(_$hash, date.hashCode);
    _$hash = $jc(_$hash, totalTransactions.hashCode);
    _$hash = $jc(_$hash, totalAmount.hashCode);
    _$hash = $jc(_$hash, commission.hashCode);
    _$hash = $jc(_$hash, status.hashCode);
    _$hash = $jf(_$hash);
    return _$hash;
  }

  @override
  String toString() {
    return (newBuiltValueToStringHelper(r'SettlementResponse')
          ..add('settlementId', settlementId)
          ..add('agentId', agentId)
          ..add('date', date)
          ..add('totalTransactions', totalTransactions)
          ..add('totalAmount', totalAmount)
          ..add('commission', commission)
          ..add('status', status))
        .toString();
  }
}

class SettlementResponseBuilder
    implements Builder<SettlementResponse, SettlementResponseBuilder> {
  _$SettlementResponse? _$v;

  String? _settlementId;
  String? get settlementId => _$this._settlementId;
  set settlementId(String? settlementId) => _$this._settlementId = settlementId;

  String? _agentId;
  String? get agentId => _$this._agentId;
  set agentId(String? agentId) => _$this._agentId = agentId;

  Date? _date;
  Date? get date => _$this._date;
  set date(Date? date) => _$this._date = date;

  int? _totalTransactions;
  int? get totalTransactions => _$this._totalTransactions;
  set totalTransactions(int? totalTransactions) =>
      _$this._totalTransactions = totalTransactions;

  String? _totalAmount;
  String? get totalAmount => _$this._totalAmount;
  set totalAmount(String? totalAmount) => _$this._totalAmount = totalAmount;

  String? _commission;
  String? get commission => _$this._commission;
  set commission(String? commission) => _$this._commission = commission;

  String? _status;
  String? get status => _$this._status;
  set status(String? status) => _$this._status = status;

  SettlementResponseBuilder() {
    SettlementResponse._defaults(this);
  }

  SettlementResponseBuilder get _$this {
    final $v = _$v;
    if ($v != null) {
      _settlementId = $v.settlementId;
      _agentId = $v.agentId;
      _date = $v.date;
      _totalTransactions = $v.totalTransactions;
      _totalAmount = $v.totalAmount;
      _commission = $v.commission;
      _status = $v.status;
      _$v = null;
    }
    return this;
  }

  @override
  void replace(SettlementResponse other) {
    _$v = other as _$SettlementResponse;
  }

  @override
  void update(void Function(SettlementResponseBuilder)? updates) {
    if (updates != null) updates(this);
  }

  @override
  SettlementResponse build() => _build();

  _$SettlementResponse _build() {
    final _$result = _$v ??
        _$SettlementResponse._(
          settlementId: settlementId,
          agentId: agentId,
          date: date,
          totalTransactions: totalTransactions,
          totalAmount: totalAmount,
          commission: commission,
          status: status,
        );
    replace(_$result);
    return _$result;
  }
}

// ignore_for_file: deprecated_member_use_from_same_package,type=lint
