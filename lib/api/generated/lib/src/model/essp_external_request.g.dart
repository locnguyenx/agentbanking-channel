// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'essp_external_request.dart';

// **************************************************************************
// BuiltValueGenerator
// **************************************************************************

const EsspExternalRequestCurrencyEnum _$esspExternalRequestCurrencyEnum_MYR =
    const EsspExternalRequestCurrencyEnum._('MYR');

EsspExternalRequestCurrencyEnum _$esspExternalRequestCurrencyEnumValueOf(
    String name) {
  switch (name) {
    case 'MYR':
      return _$esspExternalRequestCurrencyEnum_MYR;
    default:
      throw ArgumentError(name);
  }
}

final BuiltSet<EsspExternalRequestCurrencyEnum>
    _$esspExternalRequestCurrencyEnumValues = BuiltSet<
        EsspExternalRequestCurrencyEnum>(const <EsspExternalRequestCurrencyEnum>[
  _$esspExternalRequestCurrencyEnum_MYR,
]);

Serializer<EsspExternalRequestCurrencyEnum>
    _$esspExternalRequestCurrencyEnumSerializer =
    _$EsspExternalRequestCurrencyEnumSerializer();

class _$EsspExternalRequestCurrencyEnumSerializer
    implements PrimitiveSerializer<EsspExternalRequestCurrencyEnum> {
  static const Map<String, Object> _toWire = const <String, Object>{
    'MYR': 'MYR',
  };
  static const Map<Object, String> _fromWire = const <Object, String>{
    'MYR': 'MYR',
  };

  @override
  final Iterable<Type> types = const <Type>[EsspExternalRequestCurrencyEnum];
  @override
  final String wireName = 'EsspExternalRequestCurrencyEnum';

  @override
  Object serialize(
          Serializers serializers, EsspExternalRequestCurrencyEnum object,
          {FullType specifiedType = FullType.unspecified}) =>
      _toWire[object.name] ?? object.name;

  @override
  EsspExternalRequestCurrencyEnum deserialize(
          Serializers serializers, Object serialized,
          {FullType specifiedType = FullType.unspecified}) =>
      EsspExternalRequestCurrencyEnum.valueOf(
          _fromWire[serialized] ?? (serialized is String ? serialized : ''));
}

class _$EsspExternalRequest extends EsspExternalRequest {
  @override
  final String productCode;
  @override
  final num amount;
  @override
  final EsspExternalRequestCurrencyEnum currency;
  @override
  final String idempotencyKey;
  @override
  final String? customerMobile;

  factory _$EsspExternalRequest(
          [void Function(EsspExternalRequestBuilder)? updates]) =>
      (EsspExternalRequestBuilder()..update(updates))._build();

  _$EsspExternalRequest._(
      {required this.productCode,
      required this.amount,
      required this.currency,
      required this.idempotencyKey,
      this.customerMobile})
      : super._();
  @override
  EsspExternalRequest rebuild(
          void Function(EsspExternalRequestBuilder) updates) =>
      (toBuilder()..update(updates)).build();

  @override
  EsspExternalRequestBuilder toBuilder() =>
      EsspExternalRequestBuilder()..replace(this);

  @override
  bool operator ==(Object other) {
    if (identical(other, this)) return true;
    return other is EsspExternalRequest &&
        productCode == other.productCode &&
        amount == other.amount &&
        currency == other.currency &&
        idempotencyKey == other.idempotencyKey &&
        customerMobile == other.customerMobile;
  }

  @override
  int get hashCode {
    var _$hash = 0;
    _$hash = $jc(_$hash, productCode.hashCode);
    _$hash = $jc(_$hash, amount.hashCode);
    _$hash = $jc(_$hash, currency.hashCode);
    _$hash = $jc(_$hash, idempotencyKey.hashCode);
    _$hash = $jc(_$hash, customerMobile.hashCode);
    _$hash = $jf(_$hash);
    return _$hash;
  }

  @override
  String toString() {
    return (newBuiltValueToStringHelper(r'EsspExternalRequest')
          ..add('productCode', productCode)
          ..add('amount', amount)
          ..add('currency', currency)
          ..add('idempotencyKey', idempotencyKey)
          ..add('customerMobile', customerMobile))
        .toString();
  }
}

class EsspExternalRequestBuilder
    implements Builder<EsspExternalRequest, EsspExternalRequestBuilder> {
  _$EsspExternalRequest? _$v;

  String? _productCode;
  String? get productCode => _$this._productCode;
  set productCode(String? productCode) => _$this._productCode = productCode;

  num? _amount;
  num? get amount => _$this._amount;
  set amount(num? amount) => _$this._amount = amount;

  EsspExternalRequestCurrencyEnum? _currency;
  EsspExternalRequestCurrencyEnum? get currency => _$this._currency;
  set currency(EsspExternalRequestCurrencyEnum? currency) =>
      _$this._currency = currency;

  String? _idempotencyKey;
  String? get idempotencyKey => _$this._idempotencyKey;
  set idempotencyKey(String? idempotencyKey) =>
      _$this._idempotencyKey = idempotencyKey;

  String? _customerMobile;
  String? get customerMobile => _$this._customerMobile;
  set customerMobile(String? customerMobile) =>
      _$this._customerMobile = customerMobile;

  EsspExternalRequestBuilder() {
    EsspExternalRequest._defaults(this);
  }

  EsspExternalRequestBuilder get _$this {
    final $v = _$v;
    if ($v != null) {
      _productCode = $v.productCode;
      _amount = $v.amount;
      _currency = $v.currency;
      _idempotencyKey = $v.idempotencyKey;
      _customerMobile = $v.customerMobile;
      _$v = null;
    }
    return this;
  }

  @override
  void replace(EsspExternalRequest other) {
    _$v = other as _$EsspExternalRequest;
  }

  @override
  void update(void Function(EsspExternalRequestBuilder)? updates) {
    if (updates != null) updates(this);
  }

  @override
  EsspExternalRequest build() => _build();

  _$EsspExternalRequest _build() {
    final _$result = _$v ??
        _$EsspExternalRequest._(
          productCode: BuiltValueNullFieldError.checkNotNull(
              productCode, r'EsspExternalRequest', 'productCode'),
          amount: BuiltValueNullFieldError.checkNotNull(
              amount, r'EsspExternalRequest', 'amount'),
          currency: BuiltValueNullFieldError.checkNotNull(
              currency, r'EsspExternalRequest', 'currency'),
          idempotencyKey: BuiltValueNullFieldError.checkNotNull(
              idempotencyKey, r'EsspExternalRequest', 'idempotencyKey'),
          customerMobile: customerMobile,
        );
    replace(_$result);
    return _$result;
  }
}

// ignore_for_file: deprecated_member_use_from_same_package,type=lint
