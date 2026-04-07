// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'topup_external_request.dart';

// **************************************************************************
// BuiltValueGenerator
// **************************************************************************

const TopupExternalRequestTelcoEnum _$topupExternalRequestTelcoEnum_CELCOM =
    const TopupExternalRequestTelcoEnum._('CELCOM');
const TopupExternalRequestTelcoEnum _$topupExternalRequestTelcoEnum_m1 =
    const TopupExternalRequestTelcoEnum._('m1');
const TopupExternalRequestTelcoEnum _$topupExternalRequestTelcoEnum_UMOBILE =
    const TopupExternalRequestTelcoEnum._('UMOBILE');
const TopupExternalRequestTelcoEnum _$topupExternalRequestTelcoEnum_MAXIS =
    const TopupExternalRequestTelcoEnum._('MAXIS');
const TopupExternalRequestTelcoEnum _$topupExternalRequestTelcoEnum_DIGI =
    const TopupExternalRequestTelcoEnum._('DIGI');

TopupExternalRequestTelcoEnum _$topupExternalRequestTelcoEnumValueOf(
    String name) {
  switch (name) {
    case 'CELCOM':
      return _$topupExternalRequestTelcoEnum_CELCOM;
    case 'm1':
      return _$topupExternalRequestTelcoEnum_m1;
    case 'UMOBILE':
      return _$topupExternalRequestTelcoEnum_UMOBILE;
    case 'MAXIS':
      return _$topupExternalRequestTelcoEnum_MAXIS;
    case 'DIGI':
      return _$topupExternalRequestTelcoEnum_DIGI;
    default:
      throw ArgumentError(name);
  }
}

final BuiltSet<TopupExternalRequestTelcoEnum>
    _$topupExternalRequestTelcoEnumValues = BuiltSet<
        TopupExternalRequestTelcoEnum>(const <TopupExternalRequestTelcoEnum>[
  _$topupExternalRequestTelcoEnum_CELCOM,
  _$topupExternalRequestTelcoEnum_m1,
  _$topupExternalRequestTelcoEnum_UMOBILE,
  _$topupExternalRequestTelcoEnum_MAXIS,
  _$topupExternalRequestTelcoEnum_DIGI,
]);

const TopupExternalRequestCurrencyEnum _$topupExternalRequestCurrencyEnum_MYR =
    const TopupExternalRequestCurrencyEnum._('MYR');

TopupExternalRequestCurrencyEnum _$topupExternalRequestCurrencyEnumValueOf(
    String name) {
  switch (name) {
    case 'MYR':
      return _$topupExternalRequestCurrencyEnum_MYR;
    default:
      throw ArgumentError(name);
  }
}

final BuiltSet<TopupExternalRequestCurrencyEnum>
    _$topupExternalRequestCurrencyEnumValues = BuiltSet<
        TopupExternalRequestCurrencyEnum>(const <TopupExternalRequestCurrencyEnum>[
  _$topupExternalRequestCurrencyEnum_MYR,
]);

Serializer<TopupExternalRequestTelcoEnum>
    _$topupExternalRequestTelcoEnumSerializer =
    _$TopupExternalRequestTelcoEnumSerializer();
Serializer<TopupExternalRequestCurrencyEnum>
    _$topupExternalRequestCurrencyEnumSerializer =
    _$TopupExternalRequestCurrencyEnumSerializer();

class _$TopupExternalRequestTelcoEnumSerializer
    implements PrimitiveSerializer<TopupExternalRequestTelcoEnum> {
  static const Map<String, Object> _toWire = const <String, Object>{
    'CELCOM': 'CELCOM',
    'm1': 'M1',
    'UMOBILE': 'UMOBILE',
    'MAXIS': 'MAXIS',
    'DIGI': 'DIGI',
  };
  static const Map<Object, String> _fromWire = const <Object, String>{
    'CELCOM': 'CELCOM',
    'M1': 'm1',
    'UMOBILE': 'UMOBILE',
    'MAXIS': 'MAXIS',
    'DIGI': 'DIGI',
  };

  @override
  final Iterable<Type> types = const <Type>[TopupExternalRequestTelcoEnum];
  @override
  final String wireName = 'TopupExternalRequestTelcoEnum';

  @override
  Object serialize(
          Serializers serializers, TopupExternalRequestTelcoEnum object,
          {FullType specifiedType = FullType.unspecified}) =>
      _toWire[object.name] ?? object.name;

  @override
  TopupExternalRequestTelcoEnum deserialize(
          Serializers serializers, Object serialized,
          {FullType specifiedType = FullType.unspecified}) =>
      TopupExternalRequestTelcoEnum.valueOf(
          _fromWire[serialized] ?? (serialized is String ? serialized : ''));
}

class _$TopupExternalRequestCurrencyEnumSerializer
    implements PrimitiveSerializer<TopupExternalRequestCurrencyEnum> {
  static const Map<String, Object> _toWire = const <String, Object>{
    'MYR': 'MYR',
  };
  static const Map<Object, String> _fromWire = const <Object, String>{
    'MYR': 'MYR',
  };

  @override
  final Iterable<Type> types = const <Type>[TopupExternalRequestCurrencyEnum];
  @override
  final String wireName = 'TopupExternalRequestCurrencyEnum';

  @override
  Object serialize(
          Serializers serializers, TopupExternalRequestCurrencyEnum object,
          {FullType specifiedType = FullType.unspecified}) =>
      _toWire[object.name] ?? object.name;

  @override
  TopupExternalRequestCurrencyEnum deserialize(
          Serializers serializers, Object serialized,
          {FullType specifiedType = FullType.unspecified}) =>
      TopupExternalRequestCurrencyEnum.valueOf(
          _fromWire[serialized] ?? (serialized is String ? serialized : ''));
}

class _$TopupExternalRequest extends TopupExternalRequest {
  @override
  final TopupExternalRequestTelcoEnum telco;
  @override
  final String phoneNumber;
  @override
  final String amount;
  @override
  final TopupExternalRequestCurrencyEnum currency;
  @override
  final String idempotencyKey;

  factory _$TopupExternalRequest(
          [void Function(TopupExternalRequestBuilder)? updates]) =>
      (TopupExternalRequestBuilder()..update(updates))._build();

  _$TopupExternalRequest._(
      {required this.telco,
      required this.phoneNumber,
      required this.amount,
      required this.currency,
      required this.idempotencyKey})
      : super._();
  @override
  TopupExternalRequest rebuild(
          void Function(TopupExternalRequestBuilder) updates) =>
      (toBuilder()..update(updates)).build();

  @override
  TopupExternalRequestBuilder toBuilder() =>
      TopupExternalRequestBuilder()..replace(this);

  @override
  bool operator ==(Object other) {
    if (identical(other, this)) return true;
    return other is TopupExternalRequest &&
        telco == other.telco &&
        phoneNumber == other.phoneNumber &&
        amount == other.amount &&
        currency == other.currency &&
        idempotencyKey == other.idempotencyKey;
  }

  @override
  int get hashCode {
    var _$hash = 0;
    _$hash = $jc(_$hash, telco.hashCode);
    _$hash = $jc(_$hash, phoneNumber.hashCode);
    _$hash = $jc(_$hash, amount.hashCode);
    _$hash = $jc(_$hash, currency.hashCode);
    _$hash = $jc(_$hash, idempotencyKey.hashCode);
    _$hash = $jf(_$hash);
    return _$hash;
  }

  @override
  String toString() {
    return (newBuiltValueToStringHelper(r'TopupExternalRequest')
          ..add('telco', telco)
          ..add('phoneNumber', phoneNumber)
          ..add('amount', amount)
          ..add('currency', currency)
          ..add('idempotencyKey', idempotencyKey))
        .toString();
  }
}

class TopupExternalRequestBuilder
    implements Builder<TopupExternalRequest, TopupExternalRequestBuilder> {
  _$TopupExternalRequest? _$v;

  TopupExternalRequestTelcoEnum? _telco;
  TopupExternalRequestTelcoEnum? get telco => _$this._telco;
  set telco(TopupExternalRequestTelcoEnum? telco) => _$this._telco = telco;

  String? _phoneNumber;
  String? get phoneNumber => _$this._phoneNumber;
  set phoneNumber(String? phoneNumber) => _$this._phoneNumber = phoneNumber;

  String? _amount;
  String? get amount => _$this._amount;
  set amount(String? amount) => _$this._amount = amount;

  TopupExternalRequestCurrencyEnum? _currency;
  TopupExternalRequestCurrencyEnum? get currency => _$this._currency;
  set currency(TopupExternalRequestCurrencyEnum? currency) =>
      _$this._currency = currency;

  String? _idempotencyKey;
  String? get idempotencyKey => _$this._idempotencyKey;
  set idempotencyKey(String? idempotencyKey) =>
      _$this._idempotencyKey = idempotencyKey;

  TopupExternalRequestBuilder() {
    TopupExternalRequest._defaults(this);
  }

  TopupExternalRequestBuilder get _$this {
    final $v = _$v;
    if ($v != null) {
      _telco = $v.telco;
      _phoneNumber = $v.phoneNumber;
      _amount = $v.amount;
      _currency = $v.currency;
      _idempotencyKey = $v.idempotencyKey;
      _$v = null;
    }
    return this;
  }

  @override
  void replace(TopupExternalRequest other) {
    _$v = other as _$TopupExternalRequest;
  }

  @override
  void update(void Function(TopupExternalRequestBuilder)? updates) {
    if (updates != null) updates(this);
  }

  @override
  TopupExternalRequest build() => _build();

  _$TopupExternalRequest _build() {
    final _$result = _$v ??
        _$TopupExternalRequest._(
          telco: BuiltValueNullFieldError.checkNotNull(
              telco, r'TopupExternalRequest', 'telco'),
          phoneNumber: BuiltValueNullFieldError.checkNotNull(
              phoneNumber, r'TopupExternalRequest', 'phoneNumber'),
          amount: BuiltValueNullFieldError.checkNotNull(
              amount, r'TopupExternalRequest', 'amount'),
          currency: BuiltValueNullFieldError.checkNotNull(
              currency, r'TopupExternalRequest', 'currency'),
          idempotencyKey: BuiltValueNullFieldError.checkNotNull(
              idempotencyKey, r'TopupExternalRequest', 'idempotencyKey'),
        );
    replace(_$result);
    return _$result;
  }
}

// ignore_for_file: deprecated_member_use_from_same_package,type=lint
