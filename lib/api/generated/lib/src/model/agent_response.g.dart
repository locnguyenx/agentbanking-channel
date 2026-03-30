// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'agent_response.dart';

// **************************************************************************
// BuiltValueGenerator
// **************************************************************************

const AgentResponseTierEnum _$agentResponseTierEnum_MICRO =
    const AgentResponseTierEnum._('MICRO');
const AgentResponseTierEnum _$agentResponseTierEnum_STANDARD =
    const AgentResponseTierEnum._('STANDARD');
const AgentResponseTierEnum _$agentResponseTierEnum_PREMIUM =
    const AgentResponseTierEnum._('PREMIUM');

AgentResponseTierEnum _$agentResponseTierEnumValueOf(String name) {
  switch (name) {
    case 'MICRO':
      return _$agentResponseTierEnum_MICRO;
    case 'STANDARD':
      return _$agentResponseTierEnum_STANDARD;
    case 'PREMIUM':
      return _$agentResponseTierEnum_PREMIUM;
    default:
      throw ArgumentError(name);
  }
}

final BuiltSet<AgentResponseTierEnum> _$agentResponseTierEnumValues =
    BuiltSet<AgentResponseTierEnum>(const <AgentResponseTierEnum>[
  _$agentResponseTierEnum_MICRO,
  _$agentResponseTierEnum_STANDARD,
  _$agentResponseTierEnum_PREMIUM,
]);

const AgentResponseStatusEnum _$agentResponseStatusEnum_ACTIVE =
    const AgentResponseStatusEnum._('ACTIVE');
const AgentResponseStatusEnum _$agentResponseStatusEnum_INACTIVE =
    const AgentResponseStatusEnum._('INACTIVE');
const AgentResponseStatusEnum _$agentResponseStatusEnum_PENDING =
    const AgentResponseStatusEnum._('PENDING');
const AgentResponseStatusEnum _$agentResponseStatusEnum_SUSPENDED =
    const AgentResponseStatusEnum._('SUSPENDED');

AgentResponseStatusEnum _$agentResponseStatusEnumValueOf(String name) {
  switch (name) {
    case 'ACTIVE':
      return _$agentResponseStatusEnum_ACTIVE;
    case 'INACTIVE':
      return _$agentResponseStatusEnum_INACTIVE;
    case 'PENDING':
      return _$agentResponseStatusEnum_PENDING;
    case 'SUSPENDED':
      return _$agentResponseStatusEnum_SUSPENDED;
    default:
      throw ArgumentError(name);
  }
}

final BuiltSet<AgentResponseStatusEnum> _$agentResponseStatusEnumValues =
    BuiltSet<AgentResponseStatusEnum>(const <AgentResponseStatusEnum>[
  _$agentResponseStatusEnum_ACTIVE,
  _$agentResponseStatusEnum_INACTIVE,
  _$agentResponseStatusEnum_PENDING,
  _$agentResponseStatusEnum_SUSPENDED,
]);

Serializer<AgentResponseTierEnum> _$agentResponseTierEnumSerializer =
    _$AgentResponseTierEnumSerializer();
Serializer<AgentResponseStatusEnum> _$agentResponseStatusEnumSerializer =
    _$AgentResponseStatusEnumSerializer();

class _$AgentResponseTierEnumSerializer
    implements PrimitiveSerializer<AgentResponseTierEnum> {
  static const Map<String, Object> _toWire = const <String, Object>{
    'MICRO': 'MICRO',
    'STANDARD': 'STANDARD',
    'PREMIUM': 'PREMIUM',
  };
  static const Map<Object, String> _fromWire = const <Object, String>{
    'MICRO': 'MICRO',
    'STANDARD': 'STANDARD',
    'PREMIUM': 'PREMIUM',
  };

  @override
  final Iterable<Type> types = const <Type>[AgentResponseTierEnum];
  @override
  final String wireName = 'AgentResponseTierEnum';

  @override
  Object serialize(Serializers serializers, AgentResponseTierEnum object,
          {FullType specifiedType = FullType.unspecified}) =>
      _toWire[object.name] ?? object.name;

  @override
  AgentResponseTierEnum deserialize(Serializers serializers, Object serialized,
          {FullType specifiedType = FullType.unspecified}) =>
      AgentResponseTierEnum.valueOf(
          _fromWire[serialized] ?? (serialized is String ? serialized : ''));
}

class _$AgentResponseStatusEnumSerializer
    implements PrimitiveSerializer<AgentResponseStatusEnum> {
  static const Map<String, Object> _toWire = const <String, Object>{
    'ACTIVE': 'ACTIVE',
    'INACTIVE': 'INACTIVE',
    'PENDING': 'PENDING',
    'SUSPENDED': 'SUSPENDED',
  };
  static const Map<Object, String> _fromWire = const <Object, String>{
    'ACTIVE': 'ACTIVE',
    'INACTIVE': 'INACTIVE',
    'PENDING': 'PENDING',
    'SUSPENDED': 'SUSPENDED',
  };

  @override
  final Iterable<Type> types = const <Type>[AgentResponseStatusEnum];
  @override
  final String wireName = 'AgentResponseStatusEnum';

  @override
  Object serialize(Serializers serializers, AgentResponseStatusEnum object,
          {FullType specifiedType = FullType.unspecified}) =>
      _toWire[object.name] ?? object.name;

  @override
  AgentResponseStatusEnum deserialize(
          Serializers serializers, Object serialized,
          {FullType specifiedType = FullType.unspecified}) =>
      AgentResponseStatusEnum.valueOf(
          _fromWire[serialized] ?? (serialized is String ? serialized : ''));
}

class _$AgentResponse extends AgentResponse {
  @override
  final String? agentId;
  @override
  final String? agentCode;
  @override
  final String? businessName;
  @override
  final AgentResponseTierEnum? tier;
  @override
  final AgentResponseStatusEnum? status;
  @override
  final num? merchantGpsLat;
  @override
  final num? merchantGpsLng;
  @override
  final String? phoneNumber;
  @override
  final String? email;
  @override
  final String? address;
  @override
  final DateTime? createdAt;
  @override
  final DateTime? updatedAt;

  factory _$AgentResponse([void Function(AgentResponseBuilder)? updates]) =>
      (AgentResponseBuilder()..update(updates))._build();

  _$AgentResponse._(
      {this.agentId,
      this.agentCode,
      this.businessName,
      this.tier,
      this.status,
      this.merchantGpsLat,
      this.merchantGpsLng,
      this.phoneNumber,
      this.email,
      this.address,
      this.createdAt,
      this.updatedAt})
      : super._();
  @override
  AgentResponse rebuild(void Function(AgentResponseBuilder) updates) =>
      (toBuilder()..update(updates)).build();

  @override
  AgentResponseBuilder toBuilder() => AgentResponseBuilder()..replace(this);

  @override
  bool operator ==(Object other) {
    if (identical(other, this)) return true;
    return other is AgentResponse &&
        agentId == other.agentId &&
        agentCode == other.agentCode &&
        businessName == other.businessName &&
        tier == other.tier &&
        status == other.status &&
        merchantGpsLat == other.merchantGpsLat &&
        merchantGpsLng == other.merchantGpsLng &&
        phoneNumber == other.phoneNumber &&
        email == other.email &&
        address == other.address &&
        createdAt == other.createdAt &&
        updatedAt == other.updatedAt;
  }

  @override
  int get hashCode {
    var _$hash = 0;
    _$hash = $jc(_$hash, agentId.hashCode);
    _$hash = $jc(_$hash, agentCode.hashCode);
    _$hash = $jc(_$hash, businessName.hashCode);
    _$hash = $jc(_$hash, tier.hashCode);
    _$hash = $jc(_$hash, status.hashCode);
    _$hash = $jc(_$hash, merchantGpsLat.hashCode);
    _$hash = $jc(_$hash, merchantGpsLng.hashCode);
    _$hash = $jc(_$hash, phoneNumber.hashCode);
    _$hash = $jc(_$hash, email.hashCode);
    _$hash = $jc(_$hash, address.hashCode);
    _$hash = $jc(_$hash, createdAt.hashCode);
    _$hash = $jc(_$hash, updatedAt.hashCode);
    _$hash = $jf(_$hash);
    return _$hash;
  }

  @override
  String toString() {
    return (newBuiltValueToStringHelper(r'AgentResponse')
          ..add('agentId', agentId)
          ..add('agentCode', agentCode)
          ..add('businessName', businessName)
          ..add('tier', tier)
          ..add('status', status)
          ..add('merchantGpsLat', merchantGpsLat)
          ..add('merchantGpsLng', merchantGpsLng)
          ..add('phoneNumber', phoneNumber)
          ..add('email', email)
          ..add('address', address)
          ..add('createdAt', createdAt)
          ..add('updatedAt', updatedAt))
        .toString();
  }
}

class AgentResponseBuilder
    implements Builder<AgentResponse, AgentResponseBuilder> {
  _$AgentResponse? _$v;

  String? _agentId;
  String? get agentId => _$this._agentId;
  set agentId(String? agentId) => _$this._agentId = agentId;

  String? _agentCode;
  String? get agentCode => _$this._agentCode;
  set agentCode(String? agentCode) => _$this._agentCode = agentCode;

  String? _businessName;
  String? get businessName => _$this._businessName;
  set businessName(String? businessName) => _$this._businessName = businessName;

  AgentResponseTierEnum? _tier;
  AgentResponseTierEnum? get tier => _$this._tier;
  set tier(AgentResponseTierEnum? tier) => _$this._tier = tier;

  AgentResponseStatusEnum? _status;
  AgentResponseStatusEnum? get status => _$this._status;
  set status(AgentResponseStatusEnum? status) => _$this._status = status;

  num? _merchantGpsLat;
  num? get merchantGpsLat => _$this._merchantGpsLat;
  set merchantGpsLat(num? merchantGpsLat) =>
      _$this._merchantGpsLat = merchantGpsLat;

  num? _merchantGpsLng;
  num? get merchantGpsLng => _$this._merchantGpsLng;
  set merchantGpsLng(num? merchantGpsLng) =>
      _$this._merchantGpsLng = merchantGpsLng;

  String? _phoneNumber;
  String? get phoneNumber => _$this._phoneNumber;
  set phoneNumber(String? phoneNumber) => _$this._phoneNumber = phoneNumber;

  String? _email;
  String? get email => _$this._email;
  set email(String? email) => _$this._email = email;

  String? _address;
  String? get address => _$this._address;
  set address(String? address) => _$this._address = address;

  DateTime? _createdAt;
  DateTime? get createdAt => _$this._createdAt;
  set createdAt(DateTime? createdAt) => _$this._createdAt = createdAt;

  DateTime? _updatedAt;
  DateTime? get updatedAt => _$this._updatedAt;
  set updatedAt(DateTime? updatedAt) => _$this._updatedAt = updatedAt;

  AgentResponseBuilder() {
    AgentResponse._defaults(this);
  }

  AgentResponseBuilder get _$this {
    final $v = _$v;
    if ($v != null) {
      _agentId = $v.agentId;
      _agentCode = $v.agentCode;
      _businessName = $v.businessName;
      _tier = $v.tier;
      _status = $v.status;
      _merchantGpsLat = $v.merchantGpsLat;
      _merchantGpsLng = $v.merchantGpsLng;
      _phoneNumber = $v.phoneNumber;
      _email = $v.email;
      _address = $v.address;
      _createdAt = $v.createdAt;
      _updatedAt = $v.updatedAt;
      _$v = null;
    }
    return this;
  }

  @override
  void replace(AgentResponse other) {
    _$v = other as _$AgentResponse;
  }

  @override
  void update(void Function(AgentResponseBuilder)? updates) {
    if (updates != null) updates(this);
  }

  @override
  AgentResponse build() => _build();

  _$AgentResponse _build() {
    final _$result = _$v ??
        _$AgentResponse._(
          agentId: agentId,
          agentCode: agentCode,
          businessName: businessName,
          tier: tier,
          status: status,
          merchantGpsLat: merchantGpsLat,
          merchantGpsLng: merchantGpsLng,
          phoneNumber: phoneNumber,
          email: email,
          address: address,
          createdAt: createdAt,
          updatedAt: updatedAt,
        );
    replace(_$result);
    return _$result;
  }
}

// ignore_for_file: deprecated_member_use_from_same_package,type=lint
