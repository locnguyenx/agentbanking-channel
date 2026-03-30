// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'withdrawal_external_request.dart';

// **************************************************************************
// BuiltValueGenerator
// **************************************************************************

const WithdrawalExternalRequestCurrencyEnum
    _$withdrawalExternalRequestCurrencyEnum_MYR =
    const WithdrawalExternalRequestCurrencyEnum._('MYR');

WithdrawalExternalRequestCurrencyEnum
    _$withdrawalExternalRequestCurrencyEnumValueOf(String name) {
  switch (name) {
    case 'MYR':
      return _$withdrawalExternalRequestCurrencyEnum_MYR;
    default:
      throw ArgumentError(name);
  }
}

final BuiltSet<WithdrawalExternalRequestCurrencyEnum>
    _$withdrawalExternalRequestCurrencyEnumValues = BuiltSet<
        WithdrawalExternalRequestCurrencyEnum>(const <WithdrawalExternalRequestCurrencyEnum>[
  _$withdrawalExternalRequestCurrencyEnum_MYR,
]);

Serializer<WithdrawalExternalRequestCurrencyEnum>
    _$withdrawalExternalRequestCurrencyEnumSerializer =
    _$WithdrawalExternalRequestCurrencyEnumSerializer();

class _$WithdrawalExternalRequestCurrencyEnumSerializer
    implements PrimitiveSerializer<WithdrawalExternalRequestCurrencyEnum> {
  static const Map<String, Object> _toWire = const <String, Object>{
    'MYR': 'MYR',
  };
  static const Map<Object, String> _fromWire = const <Object, String>{
    'MYR': 'MYR',
  };

  @override
  final Iterable<Type> types = const <Type>[
    WithdrawalExternalRequestCurrencyEnum
  ];
  @override
  final String wireName = 'WithdrawalExternalRequestCurrencyEnum';

  @override
  Object serialize(
          Serializers serializers, WithdrawalExternalRequestCurrencyEnum object,
          {FullType specifiedType = FullType.unspecified}) =>
      _toWire[object.name] ?? object.name;

  @override
  WithdrawalExternalRequestCurrencyEnum deserialize(
          Serializers serializers, Object serialized,
          {FullType specifiedType = FullType.unspecified}) =>
      WithdrawalExternalRequestCurrencyEnum.valueOf(
          _fromWire[serialized] ?? (serialized is String ? serialized : ''));
}

class _$WithdrawalExternalRequest extends WithdrawalExternalRequest {
  @override
  final num amount;
  @override
  final WithdrawalExternalRequestCurrencyEnum currency;
  @override
  final String idempotencyKey;
  @override
  final String customerCard;
  @override
  final String customerPin;
  @override
  final GeoLocation? location;

  factory _$WithdrawalExternalRequest(
          [void Function(WithdrawalExternalRequestBuilder)? updates]) =>
      (WithdrawalExternalRequestBuilder()..update(updates))._build();

  _$WithdrawalExternalRequest._(
      {required this.amount,
      required this.currency,
      required this.idempotencyKey,
      required this.customerCard,
      required this.customerPin,
      this.location})
      : super._();
  @override
  WithdrawalExternalRequest rebuild(
          void Function(WithdrawalExternalRequestBuilder) updates) =>
      (toBuilder()..update(updates)).build();

  @override
  WithdrawalExternalRequestBuilder toBuilder() =>
      WithdrawalExternalRequestBuilder()..replace(this);

  @override
  bool operator ==(Object other) {
    if (identical(other, this)) return true;
    return other is WithdrawalExternalRequest &&
        amount == other.amount &&
        currency == other.currency &&
        idempotencyKey == other.idempotencyKey &&
        customerCard == other.customerCard &&
        customerPin == other.customerPin &&
        location == other.location;
  }

  @override
  int get hashCode {
    var _$hash = 0;
    _$hash = $jc(_$hash, amount.hashCode);
    _$hash = $jc(_$hash, currency.hashCode);
    _$hash = $jc(_$hash, idempotencyKey.hashCode);
    _$hash = $jc(_$hash, customerCard.hashCode);
    _$hash = $jc(_$hash, customerPin.hashCode);
    _$hash = $jc(_$hash, location.hashCode);
    _$hash = $jf(_$hash);
    return _$hash;
  }

  @override
  String toString() {
    return (newBuiltValueToStringHelper(r'WithdrawalExternalRequest')
          ..add('amount', amount)
          ..add('currency', currency)
          ..add('idempotencyKey', idempotencyKey)
          ..add('customerCard', customerCard)
          ..add('customerPin', customerPin)
          ..add('location', location))
        .toString();
  }
}

class WithdrawalExternalRequestBuilder
    implements
        Builder<WithdrawalExternalRequest, WithdrawalExternalRequestBuilder> {
  _$WithdrawalExternalRequest? _$v;

  num? _amount;
  num? get amount => _$this._amount;
  set amount(num? amount) => _$this._amount = amount;

  WithdrawalExternalRequestCurrencyEnum? _currency;
  WithdrawalExternalRequestCurrencyEnum? get currency => _$this._currency;
  set currency(WithdrawalExternalRequestCurrencyEnum? currency) =>
      _$this._currency = currency;

  String? _idempotencyKey;
  String? get idempotencyKey => _$this._idempotencyKey;
  set idempotencyKey(String? idempotencyKey) =>
      _$this._idempotencyKey = idempotencyKey;

  String? _customerCard;
  String? get customerCard => _$this._customerCard;
  set customerCard(String? customerCard) => _$this._customerCard = customerCard;

  String? _customerPin;
  String? get customerPin => _$this._customerPin;
  set customerPin(String? customerPin) => _$this._customerPin = customerPin;

  GeoLocationBuilder? _location;
  GeoLocationBuilder get location => _$this._location ??= GeoLocationBuilder();
  set location(GeoLocationBuilder? location) => _$this._location = location;

  WithdrawalExternalRequestBuilder() {
    WithdrawalExternalRequest._defaults(this);
  }

  WithdrawalExternalRequestBuilder get _$this {
    final $v = _$v;
    if ($v != null) {
      _amount = $v.amount;
      _currency = $v.currency;
      _idempotencyKey = $v.idempotencyKey;
      _customerCard = $v.customerCard;
      _customerPin = $v.customerPin;
      _location = $v.location?.toBuilder();
      _$v = null;
    }
    return this;
  }

  @override
  void replace(WithdrawalExternalRequest other) {
    _$v = other as _$WithdrawalExternalRequest;
  }

  @override
  void update(void Function(WithdrawalExternalRequestBuilder)? updates) {
    if (updates != null) updates(this);
  }

  @override
  WithdrawalExternalRequest build() => _build();

  _$WithdrawalExternalRequest _build() {
    _$WithdrawalExternalRequest _$result;
    try {
      _$result = _$v ??
          _$WithdrawalExternalRequest._(
            amount: BuiltValueNullFieldError.checkNotNull(
                amount, r'WithdrawalExternalRequest', 'amount'),
            currency: BuiltValueNullFieldError.checkNotNull(
                currency, r'WithdrawalExternalRequest', 'currency'),
            idempotencyKey: BuiltValueNullFieldError.checkNotNull(
                idempotencyKey, r'WithdrawalExternalRequest', 'idempotencyKey'),
            customerCard: BuiltValueNullFieldError.checkNotNull(
                customerCard, r'WithdrawalExternalRequest', 'customerCard'),
            customerPin: BuiltValueNullFieldError.checkNotNull(
                customerPin, r'WithdrawalExternalRequest', 'customerPin'),
            location: _location?.build(),
          );
    } catch (_) {
      late String _$failedField;
      try {
        _$failedField = 'location';
        _location?.build();
      } catch (e) {
        throw BuiltValueNestedFieldError(
            r'WithdrawalExternalRequest', _$failedField, e.toString());
      }
      rethrow;
    }
    replace(_$result);
    return _$result;
  }
}

// ignore_for_file: deprecated_member_use_from_same_package,type=lint
