// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'application_submit_request.dart';

// **************************************************************************
// BuiltValueGenerator
// **************************************************************************

const ApplicationSubmitRequestTierEnum
    _$applicationSubmitRequestTierEnum_MICRO =
    const ApplicationSubmitRequestTierEnum._('MICRO');
const ApplicationSubmitRequestTierEnum
    _$applicationSubmitRequestTierEnum_STANDARD =
    const ApplicationSubmitRequestTierEnum._('STANDARD');
const ApplicationSubmitRequestTierEnum
    _$applicationSubmitRequestTierEnum_PREMIER =
    const ApplicationSubmitRequestTierEnum._('PREMIER');

ApplicationSubmitRequestTierEnum _$applicationSubmitRequestTierEnumValueOf(
    String name) {
  switch (name) {
    case 'MICRO':
      return _$applicationSubmitRequestTierEnum_MICRO;
    case 'STANDARD':
      return _$applicationSubmitRequestTierEnum_STANDARD;
    case 'PREMIER':
      return _$applicationSubmitRequestTierEnum_PREMIER;
    default:
      throw ArgumentError(name);
  }
}

final BuiltSet<ApplicationSubmitRequestTierEnum>
    _$applicationSubmitRequestTierEnumValues = BuiltSet<
        ApplicationSubmitRequestTierEnum>(const <ApplicationSubmitRequestTierEnum>[
  _$applicationSubmitRequestTierEnum_MICRO,
  _$applicationSubmitRequestTierEnum_STANDARD,
  _$applicationSubmitRequestTierEnum_PREMIER,
]);

Serializer<ApplicationSubmitRequestTierEnum>
    _$applicationSubmitRequestTierEnumSerializer =
    _$ApplicationSubmitRequestTierEnumSerializer();

class _$ApplicationSubmitRequestTierEnumSerializer
    implements PrimitiveSerializer<ApplicationSubmitRequestTierEnum> {
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
  final Iterable<Type> types = const <Type>[ApplicationSubmitRequestTierEnum];
  @override
  final String wireName = 'ApplicationSubmitRequestTierEnum';

  @override
  Object serialize(
          Serializers serializers, ApplicationSubmitRequestTierEnum object,
          {FullType specifiedType = FullType.unspecified}) =>
      _toWire[object.name] ?? object.name;

  @override
  ApplicationSubmitRequestTierEnum deserialize(
          Serializers serializers, Object serialized,
          {FullType specifiedType = FullType.unspecified}) =>
      ApplicationSubmitRequestTierEnum.valueOf(
          _fromWire[serialized] ?? (serialized is String ? serialized : ''));
}

class _$ApplicationSubmitRequest extends ApplicationSubmitRequest {
  @override
  final String agentCode;
  @override
  final String businessName;
  @override
  final ApplicationSubmitRequestTierEnum tier;
  @override
  final String mykadNumber;
  @override
  final String phoneNumber;
  @override
  final num merchantGpsLat;
  @override
  final num merchantGpsLng;
  @override
  final String? email;
  @override
  final String? address;

  factory _$ApplicationSubmitRequest(
          [void Function(ApplicationSubmitRequestBuilder)? updates]) =>
      (ApplicationSubmitRequestBuilder()..update(updates))._build();

  _$ApplicationSubmitRequest._(
      {required this.agentCode,
      required this.businessName,
      required this.tier,
      required this.mykadNumber,
      required this.phoneNumber,
      required this.merchantGpsLat,
      required this.merchantGpsLng,
      this.email,
      this.address})
      : super._();
  @override
  ApplicationSubmitRequest rebuild(
          void Function(ApplicationSubmitRequestBuilder) updates) =>
      (toBuilder()..update(updates)).build();

  @override
  ApplicationSubmitRequestBuilder toBuilder() =>
      ApplicationSubmitRequestBuilder()..replace(this);

  @override
  bool operator ==(Object other) {
    if (identical(other, this)) return true;
    return other is ApplicationSubmitRequest &&
        agentCode == other.agentCode &&
        businessName == other.businessName &&
        tier == other.tier &&
        mykadNumber == other.mykadNumber &&
        phoneNumber == other.phoneNumber &&
        merchantGpsLat == other.merchantGpsLat &&
        merchantGpsLng == other.merchantGpsLng &&
        email == other.email &&
        address == other.address;
  }

  @override
  int get hashCode {
    var _$hash = 0;
    _$hash = $jc(_$hash, agentCode.hashCode);
    _$hash = $jc(_$hash, businessName.hashCode);
    _$hash = $jc(_$hash, tier.hashCode);
    _$hash = $jc(_$hash, mykadNumber.hashCode);
    _$hash = $jc(_$hash, phoneNumber.hashCode);
    _$hash = $jc(_$hash, merchantGpsLat.hashCode);
    _$hash = $jc(_$hash, merchantGpsLng.hashCode);
    _$hash = $jc(_$hash, email.hashCode);
    _$hash = $jc(_$hash, address.hashCode);
    _$hash = $jf(_$hash);
    return _$hash;
  }

  @override
  String toString() {
    return (newBuiltValueToStringHelper(r'ApplicationSubmitRequest')
          ..add('agentCode', agentCode)
          ..add('businessName', businessName)
          ..add('tier', tier)
          ..add('mykadNumber', mykadNumber)
          ..add('phoneNumber', phoneNumber)
          ..add('merchantGpsLat', merchantGpsLat)
          ..add('merchantGpsLng', merchantGpsLng)
          ..add('email', email)
          ..add('address', address))
        .toString();
  }
}

class ApplicationSubmitRequestBuilder
    implements
        Builder<ApplicationSubmitRequest, ApplicationSubmitRequestBuilder> {
  _$ApplicationSubmitRequest? _$v;

  String? _agentCode;
  String? get agentCode => _$this._agentCode;
  set agentCode(String? agentCode) => _$this._agentCode = agentCode;

  String? _businessName;
  String? get businessName => _$this._businessName;
  set businessName(String? businessName) => _$this._businessName = businessName;

  ApplicationSubmitRequestTierEnum? _tier;
  ApplicationSubmitRequestTierEnum? get tier => _$this._tier;
  set tier(ApplicationSubmitRequestTierEnum? tier) => _$this._tier = tier;

  String? _mykadNumber;
  String? get mykadNumber => _$this._mykadNumber;
  set mykadNumber(String? mykadNumber) => _$this._mykadNumber = mykadNumber;

  String? _phoneNumber;
  String? get phoneNumber => _$this._phoneNumber;
  set phoneNumber(String? phoneNumber) => _$this._phoneNumber = phoneNumber;

  num? _merchantGpsLat;
  num? get merchantGpsLat => _$this._merchantGpsLat;
  set merchantGpsLat(num? merchantGpsLat) =>
      _$this._merchantGpsLat = merchantGpsLat;

  num? _merchantGpsLng;
  num? get merchantGpsLng => _$this._merchantGpsLng;
  set merchantGpsLng(num? merchantGpsLng) =>
      _$this._merchantGpsLng = merchantGpsLng;

  String? _email;
  String? get email => _$this._email;
  set email(String? email) => _$this._email = email;

  String? _address;
  String? get address => _$this._address;
  set address(String? address) => _$this._address = address;

  ApplicationSubmitRequestBuilder() {
    ApplicationSubmitRequest._defaults(this);
  }

  ApplicationSubmitRequestBuilder get _$this {
    final $v = _$v;
    if ($v != null) {
      _agentCode = $v.agentCode;
      _businessName = $v.businessName;
      _tier = $v.tier;
      _mykadNumber = $v.mykadNumber;
      _phoneNumber = $v.phoneNumber;
      _merchantGpsLat = $v.merchantGpsLat;
      _merchantGpsLng = $v.merchantGpsLng;
      _email = $v.email;
      _address = $v.address;
      _$v = null;
    }
    return this;
  }

  @override
  void replace(ApplicationSubmitRequest other) {
    _$v = other as _$ApplicationSubmitRequest;
  }

  @override
  void update(void Function(ApplicationSubmitRequestBuilder)? updates) {
    if (updates != null) updates(this);
  }

  @override
  ApplicationSubmitRequest build() => _build();

  _$ApplicationSubmitRequest _build() {
    final _$result = _$v ??
        _$ApplicationSubmitRequest._(
          agentCode: BuiltValueNullFieldError.checkNotNull(
              agentCode, r'ApplicationSubmitRequest', 'agentCode'),
          businessName: BuiltValueNullFieldError.checkNotNull(
              businessName, r'ApplicationSubmitRequest', 'businessName'),
          tier: BuiltValueNullFieldError.checkNotNull(
              tier, r'ApplicationSubmitRequest', 'tier'),
          mykadNumber: BuiltValueNullFieldError.checkNotNull(
              mykadNumber, r'ApplicationSubmitRequest', 'mykadNumber'),
          phoneNumber: BuiltValueNullFieldError.checkNotNull(
              phoneNumber, r'ApplicationSubmitRequest', 'phoneNumber'),
          merchantGpsLat: BuiltValueNullFieldError.checkNotNull(
              merchantGpsLat, r'ApplicationSubmitRequest', 'merchantGpsLat'),
          merchantGpsLng: BuiltValueNullFieldError.checkNotNull(
              merchantGpsLng, r'ApplicationSubmitRequest', 'merchantGpsLng'),
          email: email,
          address: address,
        );
    replace(_$result);
    return _$result;
  }
}

// ignore_for_file: deprecated_member_use_from_same_package,type=lint
