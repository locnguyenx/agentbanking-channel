// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'cash_back_response.dart';

// **************************************************************************
// BuiltValueGenerator
// **************************************************************************

class _$CashBackResponse extends CashBackResponse {
  @override
  final String? status;
  @override
  final String? transactionId;
  @override
  final String? cashBackAmount;
  @override
  final String? commission;

  factory _$CashBackResponse(
          [void Function(CashBackResponseBuilder)? updates]) =>
      (CashBackResponseBuilder()..update(updates))._build();

  _$CashBackResponse._(
      {this.status, this.transactionId, this.cashBackAmount, this.commission})
      : super._();
  @override
  CashBackResponse rebuild(void Function(CashBackResponseBuilder) updates) =>
      (toBuilder()..update(updates)).build();

  @override
  CashBackResponseBuilder toBuilder() =>
      CashBackResponseBuilder()..replace(this);

  @override
  bool operator ==(Object other) {
    if (identical(other, this)) return true;
    return other is CashBackResponse &&
        status == other.status &&
        transactionId == other.transactionId &&
        cashBackAmount == other.cashBackAmount &&
        commission == other.commission;
  }

  @override
  int get hashCode {
    var _$hash = 0;
    _$hash = $jc(_$hash, status.hashCode);
    _$hash = $jc(_$hash, transactionId.hashCode);
    _$hash = $jc(_$hash, cashBackAmount.hashCode);
    _$hash = $jc(_$hash, commission.hashCode);
    _$hash = $jf(_$hash);
    return _$hash;
  }

  @override
  String toString() {
    return (newBuiltValueToStringHelper(r'CashBackResponse')
          ..add('status', status)
          ..add('transactionId', transactionId)
          ..add('cashBackAmount', cashBackAmount)
          ..add('commission', commission))
        .toString();
  }
}

class CashBackResponseBuilder
    implements Builder<CashBackResponse, CashBackResponseBuilder> {
  _$CashBackResponse? _$v;

  String? _status;
  String? get status => _$this._status;
  set status(String? status) => _$this._status = status;

  String? _transactionId;
  String? get transactionId => _$this._transactionId;
  set transactionId(String? transactionId) =>
      _$this._transactionId = transactionId;

  String? _cashBackAmount;
  String? get cashBackAmount => _$this._cashBackAmount;
  set cashBackAmount(String? cashBackAmount) =>
      _$this._cashBackAmount = cashBackAmount;

  String? _commission;
  String? get commission => _$this._commission;
  set commission(String? commission) => _$this._commission = commission;

  CashBackResponseBuilder() {
    CashBackResponse._defaults(this);
  }

  CashBackResponseBuilder get _$this {
    final $v = _$v;
    if ($v != null) {
      _status = $v.status;
      _transactionId = $v.transactionId;
      _cashBackAmount = $v.cashBackAmount;
      _commission = $v.commission;
      _$v = null;
    }
    return this;
  }

  @override
  void replace(CashBackResponse other) {
    _$v = other as _$CashBackResponse;
  }

  @override
  void update(void Function(CashBackResponseBuilder)? updates) {
    if (updates != null) updates(this);
  }

  @override
  CashBackResponse build() => _build();

  _$CashBackResponse _build() {
    final _$result = _$v ??
        _$CashBackResponse._(
          status: status,
          transactionId: transactionId,
          cashBackAmount: cashBackAmount,
          commission: commission,
        );
    replace(_$result);
    return _$result;
  }
}

// ignore_for_file: deprecated_member_use_from_same_package,type=lint
