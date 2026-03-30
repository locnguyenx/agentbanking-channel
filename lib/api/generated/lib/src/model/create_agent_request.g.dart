// @dart=2.19
// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'create_agent_request.dart';

// **************************************************************************
// BuiltValueGenerator
// **************************************************************************

const CreateAgentRequestTierEnum _$createAgentRequestTierEnum_BASIC =
    const CreateAgentRequestTierEnum._('BASIC');
const CreateAgentRequestTierEnum _$createAgentRequestTierEnum_STANDARD =
    const CreateAgentRequestTierEnum._('STANDARD');
const CreateAgentRequestTierEnum _$createAgentRequestTierEnum_PREMIUM =
    const CreateAgentRequestTierEnum._('PREMIUM');

CreateAgentRequestTierEnum _$createAgentRequestTierEnumValueOf(String name) {
  switch (name) {
    case 'BASIC':
      return _$createAgentRequestTierEnum_BASIC;
    case 'STANDARD':
      return _$createAgentRequestTierEnum_STANDARD;
    case 'PREMIUM':
      return _$createAgentRequestTierEnum_PREMIUM;
    default:
      throw ArgumentError(name);
  }
}

final BuiltSet<CreateAgentRequestTierEnum> _$createAgentRequestTierEnumValues =
    BuiltSet<CreateAgentRequestTierEnum>(const <CreateAgentRequestTierEnum>[
  _$createAgentRequestTierEnum_BASIC,
  _$createAgentRequestTierEnum_STANDARD,
  _$createAgentRequestTierEnum_PREMIUM,
]);

Serializer<CreateAgentRequestTierEnum> _$createAgentRequestTierEnumSerializer =
    _$CreateAgentRequestTierEnumSerializer();

class _$CreateAgentRequestTierEnumSerializer
    implements PrimitiveSerializer<CreateAgentRequestTierEnum> {
  static const Map<String, Object> _toWire = const <String, Object>{
    'BASIC': 'BASIC',
    'STANDARD': 'STANDARD',
    'PREMIUM': 'PREMIUM',
  };
  static const Map<Object, String> _fromWire = const <Object, String>{
    'BASIC': 'BASIC',
    'STANDARD': 'STANDARD',
    'PREMIUM': 'PREMIUM',
  };

  @override
  final Iterable<Type> types = const <Type>[CreateAgentRequestTierEnum];
  @override
  final String wireName = 'CreateAgentRequestTierEnum';

  @override
  Object serialize(Serializers serializers, CreateAgentRequestTierEnum object,
          {FullType specifiedType = FullType.unspecified}) =>
      _toWire[object.name] ?? object.name;

  @override
  CreateAgentRequestTierEnum deserialize(
          Serializers serializers, Object serialized,
          {FullType specifiedType = FullType.unspecified}) =>
      CreateAgentRequestTierEnum.valueOf(
          _fromWire[serialized] ?? (serialized is String ? serialized : ''));
}

class _$CreateAgentRequest extends CreateAgentRequest {
  @override
  final String agentCode;
  @override
  final String businessName;
  @override
  final CreateAgentRequestTierEnum tier;
  @override
  final num merchantGpsLat;
  @override
  final num merchantGpsLng;
  @override
  final String mykadNumber;
  @override
  final String phoneNumber;

  factory _$CreateAgentRequest(
          [void Function(CreateAgentRequestBuilder)? updates]) =>
      (CreateAgentRequestBuilder()..update(updates))._build();

  _$CreateAgentRequest._(
      {required this.agentCode,
      required this.businessName,
      required this.tier,
      required this.merchantGpsLat,
      required this.merchantGpsLng,
      required this.mykadNumber,
      required this.phoneNumber})
      : super._();
  @override
  CreateAgentRequest rebuild(
          void Function(CreateAgentRequestBuilder) updates) =>
      (toBuilder()..update(updates)).build();

  @override
  CreateAgentRequestBuilder toBuilder() =>
      CreateAgentRequestBuilder()..replace(this);

  @override
  bool operator ==(Object other) {
    if (identical(other, this)) return true;
    return other is CreateAgentRequest &&
        agentCode == other.agentCode &&
        businessName == other.businessName &&
        tier == other.tier &&
        merchantGpsLat == other.merchantGpsLat &&
        merchantGpsLng == other.merchantGpsLng &&
        mykadNumber == other.mykadNumber &&
        phoneNumber == other.phoneNumber;
  }

  @override
  int get hashCode {
    var _$hash = 0;
    _$hash = $jc(_$hash, agentCode.hashCode);
    _$hash = $jc(_$hash, businessName.hashCode);
    _$hash = $jc(_$hash, tier.hashCode);
    _$hash = $jc(_$hash, merchantGpsLat.hashCode);
    _$hash = $jc(_$hash, merchantGpsLng.hashCode);
    _$hash = $jc(_$hash, mykadNumber.hashCode);
    _$hash = $jc(_$hash, phoneNumber.hashCode);
    _$hash = $jf(_$hash);
    return _$hash;
  }

  @override
  String toString() {
    return (newBuiltValueToStringHelper(r'CreateAgentRequest')
          ..add('agentCode', agentCode)
          ..add('businessName', businessName)
          ..add('tier', tier)
          ..add('merchantGpsLat', merchantGpsLat)
          ..add('merchantGpsLng', merchantGpsLng)
          ..add('mykadNumber', mykadNumber)
          ..add('phoneNumber', phoneNumber))
        .toString();
  }
}

class CreateAgentRequestBuilder
    implements Builder<CreateAgentRequest, CreateAgentRequestBuilder> {
  _$CreateAgentRequest? _$v;

  String? _agentCode;
  String? get agentCode => _$this._agentCode;
  set agentCode(String? agentCode) => _$this._agentCode = agentCode;

  String? _businessName;
  String? get businessName => _$this._businessName;
  set businessName(String? businessName) => _$this._businessName = businessName;

  CreateAgentRequestTierEnum? _tier;
  CreateAgentRequestTierEnum? get tier => _$this._tier;
  set tier(CreateAgentRequestTierEnum? tier) => _$this._tier = tier;

  num? _merchantGpsLat;
  num? get merchantGpsLat => _$this._merchantGpsLat;
  set merchantGpsLat(num? merchantGpsLat) =>
      _$this._merchantGpsLat = merchantGpsLat;

  num? _merchantGpsLng;
  num? get merchantGpsLng => _$this._merchantGpsLng;
  set merchantGpsLng(num? merchantGpsLng) =>
      _$this._merchantGpsLng = merchantGpsLng;

  String? _mykadNumber;
  String? get mykadNumber => _$this._mykadNumber;
  set mykadNumber(String? mykadNumber) => _$this._mykadNumber = mykadNumber;

  String? _phoneNumber;
  String? get phoneNumber => _$this._phoneNumber;
  set phoneNumber(String? phoneNumber) => _$this._phoneNumber = phoneNumber;

  CreateAgentRequestBuilder() {
    CreateAgentRequest._defaults(this);
  }

  CreateAgentRequestBuilder get _$this {
    final $v = _$v;
    if ($v != null) {
      _agentCode = $v.agentCode;
      _businessName = $v.businessName;
      _tier = $v.tier;
      _merchantGpsLat = $v.merchantGpsLat;
      _merchantGpsLng = $v.merchantGpsLng;
      _mykadNumber = $v.mykadNumber;
      _phoneNumber = $v.phoneNumber;
      _$v = null;
    }
    return this;
  }

  @override
  void replace(CreateAgentRequest other) {
    _$v = other as _$CreateAgentRequest;
  }

  @override
  void update(void Function(CreateAgentRequestBuilder)? updates) {
    if (updates != null) updates(this);
  }

  @override
  CreateAgentRequest build() => _build();

  _$CreateAgentRequest _build() {
    final _$result = _$v ??
        _$CreateAgentRequest._(
          agentCode: BuiltValueNullFieldError.checkNotNull(
              agentCode, r'CreateAgentRequest', 'agentCode'),
          businessName: BuiltValueNullFieldError.checkNotNull(
              businessName, r'CreateAgentRequest', 'businessName'),
          tier: BuiltValueNullFieldError.checkNotNull(
              tier, r'CreateAgentRequest', 'tier'),
          merchantGpsLat: BuiltValueNullFieldError.checkNotNull(
              merchantGpsLat, r'CreateAgentRequest', 'merchantGpsLat'),
          merchantGpsLng: BuiltValueNullFieldError.checkNotNull(
              merchantGpsLng, r'CreateAgentRequest', 'merchantGpsLng'),
          mykadNumber: BuiltValueNullFieldError.checkNotNull(
              mykadNumber, r'CreateAgentRequest', 'mykadNumber'),
          phoneNumber: BuiltValueNullFieldError.checkNotNull(
              phoneNumber, r'CreateAgentRequest', 'phoneNumber'),
        );
    replace(_$result);
    return _$result;
  }
}

// ignore_for_file: deprecated_member_use_from_same_package,type=lint
