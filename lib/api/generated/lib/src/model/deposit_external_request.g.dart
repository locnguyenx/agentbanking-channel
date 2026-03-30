// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'deposit_external_request.dart';

// **************************************************************************
// BuiltValueGenerator
// **************************************************************************

const DepositExternalRequestCurrencyEnum
    _$depositExternalRequestCurrencyEnum_MYR =
    const DepositExternalRequestCurrencyEnum._('MYR');

DepositExternalRequestCurrencyEnum _$depositExternalRequestCurrencyEnumValueOf(
    String name) {
  switch (name) {
    case 'MYR':
      return _$depositExternalRequestCurrencyEnum_MYR;
    default:
      throw ArgumentError(name);
  }
}

final BuiltSet<DepositExternalRequestCurrencyEnum>
    _$depositExternalRequestCurrencyEnumValues = BuiltSet<
        DepositExternalRequestCurrencyEnum>(const <DepositExternalRequestCurrencyEnum>[
  _$depositExternalRequestCurrencyEnum_MYR,
]);

Serializer<DepositExternalRequestCurrencyEnum>
    _$depositExternalRequestCurrencyEnumSerializer =
    _$DepositExternalRequestCurrencyEnumSerializer();

class _$DepositExternalRequestCurrencyEnumSerializer
    implements PrimitiveSerializer<DepositExternalRequestCurrencyEnum> {
  static const Map<String, Object> _toWire = const <String, Object>{
    'MYR': 'MYR',
  };
  static const Map<Object, String> _fromWire = const <Object, String>{
    'MYR': 'MYR',
  };

  @override
  final Iterable<Type> types = const <Type>[DepositExternalRequestCurrencyEnum];
  @override
  final String wireName = 'DepositExternalRequestCurrencyEnum';

  @override
  Object serialize(
          Serializers serializers, DepositExternalRequestCurrencyEnum object,
          {FullType specifiedType = FullType.unspecified}) =>
      _toWire[object.name] ?? object.name;

  @override
  DepositExternalRequestCurrencyEnum deserialize(
          Serializers serializers, Object serialized,
          {FullType specifiedType = FullType.unspecified}) =>
      DepositExternalRequestCurrencyEnum.valueOf(
          _fromWire[serialized] ?? (serialized is String ? serialized : ''));
}

class _$DepositExternalRequest extends DepositExternalRequest {
  @override
  final num amount;
  @override
  final DepositExternalRequestCurrencyEnum currency;
  @override
  final String idempotencyKey;
  @override
  final String customerAccount;
  @override
  final String? customerName;
  @override
  final GeoLocation? location;

  factory _$DepositExternalRequest(
          [void Function(DepositExternalRequestBuilder)? updates]) =>
      (DepositExternalRequestBuilder()..update(updates))._build();

  _$DepositExternalRequest._(
      {required this.amount,
      required this.currency,
      required this.idempotencyKey,
      required this.customerAccount,
      this.customerName,
      this.location})
      : super._();
  @override
  DepositExternalRequest rebuild(
          void Function(DepositExternalRequestBuilder) updates) =>
      (toBuilder()..update(updates)).build();

  @override
  DepositExternalRequestBuilder toBuilder() =>
      DepositExternalRequestBuilder()..replace(this);

  @override
  bool operator ==(Object other) {
    if (identical(other, this)) return true;
    return other is DepositExternalRequest &&
        amount == other.amount &&
        currency == other.currency &&
        idempotencyKey == other.idempotencyKey &&
        customerAccount == other.customerAccount &&
        customerName == other.customerName &&
        location == other.location;
  }

  @override
  int get hashCode {
    var _$hash = 0;
    _$hash = $jc(_$hash, amount.hashCode);
    _$hash = $jc(_$hash, currency.hashCode);
    _$hash = $jc(_$hash, idempotencyKey.hashCode);
    _$hash = $jc(_$hash, customerAccount.hashCode);
    _$hash = $jc(_$hash, customerName.hashCode);
    _$hash = $jc(_$hash, location.hashCode);
    _$hash = $jf(_$hash);
    return _$hash;
  }

  @override
  String toString() {
    return (newBuiltValueToStringHelper(r'DepositExternalRequest')
          ..add('amount', amount)
          ..add('currency', currency)
          ..add('idempotencyKey', idempotencyKey)
          ..add('customerAccount', customerAccount)
          ..add('customerName', customerName)
          ..add('location', location))
        .toString();
  }
}

class DepositExternalRequestBuilder
    implements Builder<DepositExternalRequest, DepositExternalRequestBuilder> {
  _$DepositExternalRequest? _$v;

  num? _amount;
  num? get amount => _$this._amount;
  set amount(num? amount) => _$this._amount = amount;

  DepositExternalRequestCurrencyEnum? _currency;
  DepositExternalRequestCurrencyEnum? get currency => _$this._currency;
  set currency(DepositExternalRequestCurrencyEnum? currency) =>
      _$this._currency = currency;

  String? _idempotencyKey;
  String? get idempotencyKey => _$this._idempotencyKey;
  set idempotencyKey(String? idempotencyKey) =>
      _$this._idempotencyKey = idempotencyKey;

  String? _customerAccount;
  String? get customerAccount => _$this._customerAccount;
  set customerAccount(String? customerAccount) =>
      _$this._customerAccount = customerAccount;

  String? _customerName;
  String? get customerName => _$this._customerName;
  set customerName(String? customerName) => _$this._customerName = customerName;

  GeoLocationBuilder? _location;
  GeoLocationBuilder get location => _$this._location ??= GeoLocationBuilder();
  set location(GeoLocationBuilder? location) => _$this._location = location;

  DepositExternalRequestBuilder() {
    DepositExternalRequest._defaults(this);
  }

  DepositExternalRequestBuilder get _$this {
    final $v = _$v;
    if ($v != null) {
      _amount = $v.amount;
      _currency = $v.currency;
      _idempotencyKey = $v.idempotencyKey;
      _customerAccount = $v.customerAccount;
      _customerName = $v.customerName;
      _location = $v.location?.toBuilder();
      _$v = null;
    }
    return this;
  }

  @override
  void replace(DepositExternalRequest other) {
    _$v = other as _$DepositExternalRequest;
  }

  @override
  void update(void Function(DepositExternalRequestBuilder)? updates) {
    if (updates != null) updates(this);
  }

  @override
  DepositExternalRequest build() => _build();

  _$DepositExternalRequest _build() {
    _$DepositExternalRequest _$result;
    try {
      _$result = _$v ??
          _$DepositExternalRequest._(
            amount: BuiltValueNullFieldError.checkNotNull(
                amount, r'DepositExternalRequest', 'amount'),
            currency: BuiltValueNullFieldError.checkNotNull(
                currency, r'DepositExternalRequest', 'currency'),
            idempotencyKey: BuiltValueNullFieldError.checkNotNull(
                idempotencyKey, r'DepositExternalRequest', 'idempotencyKey'),
            customerAccount: BuiltValueNullFieldError.checkNotNull(
                customerAccount, r'DepositExternalRequest', 'customerAccount'),
            customerName: customerName,
            location: _location?.build(),
          );
    } catch (_) {
      late String _$failedField;
      try {
        _$failedField = 'location';
        _location?.build();
      } catch (e) {
        throw BuiltValueNestedFieldError(
            r'DepositExternalRequest', _$failedField, e.toString());
      }
      rethrow;
    }
    replace(_$result);
    return _$result;
  }
}

// ignore_for_file: deprecated_member_use_from_same_package,type=lint
