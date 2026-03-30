// @dart=2.19
// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'retail_sale_response.dart';

// **************************************************************************
// BuiltValueGenerator
// **************************************************************************

class _$RetailSaleResponse extends RetailSaleResponse {
  @override
  final String? status;
  @override
  final String? transactionId;
  @override
  final num? amount;
  @override
  final num? mdrAmount;
  @override
  final num? netToMerchant;

  factory _$RetailSaleResponse(
          [void Function(RetailSaleResponseBuilder)? updates]) =>
      (RetailSaleResponseBuilder()..update(updates))._build();

  _$RetailSaleResponse._(
      {this.status,
      this.transactionId,
      this.amount,
      this.mdrAmount,
      this.netToMerchant})
      : super._();
  @override
  RetailSaleResponse rebuild(
          void Function(RetailSaleResponseBuilder) updates) =>
      (toBuilder()..update(updates)).build();

  @override
  RetailSaleResponseBuilder toBuilder() =>
      RetailSaleResponseBuilder()..replace(this);

  @override
  bool operator ==(Object other) {
    if (identical(other, this)) return true;
    return other is RetailSaleResponse &&
        status == other.status &&
        transactionId == other.transactionId &&
        amount == other.amount &&
        mdrAmount == other.mdrAmount &&
        netToMerchant == other.netToMerchant;
  }

  @override
  int get hashCode {
    var _$hash = 0;
    _$hash = $jc(_$hash, status.hashCode);
    _$hash = $jc(_$hash, transactionId.hashCode);
    _$hash = $jc(_$hash, amount.hashCode);
    _$hash = $jc(_$hash, mdrAmount.hashCode);
    _$hash = $jc(_$hash, netToMerchant.hashCode);
    _$hash = $jf(_$hash);
    return _$hash;
  }

  @override
  String toString() {
    return (newBuiltValueToStringHelper(r'RetailSaleResponse')
          ..add('status', status)
          ..add('transactionId', transactionId)
          ..add('amount', amount)
          ..add('mdrAmount', mdrAmount)
          ..add('netToMerchant', netToMerchant))
        .toString();
  }
}

class RetailSaleResponseBuilder
    implements Builder<RetailSaleResponse, RetailSaleResponseBuilder> {
  _$RetailSaleResponse? _$v;

  String? _status;
  String? get status => _$this._status;
  set status(String? status) => _$this._status = status;

  String? _transactionId;
  String? get transactionId => _$this._transactionId;
  set transactionId(String? transactionId) =>
      _$this._transactionId = transactionId;

  num? _amount;
  num? get amount => _$this._amount;
  set amount(num? amount) => _$this._amount = amount;

  num? _mdrAmount;
  num? get mdrAmount => _$this._mdrAmount;
  set mdrAmount(num? mdrAmount) => _$this._mdrAmount = mdrAmount;

  num? _netToMerchant;
  num? get netToMerchant => _$this._netToMerchant;
  set netToMerchant(num? netToMerchant) =>
      _$this._netToMerchant = netToMerchant;

  RetailSaleResponseBuilder() {
    RetailSaleResponse._defaults(this);
  }

  RetailSaleResponseBuilder get _$this {
    final $v = _$v;
    if ($v != null) {
      _status = $v.status;
      _transactionId = $v.transactionId;
      _amount = $v.amount;
      _mdrAmount = $v.mdrAmount;
      _netToMerchant = $v.netToMerchant;
      _$v = null;
    }
    return this;
  }

  @override
  void replace(RetailSaleResponse other) {
    _$v = other as _$RetailSaleResponse;
  }

  @override
  void update(void Function(RetailSaleResponseBuilder)? updates) {
    if (updates != null) updates(this);
  }

  @override
  RetailSaleResponse build() => _build();

  _$RetailSaleResponse _build() {
    final _$result = _$v ??
        _$RetailSaleResponse._(
          status: status,
          transactionId: transactionId,
          amount: amount,
          mdrAmount: mdrAmount,
          netToMerchant: netToMerchant,
        );
    replace(_$result);
    return _$result;
  }
}

// ignore_for_file: deprecated_member_use_from_same_package,type=lint
