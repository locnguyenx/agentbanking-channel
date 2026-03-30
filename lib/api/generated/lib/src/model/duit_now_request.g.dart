// @dart=2.19
// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'duit_now_request.dart';

// **************************************************************************
// BuiltValueGenerator
// **************************************************************************

class _$DuitNowRequest extends DuitNowRequest {
  @override
  final String internalTransactionId;
  @override
  final String proxyType;
  @override
  final String proxyValue;
  @override
  final num amount;

  factory _$DuitNowRequest([void Function(DuitNowRequestBuilder)? updates]) =>
      (DuitNowRequestBuilder()..update(updates))._build();

  _$DuitNowRequest._(
      {required this.internalTransactionId,
      required this.proxyType,
      required this.proxyValue,
      required this.amount})
      : super._();
  @override
  DuitNowRequest rebuild(void Function(DuitNowRequestBuilder) updates) =>
      (toBuilder()..update(updates)).build();

  @override
  DuitNowRequestBuilder toBuilder() => DuitNowRequestBuilder()..replace(this);

  @override
  bool operator ==(Object other) {
    if (identical(other, this)) return true;
    return other is DuitNowRequest &&
        internalTransactionId == other.internalTransactionId &&
        proxyType == other.proxyType &&
        proxyValue == other.proxyValue &&
        amount == other.amount;
  }

  @override
  int get hashCode {
    var _$hash = 0;
    _$hash = $jc(_$hash, internalTransactionId.hashCode);
    _$hash = $jc(_$hash, proxyType.hashCode);
    _$hash = $jc(_$hash, proxyValue.hashCode);
    _$hash = $jc(_$hash, amount.hashCode);
    _$hash = $jf(_$hash);
    return _$hash;
  }

  @override
  String toString() {
    return (newBuiltValueToStringHelper(r'DuitNowRequest')
          ..add('internalTransactionId', internalTransactionId)
          ..add('proxyType', proxyType)
          ..add('proxyValue', proxyValue)
          ..add('amount', amount))
        .toString();
  }
}

class DuitNowRequestBuilder
    implements Builder<DuitNowRequest, DuitNowRequestBuilder> {
  _$DuitNowRequest? _$v;

  String? _internalTransactionId;
  String? get internalTransactionId => _$this._internalTransactionId;
  set internalTransactionId(String? internalTransactionId) =>
      _$this._internalTransactionId = internalTransactionId;

  String? _proxyType;
  String? get proxyType => _$this._proxyType;
  set proxyType(String? proxyType) => _$this._proxyType = proxyType;

  String? _proxyValue;
  String? get proxyValue => _$this._proxyValue;
  set proxyValue(String? proxyValue) => _$this._proxyValue = proxyValue;

  num? _amount;
  num? get amount => _$this._amount;
  set amount(num? amount) => _$this._amount = amount;

  DuitNowRequestBuilder() {
    DuitNowRequest._defaults(this);
  }

  DuitNowRequestBuilder get _$this {
    final $v = _$v;
    if ($v != null) {
      _internalTransactionId = $v.internalTransactionId;
      _proxyType = $v.proxyType;
      _proxyValue = $v.proxyValue;
      _amount = $v.amount;
      _$v = null;
    }
    return this;
  }

  @override
  void replace(DuitNowRequest other) {
    _$v = other as _$DuitNowRequest;
  }

  @override
  void update(void Function(DuitNowRequestBuilder)? updates) {
    if (updates != null) updates(this);
  }

  @override
  DuitNowRequest build() => _build();

  _$DuitNowRequest _build() {
    final _$result = _$v ??
        _$DuitNowRequest._(
          internalTransactionId: BuiltValueNullFieldError.checkNotNull(
              internalTransactionId,
              r'DuitNowRequest',
              'internalTransactionId'),
          proxyType: BuiltValueNullFieldError.checkNotNull(
              proxyType, r'DuitNowRequest', 'proxyType'),
          proxyValue: BuiltValueNullFieldError.checkNotNull(
              proxyValue, r'DuitNowRequest', 'proxyValue'),
          amount: BuiltValueNullFieldError.checkNotNull(
              amount, r'DuitNowRequest', 'amount'),
        );
    replace(_$result);
    return _$result;
  }
}

// ignore_for_file: deprecated_member_use_from_same_package,type=lint
