// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'retail_pin_purchase_external_request.dart';

// **************************************************************************
// BuiltValueGenerator
// **************************************************************************

class _$RetailPinPurchaseExternalRequest
    extends RetailPinPurchaseExternalRequest {
  @override
  final String productCode;
  @override
  final String amount;
  @override
  final String idempotencyKey;

  factory _$RetailPinPurchaseExternalRequest(
          [void Function(RetailPinPurchaseExternalRequestBuilder)? updates]) =>
      (RetailPinPurchaseExternalRequestBuilder()..update(updates))._build();

  _$RetailPinPurchaseExternalRequest._(
      {required this.productCode,
      required this.amount,
      required this.idempotencyKey})
      : super._();
  @override
  RetailPinPurchaseExternalRequest rebuild(
          void Function(RetailPinPurchaseExternalRequestBuilder) updates) =>
      (toBuilder()..update(updates)).build();

  @override
  RetailPinPurchaseExternalRequestBuilder toBuilder() =>
      RetailPinPurchaseExternalRequestBuilder()..replace(this);

  @override
  bool operator ==(Object other) {
    if (identical(other, this)) return true;
    return other is RetailPinPurchaseExternalRequest &&
        productCode == other.productCode &&
        amount == other.amount &&
        idempotencyKey == other.idempotencyKey;
  }

  @override
  int get hashCode {
    var _$hash = 0;
    _$hash = $jc(_$hash, productCode.hashCode);
    _$hash = $jc(_$hash, amount.hashCode);
    _$hash = $jc(_$hash, idempotencyKey.hashCode);
    _$hash = $jf(_$hash);
    return _$hash;
  }

  @override
  String toString() {
    return (newBuiltValueToStringHelper(r'RetailPinPurchaseExternalRequest')
          ..add('productCode', productCode)
          ..add('amount', amount)
          ..add('idempotencyKey', idempotencyKey))
        .toString();
  }
}

class RetailPinPurchaseExternalRequestBuilder
    implements
        Builder<RetailPinPurchaseExternalRequest,
            RetailPinPurchaseExternalRequestBuilder> {
  _$RetailPinPurchaseExternalRequest? _$v;

  String? _productCode;
  String? get productCode => _$this._productCode;
  set productCode(String? productCode) => _$this._productCode = productCode;

  String? _amount;
  String? get amount => _$this._amount;
  set amount(String? amount) => _$this._amount = amount;

  String? _idempotencyKey;
  String? get idempotencyKey => _$this._idempotencyKey;
  set idempotencyKey(String? idempotencyKey) =>
      _$this._idempotencyKey = idempotencyKey;

  RetailPinPurchaseExternalRequestBuilder() {
    RetailPinPurchaseExternalRequest._defaults(this);
  }

  RetailPinPurchaseExternalRequestBuilder get _$this {
    final $v = _$v;
    if ($v != null) {
      _productCode = $v.productCode;
      _amount = $v.amount;
      _idempotencyKey = $v.idempotencyKey;
      _$v = null;
    }
    return this;
  }

  @override
  void replace(RetailPinPurchaseExternalRequest other) {
    _$v = other as _$RetailPinPurchaseExternalRequest;
  }

  @override
  void update(void Function(RetailPinPurchaseExternalRequestBuilder)? updates) {
    if (updates != null) updates(this);
  }

  @override
  RetailPinPurchaseExternalRequest build() => _build();

  _$RetailPinPurchaseExternalRequest _build() {
    final _$result = _$v ??
        _$RetailPinPurchaseExternalRequest._(
          productCode: BuiltValueNullFieldError.checkNotNull(
              productCode, r'RetailPinPurchaseExternalRequest', 'productCode'),
          amount: BuiltValueNullFieldError.checkNotNull(
              amount, r'RetailPinPurchaseExternalRequest', 'amount'),
          idempotencyKey: BuiltValueNullFieldError.checkNotNull(idempotencyKey,
              r'RetailPinPurchaseExternalRequest', 'idempotencyKey'),
        );
    replace(_$result);
    return _$result;
  }
}

// ignore_for_file: deprecated_member_use_from_same_package,type=lint
