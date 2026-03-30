// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'e_wallet_withdraw_external_request.dart';

// **************************************************************************
// BuiltValueGenerator
// **************************************************************************

const EWalletWithdrawExternalRequestWalletProviderEnum
    _$eWalletWithdrawExternalRequestWalletProviderEnum_SARAWAK_PAY =
    const EWalletWithdrawExternalRequestWalletProviderEnum._('SARAWAK_PAY');
const EWalletWithdrawExternalRequestWalletProviderEnum
    _$eWalletWithdrawExternalRequestWalletProviderEnum_SARAWAK_TOPUP =
    const EWalletWithdrawExternalRequestWalletProviderEnum._('SARAWAK_TOPUP');

EWalletWithdrawExternalRequestWalletProviderEnum
    _$eWalletWithdrawExternalRequestWalletProviderEnumValueOf(String name) {
  switch (name) {
    case 'SARAWAK_PAY':
      return _$eWalletWithdrawExternalRequestWalletProviderEnum_SARAWAK_PAY;
    case 'SARAWAK_TOPUP':
      return _$eWalletWithdrawExternalRequestWalletProviderEnum_SARAWAK_TOPUP;
    default:
      throw ArgumentError(name);
  }
}

final BuiltSet<EWalletWithdrawExternalRequestWalletProviderEnum>
    _$eWalletWithdrawExternalRequestWalletProviderEnumValues = BuiltSet<
        EWalletWithdrawExternalRequestWalletProviderEnum>(const <EWalletWithdrawExternalRequestWalletProviderEnum>[
  _$eWalletWithdrawExternalRequestWalletProviderEnum_SARAWAK_PAY,
  _$eWalletWithdrawExternalRequestWalletProviderEnum_SARAWAK_TOPUP,
]);

const EWalletWithdrawExternalRequestCurrencyEnum
    _$eWalletWithdrawExternalRequestCurrencyEnum_MYR =
    const EWalletWithdrawExternalRequestCurrencyEnum._('MYR');

EWalletWithdrawExternalRequestCurrencyEnum
    _$eWalletWithdrawExternalRequestCurrencyEnumValueOf(String name) {
  switch (name) {
    case 'MYR':
      return _$eWalletWithdrawExternalRequestCurrencyEnum_MYR;
    default:
      throw ArgumentError(name);
  }
}

final BuiltSet<EWalletWithdrawExternalRequestCurrencyEnum>
    _$eWalletWithdrawExternalRequestCurrencyEnumValues = BuiltSet<
        EWalletWithdrawExternalRequestCurrencyEnum>(const <EWalletWithdrawExternalRequestCurrencyEnum>[
  _$eWalletWithdrawExternalRequestCurrencyEnum_MYR,
]);

Serializer<EWalletWithdrawExternalRequestWalletProviderEnum>
    _$eWalletWithdrawExternalRequestWalletProviderEnumSerializer =
    _$EWalletWithdrawExternalRequestWalletProviderEnumSerializer();
Serializer<EWalletWithdrawExternalRequestCurrencyEnum>
    _$eWalletWithdrawExternalRequestCurrencyEnumSerializer =
    _$EWalletWithdrawExternalRequestCurrencyEnumSerializer();

class _$EWalletWithdrawExternalRequestWalletProviderEnumSerializer
    implements
        PrimitiveSerializer<EWalletWithdrawExternalRequestWalletProviderEnum> {
  static const Map<String, Object> _toWire = const <String, Object>{
    'SARAWAK_PAY': 'SARAWAK_PAY',
    'SARAWAK_TOPUP': 'SARAWAK_TOPUP',
  };
  static const Map<Object, String> _fromWire = const <Object, String>{
    'SARAWAK_PAY': 'SARAWAK_PAY',
    'SARAWAK_TOPUP': 'SARAWAK_TOPUP',
  };

  @override
  final Iterable<Type> types = const <Type>[
    EWalletWithdrawExternalRequestWalletProviderEnum
  ];
  @override
  final String wireName = 'EWalletWithdrawExternalRequestWalletProviderEnum';

  @override
  Object serialize(Serializers serializers,
          EWalletWithdrawExternalRequestWalletProviderEnum object,
          {FullType specifiedType = FullType.unspecified}) =>
      _toWire[object.name] ?? object.name;

  @override
  EWalletWithdrawExternalRequestWalletProviderEnum deserialize(
          Serializers serializers, Object serialized,
          {FullType specifiedType = FullType.unspecified}) =>
      EWalletWithdrawExternalRequestWalletProviderEnum.valueOf(
          _fromWire[serialized] ?? (serialized is String ? serialized : ''));
}

class _$EWalletWithdrawExternalRequestCurrencyEnumSerializer
    implements PrimitiveSerializer<EWalletWithdrawExternalRequestCurrencyEnum> {
  static const Map<String, Object> _toWire = const <String, Object>{
    'MYR': 'MYR',
  };
  static const Map<Object, String> _fromWire = const <Object, String>{
    'MYR': 'MYR',
  };

  @override
  final Iterable<Type> types = const <Type>[
    EWalletWithdrawExternalRequestCurrencyEnum
  ];
  @override
  final String wireName = 'EWalletWithdrawExternalRequestCurrencyEnum';

  @override
  Object serialize(Serializers serializers,
          EWalletWithdrawExternalRequestCurrencyEnum object,
          {FullType specifiedType = FullType.unspecified}) =>
      _toWire[object.name] ?? object.name;

  @override
  EWalletWithdrawExternalRequestCurrencyEnum deserialize(
          Serializers serializers, Object serialized,
          {FullType specifiedType = FullType.unspecified}) =>
      EWalletWithdrawExternalRequestCurrencyEnum.valueOf(
          _fromWire[serialized] ?? (serialized is String ? serialized : ''));
}

class _$EWalletWithdrawExternalRequest extends EWalletWithdrawExternalRequest {
  @override
  final EWalletWithdrawExternalRequestWalletProviderEnum walletProvider;
  @override
  final String walletAccountId;
  @override
  final num amount;
  @override
  final EWalletWithdrawExternalRequestCurrencyEnum currency;
  @override
  final String idempotencyKey;
  @override
  final String? customerCard;
  @override
  final String? customerPin;

  factory _$EWalletWithdrawExternalRequest(
          [void Function(EWalletWithdrawExternalRequestBuilder)? updates]) =>
      (EWalletWithdrawExternalRequestBuilder()..update(updates))._build();

  _$EWalletWithdrawExternalRequest._(
      {required this.walletProvider,
      required this.walletAccountId,
      required this.amount,
      required this.currency,
      required this.idempotencyKey,
      this.customerCard,
      this.customerPin})
      : super._();
  @override
  EWalletWithdrawExternalRequest rebuild(
          void Function(EWalletWithdrawExternalRequestBuilder) updates) =>
      (toBuilder()..update(updates)).build();

  @override
  EWalletWithdrawExternalRequestBuilder toBuilder() =>
      EWalletWithdrawExternalRequestBuilder()..replace(this);

  @override
  bool operator ==(Object other) {
    if (identical(other, this)) return true;
    return other is EWalletWithdrawExternalRequest &&
        walletProvider == other.walletProvider &&
        walletAccountId == other.walletAccountId &&
        amount == other.amount &&
        currency == other.currency &&
        idempotencyKey == other.idempotencyKey &&
        customerCard == other.customerCard &&
        customerPin == other.customerPin;
  }

  @override
  int get hashCode {
    var _$hash = 0;
    _$hash = $jc(_$hash, walletProvider.hashCode);
    _$hash = $jc(_$hash, walletAccountId.hashCode);
    _$hash = $jc(_$hash, amount.hashCode);
    _$hash = $jc(_$hash, currency.hashCode);
    _$hash = $jc(_$hash, idempotencyKey.hashCode);
    _$hash = $jc(_$hash, customerCard.hashCode);
    _$hash = $jc(_$hash, customerPin.hashCode);
    _$hash = $jf(_$hash);
    return _$hash;
  }

  @override
  String toString() {
    return (newBuiltValueToStringHelper(r'EWalletWithdrawExternalRequest')
          ..add('walletProvider', walletProvider)
          ..add('walletAccountId', walletAccountId)
          ..add('amount', amount)
          ..add('currency', currency)
          ..add('idempotencyKey', idempotencyKey)
          ..add('customerCard', customerCard)
          ..add('customerPin', customerPin))
        .toString();
  }
}

class EWalletWithdrawExternalRequestBuilder
    implements
        Builder<EWalletWithdrawExternalRequest,
            EWalletWithdrawExternalRequestBuilder> {
  _$EWalletWithdrawExternalRequest? _$v;

  EWalletWithdrawExternalRequestWalletProviderEnum? _walletProvider;
  EWalletWithdrawExternalRequestWalletProviderEnum? get walletProvider =>
      _$this._walletProvider;
  set walletProvider(
          EWalletWithdrawExternalRequestWalletProviderEnum? walletProvider) =>
      _$this._walletProvider = walletProvider;

  String? _walletAccountId;
  String? get walletAccountId => _$this._walletAccountId;
  set walletAccountId(String? walletAccountId) =>
      _$this._walletAccountId = walletAccountId;

  num? _amount;
  num? get amount => _$this._amount;
  set amount(num? amount) => _$this._amount = amount;

  EWalletWithdrawExternalRequestCurrencyEnum? _currency;
  EWalletWithdrawExternalRequestCurrencyEnum? get currency => _$this._currency;
  set currency(EWalletWithdrawExternalRequestCurrencyEnum? currency) =>
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

  EWalletWithdrawExternalRequestBuilder() {
    EWalletWithdrawExternalRequest._defaults(this);
  }

  EWalletWithdrawExternalRequestBuilder get _$this {
    final $v = _$v;
    if ($v != null) {
      _walletProvider = $v.walletProvider;
      _walletAccountId = $v.walletAccountId;
      _amount = $v.amount;
      _currency = $v.currency;
      _idempotencyKey = $v.idempotencyKey;
      _customerCard = $v.customerCard;
      _customerPin = $v.customerPin;
      _$v = null;
    }
    return this;
  }

  @override
  void replace(EWalletWithdrawExternalRequest other) {
    _$v = other as _$EWalletWithdrawExternalRequest;
  }

  @override
  void update(void Function(EWalletWithdrawExternalRequestBuilder)? updates) {
    if (updates != null) updates(this);
  }

  @override
  EWalletWithdrawExternalRequest build() => _build();

  _$EWalletWithdrawExternalRequest _build() {
    final _$result = _$v ??
        _$EWalletWithdrawExternalRequest._(
          walletProvider: BuiltValueNullFieldError.checkNotNull(walletProvider,
              r'EWalletWithdrawExternalRequest', 'walletProvider'),
          walletAccountId: BuiltValueNullFieldError.checkNotNull(
              walletAccountId,
              r'EWalletWithdrawExternalRequest',
              'walletAccountId'),
          amount: BuiltValueNullFieldError.checkNotNull(
              amount, r'EWalletWithdrawExternalRequest', 'amount'),
          currency: BuiltValueNullFieldError.checkNotNull(
              currency, r'EWalletWithdrawExternalRequest', 'currency'),
          idempotencyKey: BuiltValueNullFieldError.checkNotNull(idempotencyKey,
              r'EWalletWithdrawExternalRequest', 'idempotencyKey'),
          customerCard: customerCard,
          customerPin: customerPin,
        );
    replace(_$result);
    return _$result;
  }
}

// ignore_for_file: deprecated_member_use_from_same_package,type=lint
