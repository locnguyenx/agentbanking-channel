// @dart=2.19
// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'update_agent_request.dart';

// **************************************************************************
// BuiltValueGenerator
// **************************************************************************

const UpdateAgentRequestTierEnum _$updateAgentRequestTierEnum_BASIC =
    const UpdateAgentRequestTierEnum._('BASIC');
const UpdateAgentRequestTierEnum _$updateAgentRequestTierEnum_STANDARD =
    const UpdateAgentRequestTierEnum._('STANDARD');
const UpdateAgentRequestTierEnum _$updateAgentRequestTierEnum_PREMIUM =
    const UpdateAgentRequestTierEnum._('PREMIUM');

UpdateAgentRequestTierEnum _$updateAgentRequestTierEnumValueOf(String name) {
  switch (name) {
    case 'BASIC':
      return _$updateAgentRequestTierEnum_BASIC;
    case 'STANDARD':
      return _$updateAgentRequestTierEnum_STANDARD;
    case 'PREMIUM':
      return _$updateAgentRequestTierEnum_PREMIUM;
    default:
      throw ArgumentError(name);
  }
}

final BuiltSet<UpdateAgentRequestTierEnum> _$updateAgentRequestTierEnumValues =
    BuiltSet<UpdateAgentRequestTierEnum>(const <UpdateAgentRequestTierEnum>[
  _$updateAgentRequestTierEnum_BASIC,
  _$updateAgentRequestTierEnum_STANDARD,
  _$updateAgentRequestTierEnum_PREMIUM,
]);

Serializer<UpdateAgentRequestTierEnum> _$updateAgentRequestTierEnumSerializer =
    _$UpdateAgentRequestTierEnumSerializer();

class _$UpdateAgentRequestTierEnumSerializer
    implements PrimitiveSerializer<UpdateAgentRequestTierEnum> {
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
  final Iterable<Type> types = const <Type>[UpdateAgentRequestTierEnum];
  @override
  final String wireName = 'UpdateAgentRequestTierEnum';

  @override
  Object serialize(Serializers serializers, UpdateAgentRequestTierEnum object,
          {FullType specifiedType = FullType.unspecified}) =>
      _toWire[object.name] ?? object.name;

  @override
  UpdateAgentRequestTierEnum deserialize(
          Serializers serializers, Object serialized,
          {FullType specifiedType = FullType.unspecified}) =>
      UpdateAgentRequestTierEnum.valueOf(
          _fromWire[serialized] ?? (serialized is String ? serialized : ''));
}

class _$UpdateAgentRequest extends UpdateAgentRequest {
  @override
  final String businessName;
  @override
  final UpdateAgentRequestTierEnum tier;
  @override
  final num merchantGpsLat;
  @override
  final num merchantGpsLng;
  @override
  final String phoneNumber;

  factory _$UpdateAgentRequest(
          [void Function(UpdateAgentRequestBuilder)? updates]) =>
      (UpdateAgentRequestBuilder()..update(updates))._build();

  _$UpdateAgentRequest._(
      {required this.businessName,
      required this.tier,
      required this.merchantGpsLat,
      required this.merchantGpsLng,
      required this.phoneNumber})
      : super._();
  @override
  UpdateAgentRequest rebuild(
          void Function(UpdateAgentRequestBuilder) updates) =>
      (toBuilder()..update(updates)).build();

  @override
  UpdateAgentRequestBuilder toBuilder() =>
      UpdateAgentRequestBuilder()..replace(this);

  @override
  bool operator ==(Object other) {
    if (identical(other, this)) return true;
    return other is UpdateAgentRequest &&
        businessName == other.businessName &&
        tier == other.tier &&
        merchantGpsLat == other.merchantGpsLat &&
        merchantGpsLng == other.merchantGpsLng &&
        phoneNumber == other.phoneNumber;
  }

  @override
  int get hashCode {
    var _$hash = 0;
    _$hash = $jc(_$hash, businessName.hashCode);
    _$hash = $jc(_$hash, tier.hashCode);
    _$hash = $jc(_$hash, merchantGpsLat.hashCode);
    _$hash = $jc(_$hash, merchantGpsLng.hashCode);
    _$hash = $jc(_$hash, phoneNumber.hashCode);
    _$hash = $jf(_$hash);
    return _$hash;
  }

  @override
  String toString() {
    return (newBuiltValueToStringHelper(r'UpdateAgentRequest')
          ..add('businessName', businessName)
          ..add('tier', tier)
          ..add('merchantGpsLat', merchantGpsLat)
          ..add('merchantGpsLng', merchantGpsLng)
          ..add('phoneNumber', phoneNumber))
        .toString();
  }
}

class UpdateAgentRequestBuilder
    implements Builder<UpdateAgentRequest, UpdateAgentRequestBuilder> {
  _$UpdateAgentRequest? _$v;

  String? _businessName;
  String? get businessName => _$this._businessName;
  set businessName(String? businessName) => _$this._businessName = businessName;

  UpdateAgentRequestTierEnum? _tier;
  UpdateAgentRequestTierEnum? get tier => _$this._tier;
  set tier(UpdateAgentRequestTierEnum? tier) => _$this._tier = tier;

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

  UpdateAgentRequestBuilder() {
    UpdateAgentRequest._defaults(this);
  }

  UpdateAgentRequestBuilder get _$this {
    final $v = _$v;
    if ($v != null) {
      _businessName = $v.businessName;
      _tier = $v.tier;
      _merchantGpsLat = $v.merchantGpsLat;
      _merchantGpsLng = $v.merchantGpsLng;
      _phoneNumber = $v.phoneNumber;
      _$v = null;
    }
    return this;
  }

  @override
  void replace(UpdateAgentRequest other) {
    _$v = other as _$UpdateAgentRequest;
  }

  @override
  void update(void Function(UpdateAgentRequestBuilder)? updates) {
    if (updates != null) updates(this);
  }

  @override
  UpdateAgentRequest build() => _build();

  _$UpdateAgentRequest _build() {
    final _$result = _$v ??
        _$UpdateAgentRequest._(
          businessName: BuiltValueNullFieldError.checkNotNull(
              businessName, r'UpdateAgentRequest', 'businessName'),
          tier: BuiltValueNullFieldError.checkNotNull(
              tier, r'UpdateAgentRequest', 'tier'),
          merchantGpsLat: BuiltValueNullFieldError.checkNotNull(
              merchantGpsLat, r'UpdateAgentRequest', 'merchantGpsLat'),
          merchantGpsLng: BuiltValueNullFieldError.checkNotNull(
              merchantGpsLng, r'UpdateAgentRequest', 'merchantGpsLng'),
          phoneNumber: BuiltValueNullFieldError.checkNotNull(
              phoneNumber, r'UpdateAgentRequest', 'phoneNumber'),
        );
    replace(_$result);
    return _$result;
  }
}

// ignore_for_file: deprecated_member_use_from_same_package,type=lint
