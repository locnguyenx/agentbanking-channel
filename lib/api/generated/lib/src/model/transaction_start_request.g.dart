// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'transaction_start_request.dart';

// **************************************************************************
// BuiltValueGenerator
// **************************************************************************

const TransactionStartRequestProxyTypeEnum
    _$transactionStartRequestProxyTypeEnum_IC =
    const TransactionStartRequestProxyTypeEnum._('IC');
const TransactionStartRequestProxyTypeEnum
    _$transactionStartRequestProxyTypeEnum_PHONE =
    const TransactionStartRequestProxyTypeEnum._('PHONE');
const TransactionStartRequestProxyTypeEnum
    _$transactionStartRequestProxyTypeEnum_EMAIL =
    const TransactionStartRequestProxyTypeEnum._('EMAIL');
const TransactionStartRequestProxyTypeEnum
    _$transactionStartRequestProxyTypeEnum_TGAN =
    const TransactionStartRequestProxyTypeEnum._('TGAN');

TransactionStartRequestProxyTypeEnum
    _$transactionStartRequestProxyTypeEnumValueOf(String name) {
  switch (name) {
    case 'IC':
      return _$transactionStartRequestProxyTypeEnum_IC;
    case 'PHONE':
      return _$transactionStartRequestProxyTypeEnum_PHONE;
    case 'EMAIL':
      return _$transactionStartRequestProxyTypeEnum_EMAIL;
    case 'TGAN':
      return _$transactionStartRequestProxyTypeEnum_TGAN;
    default:
      throw ArgumentError(name);
  }
}

final BuiltSet<TransactionStartRequestProxyTypeEnum>
    _$transactionStartRequestProxyTypeEnumValues = BuiltSet<
        TransactionStartRequestProxyTypeEnum>(const <TransactionStartRequestProxyTypeEnum>[
  _$transactionStartRequestProxyTypeEnum_IC,
  _$transactionStartRequestProxyTypeEnum_PHONE,
  _$transactionStartRequestProxyTypeEnum_EMAIL,
  _$transactionStartRequestProxyTypeEnum_TGAN,
]);

const TransactionStartRequestAgentTierEnum
    _$transactionStartRequestAgentTierEnum_MICRO =
    const TransactionStartRequestAgentTierEnum._('MICRO');
const TransactionStartRequestAgentTierEnum
    _$transactionStartRequestAgentTierEnum_STANDARD =
    const TransactionStartRequestAgentTierEnum._('STANDARD');
const TransactionStartRequestAgentTierEnum
    _$transactionStartRequestAgentTierEnum_PREMIER =
    const TransactionStartRequestAgentTierEnum._('PREMIER');

TransactionStartRequestAgentTierEnum
    _$transactionStartRequestAgentTierEnumValueOf(String name) {
  switch (name) {
    case 'MICRO':
      return _$transactionStartRequestAgentTierEnum_MICRO;
    case 'STANDARD':
      return _$transactionStartRequestAgentTierEnum_STANDARD;
    case 'PREMIER':
      return _$transactionStartRequestAgentTierEnum_PREMIER;
    default:
      throw ArgumentError(name);
  }
}

final BuiltSet<TransactionStartRequestAgentTierEnum>
    _$transactionStartRequestAgentTierEnumValues = BuiltSet<
        TransactionStartRequestAgentTierEnum>(const <TransactionStartRequestAgentTierEnum>[
  _$transactionStartRequestAgentTierEnum_MICRO,
  _$transactionStartRequestAgentTierEnum_STANDARD,
  _$transactionStartRequestAgentTierEnum_PREMIER,
]);

Serializer<TransactionStartRequestProxyTypeEnum>
    _$transactionStartRequestProxyTypeEnumSerializer =
    _$TransactionStartRequestProxyTypeEnumSerializer();
Serializer<TransactionStartRequestAgentTierEnum>
    _$transactionStartRequestAgentTierEnumSerializer =
    _$TransactionStartRequestAgentTierEnumSerializer();

class _$TransactionStartRequestProxyTypeEnumSerializer
    implements PrimitiveSerializer<TransactionStartRequestProxyTypeEnum> {
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
    TransactionStartRequestProxyTypeEnum
  ];
  @override
  final String wireName = 'TransactionStartRequestProxyTypeEnum';

  @override
  Object serialize(
          Serializers serializers, TransactionStartRequestProxyTypeEnum object,
          {FullType specifiedType = FullType.unspecified}) =>
      _toWire[object.name] ?? object.name;

  @override
  TransactionStartRequestProxyTypeEnum deserialize(
          Serializers serializers, Object serialized,
          {FullType specifiedType = FullType.unspecified}) =>
      TransactionStartRequestProxyTypeEnum.valueOf(
          _fromWire[serialized] ?? (serialized is String ? serialized : ''));
}

class _$TransactionStartRequestAgentTierEnumSerializer
    implements PrimitiveSerializer<TransactionStartRequestAgentTierEnum> {
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
  final Iterable<Type> types = const <Type>[
    TransactionStartRequestAgentTierEnum
  ];
  @override
  final String wireName = 'TransactionStartRequestAgentTierEnum';

  @override
  Object serialize(
          Serializers serializers, TransactionStartRequestAgentTierEnum object,
          {FullType specifiedType = FullType.unspecified}) =>
      _toWire[object.name] ?? object.name;

  @override
  TransactionStartRequestAgentTierEnum deserialize(
          Serializers serializers, Object serialized,
          {FullType specifiedType = FullType.unspecified}) =>
      TransactionStartRequestAgentTierEnum.valueOf(
          _fromWire[serialized] ?? (serialized is String ? serialized : ''));
}

class _$TransactionStartRequest extends TransactionStartRequest {
  @override
  final TransactionType transactionType;
  @override
  final String agentId;
  @override
  final double amount;
  @override
  final String idempotencyKey;
  @override
  final String? pan;
  @override
  final String? pinBlock;
  @override
  final String? customerCardMasked;
  @override
  final String? destinationAccount;
  @override
  final bool? requiresBiometric;
  @override
  final String? billerCode;
  @override
  final String? ref1;
  @override
  final String? ref2;
  @override
  final TransactionStartRequestProxyTypeEnum? proxyType;
  @override
  final String? proxyValue;
  @override
  final String? customerMykad;
  @override
  final double? geofenceLat;
  @override
  final double? geofenceLng;
  @override
  final String? targetBIN;
  @override
  final TransactionStartRequestAgentTierEnum? agentTier;

  factory _$TransactionStartRequest(
          [void Function(TransactionStartRequestBuilder)? updates]) =>
      (TransactionStartRequestBuilder()..update(updates))._build();

  _$TransactionStartRequest._(
      {required this.transactionType,
      required this.agentId,
      required this.amount,
      required this.idempotencyKey,
      this.pan,
      this.pinBlock,
      this.customerCardMasked,
      this.destinationAccount,
      this.requiresBiometric,
      this.billerCode,
      this.ref1,
      this.ref2,
      this.proxyType,
      this.proxyValue,
      this.customerMykad,
      this.geofenceLat,
      this.geofenceLng,
      this.targetBIN,
      this.agentTier})
      : super._();
  @override
  TransactionStartRequest rebuild(
          void Function(TransactionStartRequestBuilder) updates) =>
      (toBuilder()..update(updates)).build();

  @override
  TransactionStartRequestBuilder toBuilder() =>
      TransactionStartRequestBuilder()..replace(this);

  @override
  bool operator ==(Object other) {
    if (identical(other, this)) return true;
    return other is TransactionStartRequest &&
        transactionType == other.transactionType &&
        agentId == other.agentId &&
        amount == other.amount &&
        idempotencyKey == other.idempotencyKey &&
        pan == other.pan &&
        pinBlock == other.pinBlock &&
        customerCardMasked == other.customerCardMasked &&
        destinationAccount == other.destinationAccount &&
        requiresBiometric == other.requiresBiometric &&
        billerCode == other.billerCode &&
        ref1 == other.ref1 &&
        ref2 == other.ref2 &&
        proxyType == other.proxyType &&
        proxyValue == other.proxyValue &&
        customerMykad == other.customerMykad &&
        geofenceLat == other.geofenceLat &&
        geofenceLng == other.geofenceLng &&
        targetBIN == other.targetBIN &&
        agentTier == other.agentTier;
  }

  @override
  int get hashCode {
    var _$hash = 0;
    _$hash = $jc(_$hash, transactionType.hashCode);
    _$hash = $jc(_$hash, agentId.hashCode);
    _$hash = $jc(_$hash, amount.hashCode);
    _$hash = $jc(_$hash, idempotencyKey.hashCode);
    _$hash = $jc(_$hash, pan.hashCode);
    _$hash = $jc(_$hash, pinBlock.hashCode);
    _$hash = $jc(_$hash, customerCardMasked.hashCode);
    _$hash = $jc(_$hash, destinationAccount.hashCode);
    _$hash = $jc(_$hash, requiresBiometric.hashCode);
    _$hash = $jc(_$hash, billerCode.hashCode);
    _$hash = $jc(_$hash, ref1.hashCode);
    _$hash = $jc(_$hash, ref2.hashCode);
    _$hash = $jc(_$hash, proxyType.hashCode);
    _$hash = $jc(_$hash, proxyValue.hashCode);
    _$hash = $jc(_$hash, customerMykad.hashCode);
    _$hash = $jc(_$hash, geofenceLat.hashCode);
    _$hash = $jc(_$hash, geofenceLng.hashCode);
    _$hash = $jc(_$hash, targetBIN.hashCode);
    _$hash = $jc(_$hash, agentTier.hashCode);
    _$hash = $jf(_$hash);
    return _$hash;
  }

  @override
  String toString() {
    return (newBuiltValueToStringHelper(r'TransactionStartRequest')
          ..add('transactionType', transactionType)
          ..add('agentId', agentId)
          ..add('amount', amount)
          ..add('idempotencyKey', idempotencyKey)
          ..add('pan', pan)
          ..add('pinBlock', pinBlock)
          ..add('customerCardMasked', customerCardMasked)
          ..add('destinationAccount', destinationAccount)
          ..add('requiresBiometric', requiresBiometric)
          ..add('billerCode', billerCode)
          ..add('ref1', ref1)
          ..add('ref2', ref2)
          ..add('proxyType', proxyType)
          ..add('proxyValue', proxyValue)
          ..add('customerMykad', customerMykad)
          ..add('geofenceLat', geofenceLat)
          ..add('geofenceLng', geofenceLng)
          ..add('targetBIN', targetBIN)
          ..add('agentTier', agentTier))
        .toString();
  }
}

class TransactionStartRequestBuilder
    implements
        Builder<TransactionStartRequest, TransactionStartRequestBuilder> {
  _$TransactionStartRequest? _$v;

  TransactionType? _transactionType;
  TransactionType? get transactionType => _$this._transactionType;
  set transactionType(TransactionType? transactionType) =>
      _$this._transactionType = transactionType;

  String? _agentId;
  String? get agentId => _$this._agentId;
  set agentId(String? agentId) => _$this._agentId = agentId;

  double? _amount;
  double? get amount => _$this._amount;
  set amount(double? amount) => _$this._amount = amount;

  String? _idempotencyKey;
  String? get idempotencyKey => _$this._idempotencyKey;
  set idempotencyKey(String? idempotencyKey) =>
      _$this._idempotencyKey = idempotencyKey;

  String? _pan;
  String? get pan => _$this._pan;
  set pan(String? pan) => _$this._pan = pan;

  String? _pinBlock;
  String? get pinBlock => _$this._pinBlock;
  set pinBlock(String? pinBlock) => _$this._pinBlock = pinBlock;

  String? _customerCardMasked;
  String? get customerCardMasked => _$this._customerCardMasked;
  set customerCardMasked(String? customerCardMasked) =>
      _$this._customerCardMasked = customerCardMasked;

  String? _destinationAccount;
  String? get destinationAccount => _$this._destinationAccount;
  set destinationAccount(String? destinationAccount) =>
      _$this._destinationAccount = destinationAccount;

  bool? _requiresBiometric;
  bool? get requiresBiometric => _$this._requiresBiometric;
  set requiresBiometric(bool? requiresBiometric) =>
      _$this._requiresBiometric = requiresBiometric;

  String? _billerCode;
  String? get billerCode => _$this._billerCode;
  set billerCode(String? billerCode) => _$this._billerCode = billerCode;

  String? _ref1;
  String? get ref1 => _$this._ref1;
  set ref1(String? ref1) => _$this._ref1 = ref1;

  String? _ref2;
  String? get ref2 => _$this._ref2;
  set ref2(String? ref2) => _$this._ref2 = ref2;

  TransactionStartRequestProxyTypeEnum? _proxyType;
  TransactionStartRequestProxyTypeEnum? get proxyType => _$this._proxyType;
  set proxyType(TransactionStartRequestProxyTypeEnum? proxyType) =>
      _$this._proxyType = proxyType;

  String? _proxyValue;
  String? get proxyValue => _$this._proxyValue;
  set proxyValue(String? proxyValue) => _$this._proxyValue = proxyValue;

  String? _customerMykad;
  String? get customerMykad => _$this._customerMykad;
  set customerMykad(String? customerMykad) =>
      _$this._customerMykad = customerMykad;

  double? _geofenceLat;
  double? get geofenceLat => _$this._geofenceLat;
  set geofenceLat(double? geofenceLat) => _$this._geofenceLat = geofenceLat;

  double? _geofenceLng;
  double? get geofenceLng => _$this._geofenceLng;
  set geofenceLng(double? geofenceLng) => _$this._geofenceLng = geofenceLng;

  String? _targetBIN;
  String? get targetBIN => _$this._targetBIN;
  set targetBIN(String? targetBIN) => _$this._targetBIN = targetBIN;

  TransactionStartRequestAgentTierEnum? _agentTier;
  TransactionStartRequestAgentTierEnum? get agentTier => _$this._agentTier;
  set agentTier(TransactionStartRequestAgentTierEnum? agentTier) =>
      _$this._agentTier = agentTier;

  TransactionStartRequestBuilder() {
    TransactionStartRequest._defaults(this);
  }

  TransactionStartRequestBuilder get _$this {
    final $v = _$v;
    if ($v != null) {
      _transactionType = $v.transactionType;
      _agentId = $v.agentId;
      _amount = $v.amount;
      _idempotencyKey = $v.idempotencyKey;
      _pan = $v.pan;
      _pinBlock = $v.pinBlock;
      _customerCardMasked = $v.customerCardMasked;
      _destinationAccount = $v.destinationAccount;
      _requiresBiometric = $v.requiresBiometric;
      _billerCode = $v.billerCode;
      _ref1 = $v.ref1;
      _ref2 = $v.ref2;
      _proxyType = $v.proxyType;
      _proxyValue = $v.proxyValue;
      _customerMykad = $v.customerMykad;
      _geofenceLat = $v.geofenceLat;
      _geofenceLng = $v.geofenceLng;
      _targetBIN = $v.targetBIN;
      _agentTier = $v.agentTier;
      _$v = null;
    }
    return this;
  }

  @override
  void replace(TransactionStartRequest other) {
    _$v = other as _$TransactionStartRequest;
  }

  @override
  void update(void Function(TransactionStartRequestBuilder)? updates) {
    if (updates != null) updates(this);
  }

  @override
  TransactionStartRequest build() => _build();

  _$TransactionStartRequest _build() {
    final _$result = _$v ??
        _$TransactionStartRequest._(
          transactionType: BuiltValueNullFieldError.checkNotNull(
              transactionType, r'TransactionStartRequest', 'transactionType'),
          agentId: BuiltValueNullFieldError.checkNotNull(
              agentId, r'TransactionStartRequest', 'agentId'),
          amount: BuiltValueNullFieldError.checkNotNull(
              amount, r'TransactionStartRequest', 'amount'),
          idempotencyKey: BuiltValueNullFieldError.checkNotNull(
              idempotencyKey, r'TransactionStartRequest', 'idempotencyKey'),
          pan: pan,
          pinBlock: pinBlock,
          customerCardMasked: customerCardMasked,
          destinationAccount: destinationAccount,
          requiresBiometric: requiresBiometric,
          billerCode: billerCode,
          ref1: ref1,
          ref2: ref2,
          proxyType: proxyType,
          proxyValue: proxyValue,
          customerMykad: customerMykad,
          geofenceLat: geofenceLat,
          geofenceLng: geofenceLng,
          targetBIN: targetBIN,
          agentTier: agentTier,
        );
    replace(_$result);
    return _$result;
  }
}

// ignore_for_file: deprecated_member_use_from_same_package,type=lint
