// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'duit_now_external_request.dart';

// **************************************************************************
// BuiltValueGenerator
// **************************************************************************

const DuitNowExternalRequestCurrencyEnum
    _$duitNowExternalRequestCurrencyEnum_MYR =
    const DuitNowExternalRequestCurrencyEnum._('MYR');

DuitNowExternalRequestCurrencyEnum _$duitNowExternalRequestCurrencyEnumValueOf(
    String name) {
  switch (name) {
    case 'MYR':
      return _$duitNowExternalRequestCurrencyEnum_MYR;
    default:
      throw ArgumentError(name);
  }
}

final BuiltSet<DuitNowExternalRequestCurrencyEnum>
    _$duitNowExternalRequestCurrencyEnumValues = BuiltSet<
        DuitNowExternalRequestCurrencyEnum>(const <DuitNowExternalRequestCurrencyEnum>[
  _$duitNowExternalRequestCurrencyEnum_MYR,
]);

const DuitNowExternalRequestProxyTypeEnum
    _$duitNowExternalRequestProxyTypeEnum_IC =
    const DuitNowExternalRequestProxyTypeEnum._('IC');
const DuitNowExternalRequestProxyTypeEnum
    _$duitNowExternalRequestProxyTypeEnum_PHONE =
    const DuitNowExternalRequestProxyTypeEnum._('PHONE');
const DuitNowExternalRequestProxyTypeEnum
    _$duitNowExternalRequestProxyTypeEnum_EMAIL =
    const DuitNowExternalRequestProxyTypeEnum._('EMAIL');
const DuitNowExternalRequestProxyTypeEnum
    _$duitNowExternalRequestProxyTypeEnum_TGAN =
    const DuitNowExternalRequestProxyTypeEnum._('TGAN');

DuitNowExternalRequestProxyTypeEnum
    _$duitNowExternalRequestProxyTypeEnumValueOf(String name) {
  switch (name) {
    case 'IC':
      return _$duitNowExternalRequestProxyTypeEnum_IC;
    case 'PHONE':
      return _$duitNowExternalRequestProxyTypeEnum_PHONE;
    case 'EMAIL':
      return _$duitNowExternalRequestProxyTypeEnum_EMAIL;
    case 'TGAN':
      return _$duitNowExternalRequestProxyTypeEnum_TGAN;
    default:
      throw ArgumentError(name);
  }
}

final BuiltSet<DuitNowExternalRequestProxyTypeEnum>
    _$duitNowExternalRequestProxyTypeEnumValues = BuiltSet<
        DuitNowExternalRequestProxyTypeEnum>(const <DuitNowExternalRequestProxyTypeEnum>[
  _$duitNowExternalRequestProxyTypeEnum_IC,
  _$duitNowExternalRequestProxyTypeEnum_PHONE,
  _$duitNowExternalRequestProxyTypeEnum_EMAIL,
  _$duitNowExternalRequestProxyTypeEnum_TGAN,
]);

Serializer<DuitNowExternalRequestCurrencyEnum>
    _$duitNowExternalRequestCurrencyEnumSerializer =
    _$DuitNowExternalRequestCurrencyEnumSerializer();
Serializer<DuitNowExternalRequestProxyTypeEnum>
    _$duitNowExternalRequestProxyTypeEnumSerializer =
    _$DuitNowExternalRequestProxyTypeEnumSerializer();

class _$DuitNowExternalRequestCurrencyEnumSerializer
    implements PrimitiveSerializer<DuitNowExternalRequestCurrencyEnum> {
  static const Map<String, Object> _toWire = const <String, Object>{
    'MYR': 'MYR',
  };
  static const Map<Object, String> _fromWire = const <Object, String>{
    'MYR': 'MYR',
  };

  @override
  final Iterable<Type> types = const <Type>[DuitNowExternalRequestCurrencyEnum];
  @override
  final String wireName = 'DuitNowExternalRequestCurrencyEnum';

  @override
  Object serialize(
          Serializers serializers, DuitNowExternalRequestCurrencyEnum object,
          {FullType specifiedType = FullType.unspecified}) =>
      _toWire[object.name] ?? object.name;

  @override
  DuitNowExternalRequestCurrencyEnum deserialize(
          Serializers serializers, Object serialized,
          {FullType specifiedType = FullType.unspecified}) =>
      DuitNowExternalRequestCurrencyEnum.valueOf(
          _fromWire[serialized] ?? (serialized is String ? serialized : ''));
}

class _$DuitNowExternalRequestProxyTypeEnumSerializer
    implements PrimitiveSerializer<DuitNowExternalRequestProxyTypeEnum> {
  static const Map<String, Object> _toWire = const <String, Object>{
    'IC': 'IC',
    'PHONE': 'PHONE',
    'EMAIL': 'EMAIL',
    'TGAN': 'TGAN',
  };
  static const Map<Object, String> _fromWire = const <Object, String>{
    'IC': 'IC',
    'PHONE': 'PHONE',
    'EMAIL': 'EMAIL',
    'TGAN': 'TGAN',
  };

  @override
  final Iterable<Type> types = const <Type>[
    DuitNowExternalRequestProxyTypeEnum
  ];
  @override
  final String wireName = 'DuitNowExternalRequestProxyTypeEnum';

  @override
  Object serialize(
          Serializers serializers, DuitNowExternalRequestProxyTypeEnum object,
          {FullType specifiedType = FullType.unspecified}) =>
      _toWire[object.name] ?? object.name;

  @override
  DuitNowExternalRequestProxyTypeEnum deserialize(
          Serializers serializers, Object serialized,
          {FullType specifiedType = FullType.unspecified}) =>
      DuitNowExternalRequestProxyTypeEnum.valueOf(
          _fromWire[serialized] ?? (serialized is String ? serialized : ''));
}

class _$DuitNowExternalRequest extends DuitNowExternalRequest {
  @override
  final num amount;
  @override
  final DuitNowExternalRequestCurrencyEnum currency;
  @override
  final String idempotencyKey;
  @override
  final DuitNowExternalRequestProxyTypeEnum proxyType;
  @override
  final String proxyValue;
  @override
  final String? recipientName;

  factory _$DuitNowExternalRequest(
          [void Function(DuitNowExternalRequestBuilder)? updates]) =>
      (DuitNowExternalRequestBuilder()..update(updates))._build();

  _$DuitNowExternalRequest._(
      {required this.amount,
      required this.currency,
      required this.idempotencyKey,
      required this.proxyType,
      required this.proxyValue,
      this.recipientName})
      : super._();
  @override
  DuitNowExternalRequest rebuild(
          void Function(DuitNowExternalRequestBuilder) updates) =>
      (toBuilder()..update(updates)).build();

  @override
  DuitNowExternalRequestBuilder toBuilder() =>
      DuitNowExternalRequestBuilder()..replace(this);

  @override
  bool operator ==(Object other) {
    if (identical(other, this)) return true;
    return other is DuitNowExternalRequest &&
        amount == other.amount &&
        currency == other.currency &&
        idempotencyKey == other.idempotencyKey &&
        proxyType == other.proxyType &&
        proxyValue == other.proxyValue &&
        recipientName == other.recipientName;
  }

  @override
  int get hashCode {
    var _$hash = 0;
    _$hash = $jc(_$hash, amount.hashCode);
    _$hash = $jc(_$hash, currency.hashCode);
    _$hash = $jc(_$hash, idempotencyKey.hashCode);
    _$hash = $jc(_$hash, proxyType.hashCode);
    _$hash = $jc(_$hash, proxyValue.hashCode);
    _$hash = $jc(_$hash, recipientName.hashCode);
    _$hash = $jf(_$hash);
    return _$hash;
  }

  @override
  String toString() {
    return (newBuiltValueToStringHelper(r'DuitNowExternalRequest')
          ..add('amount', amount)
          ..add('currency', currency)
          ..add('idempotencyKey', idempotencyKey)
          ..add('proxyType', proxyType)
          ..add('proxyValue', proxyValue)
          ..add('recipientName', recipientName))
        .toString();
  }
}

class DuitNowExternalRequestBuilder
    implements Builder<DuitNowExternalRequest, DuitNowExternalRequestBuilder> {
  _$DuitNowExternalRequest? _$v;

  num? _amount;
  num? get amount => _$this._amount;
  set amount(num? amount) => _$this._amount = amount;

  DuitNowExternalRequestCurrencyEnum? _currency;
  DuitNowExternalRequestCurrencyEnum? get currency => _$this._currency;
  set currency(DuitNowExternalRequestCurrencyEnum? currency) =>
      _$this._currency = currency;

  String? _idempotencyKey;
  String? get idempotencyKey => _$this._idempotencyKey;
  set idempotencyKey(String? idempotencyKey) =>
      _$this._idempotencyKey = idempotencyKey;

  DuitNowExternalRequestProxyTypeEnum? _proxyType;
  DuitNowExternalRequestProxyTypeEnum? get proxyType => _$this._proxyType;
  set proxyType(DuitNowExternalRequestProxyTypeEnum? proxyType) =>
      _$this._proxyType = proxyType;

  String? _proxyValue;
  String? get proxyValue => _$this._proxyValue;
  set proxyValue(String? proxyValue) => _$this._proxyValue = proxyValue;

  String? _recipientName;
  String? get recipientName => _$this._recipientName;
  set recipientName(String? recipientName) =>
      _$this._recipientName = recipientName;

  DuitNowExternalRequestBuilder() {
    DuitNowExternalRequest._defaults(this);
  }

  DuitNowExternalRequestBuilder get _$this {
    final $v = _$v;
    if ($v != null) {
      _amount = $v.amount;
      _currency = $v.currency;
      _idempotencyKey = $v.idempotencyKey;
      _proxyType = $v.proxyType;
      _proxyValue = $v.proxyValue;
      _recipientName = $v.recipientName;
      _$v = null;
    }
    return this;
  }

  @override
  void replace(DuitNowExternalRequest other) {
    _$v = other as _$DuitNowExternalRequest;
  }

  @override
  void update(void Function(DuitNowExternalRequestBuilder)? updates) {
    if (updates != null) updates(this);
  }

  @override
  DuitNowExternalRequest build() => _build();

  _$DuitNowExternalRequest _build() {
    final _$result = _$v ??
        _$DuitNowExternalRequest._(
          amount: BuiltValueNullFieldError.checkNotNull(
              amount, r'DuitNowExternalRequest', 'amount'),
          currency: BuiltValueNullFieldError.checkNotNull(
              currency, r'DuitNowExternalRequest', 'currency'),
          idempotencyKey: BuiltValueNullFieldError.checkNotNull(
              idempotencyKey, r'DuitNowExternalRequest', 'idempotencyKey'),
          proxyType: BuiltValueNullFieldError.checkNotNull(
              proxyType, r'DuitNowExternalRequest', 'proxyType'),
          proxyValue: BuiltValueNullFieldError.checkNotNull(
              proxyValue, r'DuitNowExternalRequest', 'proxyValue'),
          recipientName: recipientName,
        );
    replace(_$result);
    return _$result;
  }
}

// ignore_for_file: deprecated_member_use_from_same_package,type=lint
