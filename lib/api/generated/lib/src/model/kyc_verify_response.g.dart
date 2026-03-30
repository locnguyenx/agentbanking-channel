// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'kyc_verify_response.dart';

// **************************************************************************
// BuiltValueGenerator
// **************************************************************************

const KycVerifyResponseStatusEnum _$kycVerifyResponseStatusEnum_VERIFIED =
    const KycVerifyResponseStatusEnum._('VERIFIED');
const KycVerifyResponseStatusEnum _$kycVerifyResponseStatusEnum_PENDING =
    const KycVerifyResponseStatusEnum._('PENDING');
const KycVerifyResponseStatusEnum _$kycVerifyResponseStatusEnum_FAILED =
    const KycVerifyResponseStatusEnum._('FAILED');

KycVerifyResponseStatusEnum _$kycVerifyResponseStatusEnumValueOf(String name) {
  switch (name) {
    case 'VERIFIED':
      return _$kycVerifyResponseStatusEnum_VERIFIED;
    case 'PENDING':
      return _$kycVerifyResponseStatusEnum_PENDING;
    case 'FAILED':
      return _$kycVerifyResponseStatusEnum_FAILED;
    default:
      throw ArgumentError(name);
  }
}

final BuiltSet<KycVerifyResponseStatusEnum>
    _$kycVerifyResponseStatusEnumValues =
    BuiltSet<KycVerifyResponseStatusEnum>(const <KycVerifyResponseStatusEnum>[
  _$kycVerifyResponseStatusEnum_VERIFIED,
  _$kycVerifyResponseStatusEnum_PENDING,
  _$kycVerifyResponseStatusEnum_FAILED,
]);

const KycVerifyResponseKycLevelEnum _$kycVerifyResponseKycLevelEnum_BASIC =
    const KycVerifyResponseKycLevelEnum._('BASIC');
const KycVerifyResponseKycLevelEnum
    _$kycVerifyResponseKycLevelEnum_INTERMEDIATE =
    const KycVerifyResponseKycLevelEnum._('INTERMEDIATE');
const KycVerifyResponseKycLevelEnum _$kycVerifyResponseKycLevelEnum_ADVANCED =
    const KycVerifyResponseKycLevelEnum._('ADVANCED');

KycVerifyResponseKycLevelEnum _$kycVerifyResponseKycLevelEnumValueOf(
    String name) {
  switch (name) {
    case 'BASIC':
      return _$kycVerifyResponseKycLevelEnum_BASIC;
    case 'INTERMEDIATE':
      return _$kycVerifyResponseKycLevelEnum_INTERMEDIATE;
    case 'ADVANCED':
      return _$kycVerifyResponseKycLevelEnum_ADVANCED;
    default:
      throw ArgumentError(name);
  }
}

final BuiltSet<KycVerifyResponseKycLevelEnum>
    _$kycVerifyResponseKycLevelEnumValues = BuiltSet<
        KycVerifyResponseKycLevelEnum>(const <KycVerifyResponseKycLevelEnum>[
  _$kycVerifyResponseKycLevelEnum_BASIC,
  _$kycVerifyResponseKycLevelEnum_INTERMEDIATE,
  _$kycVerifyResponseKycLevelEnum_ADVANCED,
]);

Serializer<KycVerifyResponseStatusEnum>
    _$kycVerifyResponseStatusEnumSerializer =
    _$KycVerifyResponseStatusEnumSerializer();
Serializer<KycVerifyResponseKycLevelEnum>
    _$kycVerifyResponseKycLevelEnumSerializer =
    _$KycVerifyResponseKycLevelEnumSerializer();

class _$KycVerifyResponseStatusEnumSerializer
    implements PrimitiveSerializer<KycVerifyResponseStatusEnum> {
  static const Map<String, Object> _toWire = const <String, Object>{
    'VERIFIED': 'VERIFIED',
    'PENDING': 'PENDING',
    'FAILED': 'FAILED',
  };
  static const Map<Object, String> _fromWire = const <Object, String>{
    'VERIFIED': 'VERIFIED',
    'PENDING': 'PENDING',
    'FAILED': 'FAILED',
  };

  @override
  final Iterable<Type> types = const <Type>[KycVerifyResponseStatusEnum];
  @override
  final String wireName = 'KycVerifyResponseStatusEnum';

  @override
  Object serialize(Serializers serializers, KycVerifyResponseStatusEnum object,
          {FullType specifiedType = FullType.unspecified}) =>
      _toWire[object.name] ?? object.name;

  @override
  KycVerifyResponseStatusEnum deserialize(
          Serializers serializers, Object serialized,
          {FullType specifiedType = FullType.unspecified}) =>
      KycVerifyResponseStatusEnum.valueOf(
          _fromWire[serialized] ?? (serialized is String ? serialized : ''));
}

class _$KycVerifyResponseKycLevelEnumSerializer
    implements PrimitiveSerializer<KycVerifyResponseKycLevelEnum> {
  static const Map<String, Object> _toWire = const <String, Object>{
    'BASIC': 'BASIC',
    'INTERMEDIATE': 'INTERMEDIATE',
    'ADVANCED': 'ADVANCED',
  };
  static const Map<Object, String> _fromWire = const <Object, String>{
    'BASIC': 'BASIC',
    'INTERMEDIATE': 'INTERMEDIATE',
    'ADVANCED': 'ADVANCED',
  };

  @override
  final Iterable<Type> types = const <Type>[KycVerifyResponseKycLevelEnum];
  @override
  final String wireName = 'KycVerifyResponseKycLevelEnum';

  @override
  Object serialize(
          Serializers serializers, KycVerifyResponseKycLevelEnum object,
          {FullType specifiedType = FullType.unspecified}) =>
      _toWire[object.name] ?? object.name;

  @override
  KycVerifyResponseKycLevelEnum deserialize(
          Serializers serializers, Object serialized,
          {FullType specifiedType = FullType.unspecified}) =>
      KycVerifyResponseKycLevelEnum.valueOf(
          _fromWire[serialized] ?? (serialized is String ? serialized : ''));
}

class _$KycVerifyResponse extends KycVerifyResponse {
  @override
  final String? verificationId;
  @override
  final KycVerifyResponseStatusEnum? status;
  @override
  final String? message;
  @override
  final KycVerifyResponseKycLevelEnum? kycLevel;
  @override
  final DateTime? expiresAt;

  factory _$KycVerifyResponse(
          [void Function(KycVerifyResponseBuilder)? updates]) =>
      (KycVerifyResponseBuilder()..update(updates))._build();

  _$KycVerifyResponse._(
      {this.verificationId,
      this.status,
      this.message,
      this.kycLevel,
      this.expiresAt})
      : super._();
  @override
  KycVerifyResponse rebuild(void Function(KycVerifyResponseBuilder) updates) =>
      (toBuilder()..update(updates)).build();

  @override
  KycVerifyResponseBuilder toBuilder() =>
      KycVerifyResponseBuilder()..replace(this);

  @override
  bool operator ==(Object other) {
    if (identical(other, this)) return true;
    return other is KycVerifyResponse &&
        verificationId == other.verificationId &&
        status == other.status &&
        message == other.message &&
        kycLevel == other.kycLevel &&
        expiresAt == other.expiresAt;
  }

  @override
  int get hashCode {
    var _$hash = 0;
    _$hash = $jc(_$hash, verificationId.hashCode);
    _$hash = $jc(_$hash, status.hashCode);
    _$hash = $jc(_$hash, message.hashCode);
    _$hash = $jc(_$hash, kycLevel.hashCode);
    _$hash = $jc(_$hash, expiresAt.hashCode);
    _$hash = $jf(_$hash);
    return _$hash;
  }

  @override
  String toString() {
    return (newBuiltValueToStringHelper(r'KycVerifyResponse')
          ..add('verificationId', verificationId)
          ..add('status', status)
          ..add('message', message)
          ..add('kycLevel', kycLevel)
          ..add('expiresAt', expiresAt))
        .toString();
  }
}

class KycVerifyResponseBuilder
    implements Builder<KycVerifyResponse, KycVerifyResponseBuilder> {
  _$KycVerifyResponse? _$v;

  String? _verificationId;
  String? get verificationId => _$this._verificationId;
  set verificationId(String? verificationId) =>
      _$this._verificationId = verificationId;

  KycVerifyResponseStatusEnum? _status;
  KycVerifyResponseStatusEnum? get status => _$this._status;
  set status(KycVerifyResponseStatusEnum? status) => _$this._status = status;

  String? _message;
  String? get message => _$this._message;
  set message(String? message) => _$this._message = message;

  KycVerifyResponseKycLevelEnum? _kycLevel;
  KycVerifyResponseKycLevelEnum? get kycLevel => _$this._kycLevel;
  set kycLevel(KycVerifyResponseKycLevelEnum? kycLevel) =>
      _$this._kycLevel = kycLevel;

  DateTime? _expiresAt;
  DateTime? get expiresAt => _$this._expiresAt;
  set expiresAt(DateTime? expiresAt) => _$this._expiresAt = expiresAt;

  KycVerifyResponseBuilder() {
    KycVerifyResponse._defaults(this);
  }

  KycVerifyResponseBuilder get _$this {
    final $v = _$v;
    if ($v != null) {
      _verificationId = $v.verificationId;
      _status = $v.status;
      _message = $v.message;
      _kycLevel = $v.kycLevel;
      _expiresAt = $v.expiresAt;
      _$v = null;
    }
    return this;
  }

  @override
  void replace(KycVerifyResponse other) {
    _$v = other as _$KycVerifyResponse;
  }

  @override
  void update(void Function(KycVerifyResponseBuilder)? updates) {
    if (updates != null) updates(this);
  }

  @override
  KycVerifyResponse build() => _build();

  _$KycVerifyResponse _build() {
    final _$result = _$v ??
        _$KycVerifyResponse._(
          verificationId: verificationId,
          status: status,
          message: message,
          kycLevel: kycLevel,
          expiresAt: expiresAt,
        );
    replace(_$result);
    return _$result;
  }
}

// ignore_for_file: deprecated_member_use_from_same_package,type=lint
