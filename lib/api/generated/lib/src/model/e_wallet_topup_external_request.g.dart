// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'e_wallet_topup_external_request.dart';

// **************************************************************************
// BuiltValueGenerator
// **************************************************************************

const EWalletTopupExternalRequestWalletProviderEnum
    _$eWalletTopupExternalRequestWalletProviderEnum_SARAWAK_PAY =
    const EWalletTopupExternalRequestWalletProviderEnum._('SARAWAK_PAY');
const EWalletTopupExternalRequestWalletProviderEnum
    _$eWalletTopupExternalRequestWalletProviderEnum_SARAWAK_TOPUP =
    const EWalletTopupExternalRequestWalletProviderEnum._('SARAWAK_TOPUP');

EWalletTopupExternalRequestWalletProviderEnum
    _$eWalletTopupExternalRequestWalletProviderEnumValueOf(String name) {
  switch (name) {
    case 'SARAWAK_PAY':
      return _$eWalletTopupExternalRequestWalletProviderEnum_SARAWAK_PAY;
    case 'SARAWAK_TOPUP':
      return _$eWalletTopupExternalRequestWalletProviderEnum_SARAWAK_TOPUP;
    default:
      throw ArgumentError(name);
  }
}

final BuiltSet<EWalletTopupExternalRequestWalletProviderEnum>
    _$eWalletTopupExternalRequestWalletProviderEnumValues = BuiltSet<
        EWalletTopupExternalRequestWalletProviderEnum>(const <EWalletTopupExternalRequestWalletProviderEnum>[
  _$eWalletTopupExternalRequestWalletProviderEnum_SARAWAK_PAY,
  _$eWalletTopupExternalRequestWalletProviderEnum_SARAWAK_TOPUP,
]);

const EWalletTopupExternalRequestCurrencyEnum
    _$eWalletTopupExternalRequestCurrencyEnum_MYR =
    const EWalletTopupExternalRequestCurrencyEnum._('MYR');

EWalletTopupExternalRequestCurrencyEnum
    _$eWalletTopupExternalRequestCurrencyEnumValueOf(String name) {
  switch (name) {
    case 'MYR':
      return _$eWalletTopupExternalRequestCurrencyEnum_MYR;
    default:
      throw ArgumentError(name);
  }
}

final BuiltSet<EWalletTopupExternalRequestCurrencyEnum>
    _$eWalletTopupExternalRequestCurrencyEnumValues = BuiltSet<
        EWalletTopupExternalRequestCurrencyEnum>(const <EWalletTopupExternalRequestCurrencyEnum>[
  _$eWalletTopupExternalRequestCurrencyEnum_MYR,
]);

Serializer<EWalletTopupExternalRequestWalletProviderEnum>
    _$eWalletTopupExternalRequestWalletProviderEnumSerializer =
    _$EWalletTopupExternalRequestWalletProviderEnumSerializer();
Serializer<EWalletTopupExternalRequestCurrencyEnum>
    _$eWalletTopupExternalRequestCurrencyEnumSerializer =
    _$EWalletTopupExternalRequestCurrencyEnumSerializer();

class _$EWalletTopupExternalRequestWalletProviderEnumSerializer
    implements
        PrimitiveSerializer<EWalletTopupExternalRequestWalletProviderEnum> {
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
    EWalletTopupExternalRequestWalletProviderEnum
  ];
  @override
  final String wireName = 'EWalletTopupExternalRequestWalletProviderEnum';

  @override
  Object serialize(Serializers serializers,
          EWalletTopupExternalRequestWalletProviderEnum object,
          {FullType specifiedType = FullType.unspecified}) =>
      _toWire[object.name] ?? object.name;

  @override
  EWalletTopupExternalRequestWalletProviderEnum deserialize(
          Serializers serializers, Object serialized,
          {FullType specifiedType = FullType.unspecified}) =>
      EWalletTopupExternalRequestWalletProviderEnum.valueOf(
          _fromWire[serialized] ?? (serialized is String ? serialized : ''));
}

class _$EWalletTopupExternalRequestCurrencyEnumSerializer
    implements PrimitiveSerializer<EWalletTopupExternalRequestCurrencyEnum> {
  static const Map<String, Object> _toWire = const <String, Object>{
    'MYR': 'MYR',
  };
  static const Map<Object, String> _fromWire = const <Object, String>{
    'MYR': 'MYR',
  };

  @override
  final Iterable<Type> types = const <Type>[
    EWalletTopupExternalRequestCurrencyEnum
  ];
  @override
  final String wireName = 'EWalletTopupExternalRequestCurrencyEnum';

  @override
  Object serialize(Serializers serializers,
          EWalletTopupExternalRequestCurrencyEnum object,
          {FullType specifiedType = FullType.unspecified}) =>
      _toWire[object.name] ?? object.name;

  @override
  EWalletTopupExternalRequestCurrencyEnum deserialize(
          Serializers serializers, Object serialized,
          {FullType specifiedType = FullType.unspecified}) =>
      EWalletTopupExternalRequestCurrencyEnum.valueOf(
          _fromWire[serialized] ?? (serialized is String ? serialized : ''));
}

class _$EWalletTopupExternalRequest extends EWalletTopupExternalRequest {
  @override
  final EWalletTopupExternalRequestWalletProviderEnum walletProvider;
  @override
  final String walletAccountId;
  @override
  final String amount;
  @override
  final EWalletTopupExternalRequestCurrencyEnum currency;
  @override
  final String idempotencyKey;

  factory _$EWalletTopupExternalRequest(
          [void Function(EWalletTopupExternalRequestBuilder)? updates]) =>
      (EWalletTopupExternalRequestBuilder()..update(updates))._build();

  _$EWalletTopupExternalRequest._(
      {required this.walletProvider,
      required this.walletAccountId,
      required this.amount,
      required this.currency,
      required this.idempotencyKey})
      : super._();
  @override
  EWalletTopupExternalRequest rebuild(
          void Function(EWalletTopupExternalRequestBuilder) updates) =>
      (toBuilder()..update(updates)).build();

  @override
  EWalletTopupExternalRequestBuilder toBuilder() =>
      EWalletTopupExternalRequestBuilder()..replace(this);

  @override
  bool operator ==(Object other) {
    if (identical(other, this)) return true;
    return other is EWalletTopupExternalRequest &&
        walletProvider == other.walletProvider &&
        walletAccountId == other.walletAccountId &&
        amount == other.amount &&
        currency == other.currency &&
        idempotencyKey == other.idempotencyKey;
  }

  @override
  int get hashCode {
    var _$hash = 0;
    _$hash = $jc(_$hash, walletProvider.hashCode);
    _$hash = $jc(_$hash, walletAccountId.hashCode);
    _$hash = $jc(_$hash, amount.hashCode);
    _$hash = $jc(_$hash, currency.hashCode);
    _$hash = $jc(_$hash, idempotencyKey.hashCode);
    _$hash = $jf(_$hash);
    return _$hash;
  }

  @override
  String toString() {
    return (newBuiltValueToStringHelper(r'EWalletTopupExternalRequest')
          ..add('walletProvider', walletProvider)
          ..add('walletAccountId', walletAccountId)
          ..add('amount', amount)
          ..add('currency', currency)
          ..add('idempotencyKey', idempotencyKey))
        .toString();
  }
}

class EWalletTopupExternalRequestBuilder
    implements
        Builder<EWalletTopupExternalRequest,
            EWalletTopupExternalRequestBuilder> {
  _$EWalletTopupExternalRequest? _$v;

  EWalletTopupExternalRequestWalletProviderEnum? _walletProvider;
  EWalletTopupExternalRequestWalletProviderEnum? get walletProvider =>
      _$this._walletProvider;
  set walletProvider(
          EWalletTopupExternalRequestWalletProviderEnum? walletProvider) =>
      _$this._walletProvider = walletProvider;

  String? _walletAccountId;
  String? get walletAccountId => _$this._walletAccountId;
  set walletAccountId(String? walletAccountId) =>
      _$this._walletAccountId = walletAccountId;

  String? _amount;
  String? get amount => _$this._amount;
  set amount(String? amount) => _$this._amount = amount;

  EWalletTopupExternalRequestCurrencyEnum? _currency;
  EWalletTopupExternalRequestCurrencyEnum? get currency => _$this._currency;
  set currency(EWalletTopupExternalRequestCurrencyEnum? currency) =>
      _$this._currency = currency;

  String? _idempotencyKey;
  String? get idempotencyKey => _$this._idempotencyKey;
  set idempotencyKey(String? idempotencyKey) =>
      _$this._idempotencyKey = idempotencyKey;

  EWalletTopupExternalRequestBuilder() {
    EWalletTopupExternalRequest._defaults(this);
  }

  EWalletTopupExternalRequestBuilder get _$this {
    final $v = _$v;
    if ($v != null) {
      _walletProvider = $v.walletProvider;
      _walletAccountId = $v.walletAccountId;
      _amount = $v.amount;
      _currency = $v.currency;
      _idempotencyKey = $v.idempotencyKey;
      _$v = null;
    }
    return this;
  }

  @override
  void replace(EWalletTopupExternalRequest other) {
    _$v = other as _$EWalletTopupExternalRequest;
  }

  @override
  void update(void Function(EWalletTopupExternalRequestBuilder)? updates) {
    if (updates != null) updates(this);
  }

  @override
  EWalletTopupExternalRequest build() => _build();

  _$EWalletTopupExternalRequest _build() {
    final _$result = _$v ??
        _$EWalletTopupExternalRequest._(
          walletProvider: BuiltValueNullFieldError.checkNotNull(
              walletProvider, r'EWalletTopupExternalRequest', 'walletProvider'),
          walletAccountId: BuiltValueNullFieldError.checkNotNull(
              walletAccountId,
              r'EWalletTopupExternalRequest',
              'walletAccountId'),
          amount: BuiltValueNullFieldError.checkNotNull(
              amount, r'EWalletTopupExternalRequest', 'amount'),
          currency: BuiltValueNullFieldError.checkNotNull(
              currency, r'EWalletTopupExternalRequest', 'currency'),
          idempotencyKey: BuiltValueNullFieldError.checkNotNull(
              idempotencyKey, r'EWalletTopupExternalRequest', 'idempotencyKey'),
        );
    replace(_$result);
    return _$result;
  }
}

// ignore_for_file: deprecated_member_use_from_same_package,type=lint
