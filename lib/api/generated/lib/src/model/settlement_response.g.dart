// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'settlement_response.dart';

// **************************************************************************
// BuiltValueGenerator
// **************************************************************************

class _$SettlementResponse extends SettlementResponse {
  @override
  final BuiltList<BuiltMap<String, JsonObject?>>? transactions;
  @override
  final num? totalDebits;
  @override
  final num? totalCredits;
  @override
  final num? totalCommissions;
  @override
  final num? netAmount;
  @override
  final Date? date;

  factory _$SettlementResponse(
          [void Function(SettlementResponseBuilder)? updates]) =>
      (SettlementResponseBuilder()..update(updates))._build();

  _$SettlementResponse._(
      {this.transactions,
      this.totalDebits,
      this.totalCredits,
      this.totalCommissions,
      this.netAmount,
      this.date})
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
        transactions == other.transactions &&
        totalDebits == other.totalDebits &&
        totalCredits == other.totalCredits &&
        totalCommissions == other.totalCommissions &&
        netAmount == other.netAmount &&
        date == other.date;
  }

  @override
  int get hashCode {
    var _$hash = 0;
    _$hash = $jc(_$hash, transactions.hashCode);
    _$hash = $jc(_$hash, totalDebits.hashCode);
    _$hash = $jc(_$hash, totalCredits.hashCode);
    _$hash = $jc(_$hash, totalCommissions.hashCode);
    _$hash = $jc(_$hash, netAmount.hashCode);
    _$hash = $jc(_$hash, date.hashCode);
    _$hash = $jf(_$hash);
    return _$hash;
  }

  @override
  String toString() {
    return (newBuiltValueToStringHelper(r'SettlementResponse')
          ..add('transactions', transactions)
          ..add('totalDebits', totalDebits)
          ..add('totalCredits', totalCredits)
          ..add('totalCommissions', totalCommissions)
          ..add('netAmount', netAmount)
          ..add('date', date))
        .toString();
  }
}

class SettlementResponseBuilder
    implements Builder<SettlementResponse, SettlementResponseBuilder> {
  _$SettlementResponse? _$v;

  ListBuilder<BuiltMap<String, JsonObject?>>? _transactions;
  ListBuilder<BuiltMap<String, JsonObject?>> get transactions =>
      _$this._transactions ??= ListBuilder<BuiltMap<String, JsonObject?>>();
  set transactions(ListBuilder<BuiltMap<String, JsonObject?>>? transactions) =>
      _$this._transactions = transactions;

  num? _totalDebits;
  num? get totalDebits => _$this._totalDebits;
  set totalDebits(num? totalDebits) => _$this._totalDebits = totalDebits;

  num? _totalCredits;
  num? get totalCredits => _$this._totalCredits;
  set totalCredits(num? totalCredits) => _$this._totalCredits = totalCredits;

  num? _totalCommissions;
  num? get totalCommissions => _$this._totalCommissions;
  set totalCommissions(num? totalCommissions) =>
      _$this._totalCommissions = totalCommissions;

  num? _netAmount;
  num? get netAmount => _$this._netAmount;
  set netAmount(num? netAmount) => _$this._netAmount = netAmount;

  Date? _date;
  Date? get date => _$this._date;
  set date(Date? date) => _$this._date = date;

  SettlementResponseBuilder() {
    SettlementResponse._defaults(this);
  }

  SettlementResponseBuilder get _$this {
    final $v = _$v;
    if ($v != null) {
      _transactions = $v.transactions?.toBuilder();
      _totalDebits = $v.totalDebits;
      _totalCredits = $v.totalCredits;
      _totalCommissions = $v.totalCommissions;
      _netAmount = $v.netAmount;
      _date = $v.date;
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
    _$SettlementResponse _$result;
    try {
      _$result = _$v ??
          _$SettlementResponse._(
            transactions: _transactions?.build(),
            totalDebits: totalDebits,
            totalCredits: totalCredits,
            totalCommissions: totalCommissions,
            netAmount: netAmount,
            date: date,
          );
    } catch (_) {
      late String _$failedField;
      try {
        _$failedField = 'transactions';
        _transactions?.build();
      } catch (e) {
        throw BuiltValueNestedFieldError(
            r'SettlementResponse', _$failedField, e.toString());
      }
      rethrow;
    }
    replace(_$result);
    return _$result;
  }
}

// ignore_for_file: deprecated_member_use_from_same_package,type=lint
