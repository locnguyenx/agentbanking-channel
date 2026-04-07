// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'balance_response.dart';

// **************************************************************************
// BuiltValueGenerator
// **************************************************************************

class _$BalanceResponse extends BalanceResponse {
  @override
  final String? agentId;
  @override
  final String? availableBalance;
  @override
  final String? ledgerBalance;
  @override
  final String? pendingBalance;
  @override
  final String? currency;
  @override
  final String? lastTransactionId;
  @override
  final DateTime? lastUpdated;

  factory _$BalanceResponse([void Function(BalanceResponseBuilder)? updates]) =>
      (BalanceResponseBuilder()..update(updates))._build();

  _$BalanceResponse._(
      {this.agentId,
      this.availableBalance,
      this.ledgerBalance,
      this.pendingBalance,
      this.currency,
      this.lastTransactionId,
      this.lastUpdated})
      : super._();
  @override
  BalanceResponse rebuild(void Function(BalanceResponseBuilder) updates) =>
      (toBuilder()..update(updates)).build();

  @override
  BalanceResponseBuilder toBuilder() => BalanceResponseBuilder()..replace(this);

  @override
  bool operator ==(Object other) {
    if (identical(other, this)) return true;
    return other is BalanceResponse &&
        agentId == other.agentId &&
        availableBalance == other.availableBalance &&
        ledgerBalance == other.ledgerBalance &&
        pendingBalance == other.pendingBalance &&
        currency == other.currency &&
        lastTransactionId == other.lastTransactionId &&
        lastUpdated == other.lastUpdated;
  }

  @override
  int get hashCode {
    var _$hash = 0;
    _$hash = $jc(_$hash, agentId.hashCode);
    _$hash = $jc(_$hash, availableBalance.hashCode);
    _$hash = $jc(_$hash, ledgerBalance.hashCode);
    _$hash = $jc(_$hash, pendingBalance.hashCode);
    _$hash = $jc(_$hash, currency.hashCode);
    _$hash = $jc(_$hash, lastTransactionId.hashCode);
    _$hash = $jc(_$hash, lastUpdated.hashCode);
    _$hash = $jf(_$hash);
    return _$hash;
  }

  @override
  String toString() {
    return (newBuiltValueToStringHelper(r'BalanceResponse')
          ..add('agentId', agentId)
          ..add('availableBalance', availableBalance)
          ..add('ledgerBalance', ledgerBalance)
          ..add('pendingBalance', pendingBalance)
          ..add('currency', currency)
          ..add('lastTransactionId', lastTransactionId)
          ..add('lastUpdated', lastUpdated))
        .toString();
  }
}

class BalanceResponseBuilder
    implements Builder<BalanceResponse, BalanceResponseBuilder> {
  _$BalanceResponse? _$v;

  String? _agentId;
  String? get agentId => _$this._agentId;
  set agentId(String? agentId) => _$this._agentId = agentId;

  String? _availableBalance;
  String? get availableBalance => _$this._availableBalance;
  set availableBalance(String? availableBalance) =>
      _$this._availableBalance = availableBalance;

  String? _ledgerBalance;
  String? get ledgerBalance => _$this._ledgerBalance;
  set ledgerBalance(String? ledgerBalance) =>
      _$this._ledgerBalance = ledgerBalance;

  String? _pendingBalance;
  String? get pendingBalance => _$this._pendingBalance;
  set pendingBalance(String? pendingBalance) =>
      _$this._pendingBalance = pendingBalance;

  String? _currency;
  String? get currency => _$this._currency;
  set currency(String? currency) => _$this._currency = currency;

  String? _lastTransactionId;
  String? get lastTransactionId => _$this._lastTransactionId;
  set lastTransactionId(String? lastTransactionId) =>
      _$this._lastTransactionId = lastTransactionId;

  DateTime? _lastUpdated;
  DateTime? get lastUpdated => _$this._lastUpdated;
  set lastUpdated(DateTime? lastUpdated) => _$this._lastUpdated = lastUpdated;

  BalanceResponseBuilder() {
    BalanceResponse._defaults(this);
  }

  BalanceResponseBuilder get _$this {
    final $v = _$v;
    if ($v != null) {
      _agentId = $v.agentId;
      _availableBalance = $v.availableBalance;
      _ledgerBalance = $v.ledgerBalance;
      _pendingBalance = $v.pendingBalance;
      _currency = $v.currency;
      _lastTransactionId = $v.lastTransactionId;
      _lastUpdated = $v.lastUpdated;
      _$v = null;
    }
    return this;
  }

  @override
  void replace(BalanceResponse other) {
    _$v = other as _$BalanceResponse;
  }

  @override
  void update(void Function(BalanceResponseBuilder)? updates) {
    if (updates != null) updates(this);
  }

  @override
  BalanceResponse build() => _build();

  _$BalanceResponse _build() {
    final _$result = _$v ??
        _$BalanceResponse._(
          agentId: agentId,
          availableBalance: availableBalance,
          ledgerBalance: ledgerBalance,
          pendingBalance: pendingBalance,
          currency: currency,
          lastTransactionId: lastTransactionId,
          lastUpdated: lastUpdated,
        );
    replace(_$result);
    return _$result;
  }
}

// ignore_for_file: deprecated_member_use_from_same_package,type=lint
