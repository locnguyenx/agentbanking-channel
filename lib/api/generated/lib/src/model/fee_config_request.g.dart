// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'fee_config_request.dart';

// **************************************************************************
// BuiltValueGenerator
// **************************************************************************

const FeeConfigRequestAgentTypeEnum _$feeConfigRequestAgentTypeEnum_MICRO =
    const FeeConfigRequestAgentTypeEnum._('MICRO');
const FeeConfigRequestAgentTypeEnum _$feeConfigRequestAgentTypeEnum_STANDARD =
    const FeeConfigRequestAgentTypeEnum._('STANDARD');
const FeeConfigRequestAgentTypeEnum _$feeConfigRequestAgentTypeEnum_PREMIER =
    const FeeConfigRequestAgentTypeEnum._('PREMIER');

FeeConfigRequestAgentTypeEnum _$feeConfigRequestAgentTypeEnumValueOf(
    String name) {
  switch (name) {
    case 'MICRO':
      return _$feeConfigRequestAgentTypeEnum_MICRO;
    case 'STANDARD':
      return _$feeConfigRequestAgentTypeEnum_STANDARD;
    case 'PREMIER':
      return _$feeConfigRequestAgentTypeEnum_PREMIER;
    default:
      throw ArgumentError(name);
  }
}

final BuiltSet<FeeConfigRequestAgentTypeEnum>
    _$feeConfigRequestAgentTypeEnumValues = BuiltSet<
        FeeConfigRequestAgentTypeEnum>(const <FeeConfigRequestAgentTypeEnum>[
  _$feeConfigRequestAgentTypeEnum_MICRO,
  _$feeConfigRequestAgentTypeEnum_STANDARD,
  _$feeConfigRequestAgentTypeEnum_PREMIER,
]);

const FeeConfigRequestTransactionTypeEnum
    _$feeConfigRequestTransactionTypeEnum_CASH_WITHDRAWAL =
    const FeeConfigRequestTransactionTypeEnum._('CASH_WITHDRAWAL');
const FeeConfigRequestTransactionTypeEnum
    _$feeConfigRequestTransactionTypeEnum_CASH_DEPOSIT =
    const FeeConfigRequestTransactionTypeEnum._('CASH_DEPOSIT');
const FeeConfigRequestTransactionTypeEnum
    _$feeConfigRequestTransactionTypeEnum_BALANCE_INQUIRY =
    const FeeConfigRequestTransactionTypeEnum._('BALANCE_INQUIRY');
const FeeConfigRequestTransactionTypeEnum
    _$feeConfigRequestTransactionTypeEnum_DUITNOW_TRANSFER =
    const FeeConfigRequestTransactionTypeEnum._('DUITNOW_TRANSFER');
const FeeConfigRequestTransactionTypeEnum
    _$feeConfigRequestTransactionTypeEnum_JOMPAY =
    const FeeConfigRequestTransactionTypeEnum._('JOMPAY');
const FeeConfigRequestTransactionTypeEnum
    _$feeConfigRequestTransactionTypeEnum_CELCOM_TOPUP =
    const FeeConfigRequestTransactionTypeEnum._('CELCOM_TOPUP');
const FeeConfigRequestTransactionTypeEnum
    _$feeConfigRequestTransactionTypeEnum_m1TOPUP =
    const FeeConfigRequestTransactionTypeEnum._('m1TOPUP');
const FeeConfigRequestTransactionTypeEnum
    _$feeConfigRequestTransactionTypeEnum_ESSP_PURCHASE =
    const FeeConfigRequestTransactionTypeEnum._('ESSP_PURCHASE');
const FeeConfigRequestTransactionTypeEnum
    _$feeConfigRequestTransactionTypeEnum_PIN_PURCHASE =
    const FeeConfigRequestTransactionTypeEnum._('PIN_PURCHASE');

FeeConfigRequestTransactionTypeEnum
    _$feeConfigRequestTransactionTypeEnumValueOf(String name) {
  switch (name) {
    case 'CASH_WITHDRAWAL':
      return _$feeConfigRequestTransactionTypeEnum_CASH_WITHDRAWAL;
    case 'CASH_DEPOSIT':
      return _$feeConfigRequestTransactionTypeEnum_CASH_DEPOSIT;
    case 'BALANCE_INQUIRY':
      return _$feeConfigRequestTransactionTypeEnum_BALANCE_INQUIRY;
    case 'DUITNOW_TRANSFER':
      return _$feeConfigRequestTransactionTypeEnum_DUITNOW_TRANSFER;
    case 'JOMPAY':
      return _$feeConfigRequestTransactionTypeEnum_JOMPAY;
    case 'CELCOM_TOPUP':
      return _$feeConfigRequestTransactionTypeEnum_CELCOM_TOPUP;
    case 'm1TOPUP':
      return _$feeConfigRequestTransactionTypeEnum_m1TOPUP;
    case 'ESSP_PURCHASE':
      return _$feeConfigRequestTransactionTypeEnum_ESSP_PURCHASE;
    case 'PIN_PURCHASE':
      return _$feeConfigRequestTransactionTypeEnum_PIN_PURCHASE;
    default:
      throw ArgumentError(name);
  }
}

final BuiltSet<FeeConfigRequestTransactionTypeEnum>
    _$feeConfigRequestTransactionTypeEnumValues = BuiltSet<
        FeeConfigRequestTransactionTypeEnum>(const <FeeConfigRequestTransactionTypeEnum>[
  _$feeConfigRequestTransactionTypeEnum_CASH_WITHDRAWAL,
  _$feeConfigRequestTransactionTypeEnum_CASH_DEPOSIT,
  _$feeConfigRequestTransactionTypeEnum_BALANCE_INQUIRY,
  _$feeConfigRequestTransactionTypeEnum_DUITNOW_TRANSFER,
  _$feeConfigRequestTransactionTypeEnum_JOMPAY,
  _$feeConfigRequestTransactionTypeEnum_CELCOM_TOPUP,
  _$feeConfigRequestTransactionTypeEnum_m1TOPUP,
  _$feeConfigRequestTransactionTypeEnum_ESSP_PURCHASE,
  _$feeConfigRequestTransactionTypeEnum_PIN_PURCHASE,
]);

const FeeConfigRequestFeeTypeEnum _$feeConfigRequestFeeTypeEnum_FIXED =
    const FeeConfigRequestFeeTypeEnum._('FIXED');
const FeeConfigRequestFeeTypeEnum _$feeConfigRequestFeeTypeEnum_PERCENTAGE =
    const FeeConfigRequestFeeTypeEnum._('PERCENTAGE');

FeeConfigRequestFeeTypeEnum _$feeConfigRequestFeeTypeEnumValueOf(String name) {
  switch (name) {
    case 'FIXED':
      return _$feeConfigRequestFeeTypeEnum_FIXED;
    case 'PERCENTAGE':
      return _$feeConfigRequestFeeTypeEnum_PERCENTAGE;
    default:
      throw ArgumentError(name);
  }
}

final BuiltSet<FeeConfigRequestFeeTypeEnum>
    _$feeConfigRequestFeeTypeEnumValues =
    BuiltSet<FeeConfigRequestFeeTypeEnum>(const <FeeConfigRequestFeeTypeEnum>[
  _$feeConfigRequestFeeTypeEnum_FIXED,
  _$feeConfigRequestFeeTypeEnum_PERCENTAGE,
]);

const FeeConfigRequestCurrencyEnum _$feeConfigRequestCurrencyEnum_MYR =
    const FeeConfigRequestCurrencyEnum._('MYR');

FeeConfigRequestCurrencyEnum _$feeConfigRequestCurrencyEnumValueOf(
    String name) {
  switch (name) {
    case 'MYR':
      return _$feeConfigRequestCurrencyEnum_MYR;
    default:
      throw ArgumentError(name);
  }
}

final BuiltSet<FeeConfigRequestCurrencyEnum>
    _$feeConfigRequestCurrencyEnumValues =
    BuiltSet<FeeConfigRequestCurrencyEnum>(const <FeeConfigRequestCurrencyEnum>[
  _$feeConfigRequestCurrencyEnum_MYR,
]);

Serializer<FeeConfigRequestAgentTypeEnum>
    _$feeConfigRequestAgentTypeEnumSerializer =
    _$FeeConfigRequestAgentTypeEnumSerializer();
Serializer<FeeConfigRequestTransactionTypeEnum>
    _$feeConfigRequestTransactionTypeEnumSerializer =
    _$FeeConfigRequestTransactionTypeEnumSerializer();
Serializer<FeeConfigRequestFeeTypeEnum>
    _$feeConfigRequestFeeTypeEnumSerializer =
    _$FeeConfigRequestFeeTypeEnumSerializer();
Serializer<FeeConfigRequestCurrencyEnum>
    _$feeConfigRequestCurrencyEnumSerializer =
    _$FeeConfigRequestCurrencyEnumSerializer();

class _$FeeConfigRequestAgentTypeEnumSerializer
    implements PrimitiveSerializer<FeeConfigRequestAgentTypeEnum> {
  static const Map<String, Object> _toWire = const <String, Object>{
    'MICRO': 'MICRO',
    'STANDARD': 'STANDARD',
    'PREMIER': 'PREMIER',
  };
  static const Map<Object, String> _fromWire = const <Object, String>{
    'MICRO': 'MICRO',
    'STANDARD': 'STANDARD',
    'PREMIER': 'PREMIER',
  };

  @override
  final Iterable<Type> types = const <Type>[FeeConfigRequestAgentTypeEnum];
  @override
  final String wireName = 'FeeConfigRequestAgentTypeEnum';

  @override
  Object serialize(
          Serializers serializers, FeeConfigRequestAgentTypeEnum object,
          {FullType specifiedType = FullType.unspecified}) =>
      _toWire[object.name] ?? object.name;

  @override
  FeeConfigRequestAgentTypeEnum deserialize(
          Serializers serializers, Object serialized,
          {FullType specifiedType = FullType.unspecified}) =>
      FeeConfigRequestAgentTypeEnum.valueOf(
          _fromWire[serialized] ?? (serialized is String ? serialized : ''));
}

class _$FeeConfigRequestTransactionTypeEnumSerializer
    implements PrimitiveSerializer<FeeConfigRequestTransactionTypeEnum> {
  static const Map<String, Object> _toWire = const <String, Object>{
    'CASH_WITHDRAWAL': 'CASH_WITHDRAWAL',
    'CASH_DEPOSIT': 'CASH_DEPOSIT',
    'BALANCE_INQUIRY': 'BALANCE_INQUIRY',
    'DUITNOW_TRANSFER': 'DUITNOW_TRANSFER',
    'JOMPAY': 'JOMPAY',
    'CELCOM_TOPUP': 'CELCOM_TOPUP',
    'm1TOPUP': 'M1_TOPUP',
    'ESSP_PURCHASE': 'ESSP_PURCHASE',
    'PIN_PURCHASE': 'PIN_PURCHASE',
  };
  static const Map<Object, String> _fromWire = const <Object, String>{
    'CASH_WITHDRAWAL': 'CASH_WITHDRAWAL',
    'CASH_DEPOSIT': 'CASH_DEPOSIT',
    'BALANCE_INQUIRY': 'BALANCE_INQUIRY',
    'DUITNOW_TRANSFER': 'DUITNOW_TRANSFER',
    'JOMPAY': 'JOMPAY',
    'CELCOM_TOPUP': 'CELCOM_TOPUP',
    'M1_TOPUP': 'm1TOPUP',
    'ESSP_PURCHASE': 'ESSP_PURCHASE',
    'PIN_PURCHASE': 'PIN_PURCHASE',
  };

  @override
  final Iterable<Type> types = const <Type>[
    FeeConfigRequestTransactionTypeEnum
  ];
  @override
  final String wireName = 'FeeConfigRequestTransactionTypeEnum';

  @override
  Object serialize(
          Serializers serializers, FeeConfigRequestTransactionTypeEnum object,
          {FullType specifiedType = FullType.unspecified}) =>
      _toWire[object.name] ?? object.name;

  @override
  FeeConfigRequestTransactionTypeEnum deserialize(
          Serializers serializers, Object serialized,
          {FullType specifiedType = FullType.unspecified}) =>
      FeeConfigRequestTransactionTypeEnum.valueOf(
          _fromWire[serialized] ?? (serialized is String ? serialized : ''));
}

class _$FeeConfigRequestFeeTypeEnumSerializer
    implements PrimitiveSerializer<FeeConfigRequestFeeTypeEnum> {
  static const Map<String, Object> _toWire = const <String, Object>{
    'FIXED': 'FIXED',
    'PERCENTAGE': 'PERCENTAGE',
  };
  static const Map<Object, String> _fromWire = const <Object, String>{
    'FIXED': 'FIXED',
    'PERCENTAGE': 'PERCENTAGE',
  };

  @override
  final Iterable<Type> types = const <Type>[FeeConfigRequestFeeTypeEnum];
  @override
  final String wireName = 'FeeConfigRequestFeeTypeEnum';

  @override
  Object serialize(Serializers serializers, FeeConfigRequestFeeTypeEnum object,
          {FullType specifiedType = FullType.unspecified}) =>
      _toWire[object.name] ?? object.name;

  @override
  FeeConfigRequestFeeTypeEnum deserialize(
          Serializers serializers, Object serialized,
          {FullType specifiedType = FullType.unspecified}) =>
      FeeConfigRequestFeeTypeEnum.valueOf(
          _fromWire[serialized] ?? (serialized is String ? serialized : ''));
}

class _$FeeConfigRequestCurrencyEnumSerializer
    implements PrimitiveSerializer<FeeConfigRequestCurrencyEnum> {
  static const Map<String, Object> _toWire = const <String, Object>{
    'MYR': 'MYR',
  };
  static const Map<Object, String> _fromWire = const <Object, String>{
    'MYR': 'MYR',
  };

  @override
  final Iterable<Type> types = const <Type>[FeeConfigRequestCurrencyEnum];
  @override
  final String wireName = 'FeeConfigRequestCurrencyEnum';

  @override
  Object serialize(Serializers serializers, FeeConfigRequestCurrencyEnum object,
          {FullType specifiedType = FullType.unspecified}) =>
      _toWire[object.name] ?? object.name;

  @override
  FeeConfigRequestCurrencyEnum deserialize(
          Serializers serializers, Object serialized,
          {FullType specifiedType = FullType.unspecified}) =>
      FeeConfigRequestCurrencyEnum.valueOf(
          _fromWire[serialized] ?? (serialized is String ? serialized : ''));
}

class _$FeeConfigRequest extends FeeConfigRequest {
  @override
  final FeeConfigRequestAgentTypeEnum agentType;
  @override
  final FeeConfigRequestTransactionTypeEnum transactionType;
  @override
  final FeeConfigRequestFeeTypeEnum feeType;
  @override
  final num? feeAmount;
  @override
  final num? percentage;
  @override
  final num? minFee;
  @override
  final num? maxFee;
  @override
  final FeeConfigRequestCurrencyEnum currency;
  @override
  final DateTime effectiveFrom;
  @override
  final DateTime? effectiveTo;

  factory _$FeeConfigRequest(
          [void Function(FeeConfigRequestBuilder)? updates]) =>
      (FeeConfigRequestBuilder()..update(updates))._build();

  _$FeeConfigRequest._(
      {required this.agentType,
      required this.transactionType,
      required this.feeType,
      this.feeAmount,
      this.percentage,
      this.minFee,
      this.maxFee,
      required this.currency,
      required this.effectiveFrom,
      this.effectiveTo})
      : super._();
  @override
  FeeConfigRequest rebuild(void Function(FeeConfigRequestBuilder) updates) =>
      (toBuilder()..update(updates)).build();

  @override
  FeeConfigRequestBuilder toBuilder() =>
      FeeConfigRequestBuilder()..replace(this);

  @override
  bool operator ==(Object other) {
    if (identical(other, this)) return true;
    return other is FeeConfigRequest &&
        agentType == other.agentType &&
        transactionType == other.transactionType &&
        feeType == other.feeType &&
        feeAmount == other.feeAmount &&
        percentage == other.percentage &&
        minFee == other.minFee &&
        maxFee == other.maxFee &&
        currency == other.currency &&
        effectiveFrom == other.effectiveFrom &&
        effectiveTo == other.effectiveTo;
  }

  @override
  int get hashCode {
    var _$hash = 0;
    _$hash = $jc(_$hash, agentType.hashCode);
    _$hash = $jc(_$hash, transactionType.hashCode);
    _$hash = $jc(_$hash, feeType.hashCode);
    _$hash = $jc(_$hash, feeAmount.hashCode);
    _$hash = $jc(_$hash, percentage.hashCode);
    _$hash = $jc(_$hash, minFee.hashCode);
    _$hash = $jc(_$hash, maxFee.hashCode);
    _$hash = $jc(_$hash, currency.hashCode);
    _$hash = $jc(_$hash, effectiveFrom.hashCode);
    _$hash = $jc(_$hash, effectiveTo.hashCode);
    _$hash = $jf(_$hash);
    return _$hash;
  }

  @override
  String toString() {
    return (newBuiltValueToStringHelper(r'FeeConfigRequest')
          ..add('agentType', agentType)
          ..add('transactionType', transactionType)
          ..add('feeType', feeType)
          ..add('feeAmount', feeAmount)
          ..add('percentage', percentage)
          ..add('minFee', minFee)
          ..add('maxFee', maxFee)
          ..add('currency', currency)
          ..add('effectiveFrom', effectiveFrom)
          ..add('effectiveTo', effectiveTo))
        .toString();
  }
}

class FeeConfigRequestBuilder
    implements Builder<FeeConfigRequest, FeeConfigRequestBuilder> {
  _$FeeConfigRequest? _$v;

  FeeConfigRequestAgentTypeEnum? _agentType;
  FeeConfigRequestAgentTypeEnum? get agentType => _$this._agentType;
  set agentType(FeeConfigRequestAgentTypeEnum? agentType) =>
      _$this._agentType = agentType;

  FeeConfigRequestTransactionTypeEnum? _transactionType;
  FeeConfigRequestTransactionTypeEnum? get transactionType =>
      _$this._transactionType;
  set transactionType(FeeConfigRequestTransactionTypeEnum? transactionType) =>
      _$this._transactionType = transactionType;

  FeeConfigRequestFeeTypeEnum? _feeType;
  FeeConfigRequestFeeTypeEnum? get feeType => _$this._feeType;
  set feeType(FeeConfigRequestFeeTypeEnum? feeType) =>
      _$this._feeType = feeType;

  num? _feeAmount;
  num? get feeAmount => _$this._feeAmount;
  set feeAmount(num? feeAmount) => _$this._feeAmount = feeAmount;

  num? _percentage;
  num? get percentage => _$this._percentage;
  set percentage(num? percentage) => _$this._percentage = percentage;

  num? _minFee;
  num? get minFee => _$this._minFee;
  set minFee(num? minFee) => _$this._minFee = minFee;

  num? _maxFee;
  num? get maxFee => _$this._maxFee;
  set maxFee(num? maxFee) => _$this._maxFee = maxFee;

  FeeConfigRequestCurrencyEnum? _currency;
  FeeConfigRequestCurrencyEnum? get currency => _$this._currency;
  set currency(FeeConfigRequestCurrencyEnum? currency) =>
      _$this._currency = currency;

  DateTime? _effectiveFrom;
  DateTime? get effectiveFrom => _$this._effectiveFrom;
  set effectiveFrom(DateTime? effectiveFrom) =>
      _$this._effectiveFrom = effectiveFrom;

  DateTime? _effectiveTo;
  DateTime? get effectiveTo => _$this._effectiveTo;
  set effectiveTo(DateTime? effectiveTo) => _$this._effectiveTo = effectiveTo;

  FeeConfigRequestBuilder() {
    FeeConfigRequest._defaults(this);
  }

  FeeConfigRequestBuilder get _$this {
    final $v = _$v;
    if ($v != null) {
      _agentType = $v.agentType;
      _transactionType = $v.transactionType;
      _feeType = $v.feeType;
      _feeAmount = $v.feeAmount;
      _percentage = $v.percentage;
      _minFee = $v.minFee;
      _maxFee = $v.maxFee;
      _currency = $v.currency;
      _effectiveFrom = $v.effectiveFrom;
      _effectiveTo = $v.effectiveTo;
      _$v = null;
    }
    return this;
  }

  @override
  void replace(FeeConfigRequest other) {
    _$v = other as _$FeeConfigRequest;
  }

  @override
  void update(void Function(FeeConfigRequestBuilder)? updates) {
    if (updates != null) updates(this);
  }

  @override
  FeeConfigRequest build() => _build();

  _$FeeConfigRequest _build() {
    final _$result = _$v ??
        _$FeeConfigRequest._(
          agentType: BuiltValueNullFieldError.checkNotNull(
              agentType, r'FeeConfigRequest', 'agentType'),
          transactionType: BuiltValueNullFieldError.checkNotNull(
              transactionType, r'FeeConfigRequest', 'transactionType'),
          feeType: BuiltValueNullFieldError.checkNotNull(
              feeType, r'FeeConfigRequest', 'feeType'),
          feeAmount: feeAmount,
          percentage: percentage,
          minFee: minFee,
          maxFee: maxFee,
          currency: BuiltValueNullFieldError.checkNotNull(
              currency, r'FeeConfigRequest', 'currency'),
          effectiveFrom: BuiltValueNullFieldError.checkNotNull(
              effectiveFrom, r'FeeConfigRequest', 'effectiveFrom'),
          effectiveTo: effectiveTo,
        );
    replace(_$result);
    return _$result;
  }
}

// ignore_for_file: deprecated_member_use_from_same_package,type=lint
