// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'submission_request.dart';

// **************************************************************************
// BuiltValueGenerator
// **************************************************************************

const SubmissionRequestAgentTierEnum _$submissionRequestAgentTierEnum_MICRO =
    const SubmissionRequestAgentTierEnum._('MICRO');
const SubmissionRequestAgentTierEnum _$submissionRequestAgentTierEnum_STANDARD =
    const SubmissionRequestAgentTierEnum._('STANDARD');
const SubmissionRequestAgentTierEnum _$submissionRequestAgentTierEnum_PREMIER =
    const SubmissionRequestAgentTierEnum._('PREMIER');

SubmissionRequestAgentTierEnum _$submissionRequestAgentTierEnumValueOf(
    String name) {
  switch (name) {
    case 'MICRO':
      return _$submissionRequestAgentTierEnum_MICRO;
    case 'STANDARD':
      return _$submissionRequestAgentTierEnum_STANDARD;
    case 'PREMIER':
      return _$submissionRequestAgentTierEnum_PREMIER;
    default:
      throw ArgumentError(name);
  }
}

final BuiltSet<SubmissionRequestAgentTierEnum>
    _$submissionRequestAgentTierEnumValues = BuiltSet<
        SubmissionRequestAgentTierEnum>(const <SubmissionRequestAgentTierEnum>[
  _$submissionRequestAgentTierEnum_MICRO,
  _$submissionRequestAgentTierEnum_STANDARD,
  _$submissionRequestAgentTierEnum_PREMIER,
]);

Serializer<SubmissionRequestAgentTierEnum>
    _$submissionRequestAgentTierEnumSerializer =
    _$SubmissionRequestAgentTierEnumSerializer();

class _$SubmissionRequestAgentTierEnumSerializer
    implements PrimitiveSerializer<SubmissionRequestAgentTierEnum> {
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
  final Iterable<Type> types = const <Type>[SubmissionRequestAgentTierEnum];
  @override
  final String wireName = 'SubmissionRequestAgentTierEnum';

  @override
  Object serialize(
          Serializers serializers, SubmissionRequestAgentTierEnum object,
          {FullType specifiedType = FullType.unspecified}) =>
      _toWire[object.name] ?? object.name;

  @override
  SubmissionRequestAgentTierEnum deserialize(
          Serializers serializers, Object serialized,
          {FullType specifiedType = FullType.unspecified}) =>
      SubmissionRequestAgentTierEnum.valueOf(
          _fromWire[serialized] ?? (serialized is String ? serialized : ''));
}

class _$SubmissionRequest extends SubmissionRequest {
  @override
  final String mykadNumber;
  @override
  final String extractedName;
  @override
  final String ssmBusinessName;
  @override
  final String ssmOwnerName;
  @override
  final SubmissionRequestAgentTierEnum agentTier;
  @override
  final num? merchantGpsLat;
  @override
  final num? merchantGpsLng;
  @override
  final String? phoneNumber;

  factory _$SubmissionRequest(
          [void Function(SubmissionRequestBuilder)? updates]) =>
      (SubmissionRequestBuilder()..update(updates))._build();

  _$SubmissionRequest._(
      {required this.mykadNumber,
      required this.extractedName,
      required this.ssmBusinessName,
      required this.ssmOwnerName,
      required this.agentTier,
      this.merchantGpsLat,
      this.merchantGpsLng,
      this.phoneNumber})
      : super._();
  @override
  SubmissionRequest rebuild(void Function(SubmissionRequestBuilder) updates) =>
      (toBuilder()..update(updates)).build();

  @override
  SubmissionRequestBuilder toBuilder() =>
      SubmissionRequestBuilder()..replace(this);

  @override
  bool operator ==(Object other) {
    if (identical(other, this)) return true;
    return other is SubmissionRequest &&
        mykadNumber == other.mykadNumber &&
        extractedName == other.extractedName &&
        ssmBusinessName == other.ssmBusinessName &&
        ssmOwnerName == other.ssmOwnerName &&
        agentTier == other.agentTier &&
        merchantGpsLat == other.merchantGpsLat &&
        merchantGpsLng == other.merchantGpsLng &&
        phoneNumber == other.phoneNumber;
  }

  @override
  int get hashCode {
    var _$hash = 0;
    _$hash = $jc(_$hash, mykadNumber.hashCode);
    _$hash = $jc(_$hash, extractedName.hashCode);
    _$hash = $jc(_$hash, ssmBusinessName.hashCode);
    _$hash = $jc(_$hash, ssmOwnerName.hashCode);
    _$hash = $jc(_$hash, agentTier.hashCode);
    _$hash = $jc(_$hash, merchantGpsLat.hashCode);
    _$hash = $jc(_$hash, merchantGpsLng.hashCode);
    _$hash = $jc(_$hash, phoneNumber.hashCode);
    _$hash = $jf(_$hash);
    return _$hash;
  }

  @override
  String toString() {
    return (newBuiltValueToStringHelper(r'SubmissionRequest')
          ..add('mykadNumber', mykadNumber)
          ..add('extractedName', extractedName)
          ..add('ssmBusinessName', ssmBusinessName)
          ..add('ssmOwnerName', ssmOwnerName)
          ..add('agentTier', agentTier)
          ..add('merchantGpsLat', merchantGpsLat)
          ..add('merchantGpsLng', merchantGpsLng)
          ..add('phoneNumber', phoneNumber))
        .toString();
  }
}

class SubmissionRequestBuilder
    implements Builder<SubmissionRequest, SubmissionRequestBuilder> {
  _$SubmissionRequest? _$v;

  String? _mykadNumber;
  String? get mykadNumber => _$this._mykadNumber;
  set mykadNumber(String? mykadNumber) => _$this._mykadNumber = mykadNumber;

  String? _extractedName;
  String? get extractedName => _$this._extractedName;
  set extractedName(String? extractedName) =>
      _$this._extractedName = extractedName;

  String? _ssmBusinessName;
  String? get ssmBusinessName => _$this._ssmBusinessName;
  set ssmBusinessName(String? ssmBusinessName) =>
      _$this._ssmBusinessName = ssmBusinessName;

  String? _ssmOwnerName;
  String? get ssmOwnerName => _$this._ssmOwnerName;
  set ssmOwnerName(String? ssmOwnerName) => _$this._ssmOwnerName = ssmOwnerName;

  SubmissionRequestAgentTierEnum? _agentTier;
  SubmissionRequestAgentTierEnum? get agentTier => _$this._agentTier;
  set agentTier(SubmissionRequestAgentTierEnum? agentTier) =>
      _$this._agentTier = agentTier;

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

  SubmissionRequestBuilder() {
    SubmissionRequest._defaults(this);
  }

  SubmissionRequestBuilder get _$this {
    final $v = _$v;
    if ($v != null) {
      _mykadNumber = $v.mykadNumber;
      _extractedName = $v.extractedName;
      _ssmBusinessName = $v.ssmBusinessName;
      _ssmOwnerName = $v.ssmOwnerName;
      _agentTier = $v.agentTier;
      _merchantGpsLat = $v.merchantGpsLat;
      _merchantGpsLng = $v.merchantGpsLng;
      _phoneNumber = $v.phoneNumber;
      _$v = null;
    }
    return this;
  }

  @override
  void replace(SubmissionRequest other) {
    _$v = other as _$SubmissionRequest;
  }

  @override
  void update(void Function(SubmissionRequestBuilder)? updates) {
    if (updates != null) updates(this);
  }

  @override
  SubmissionRequest build() => _build();

  _$SubmissionRequest _build() {
    final _$result = _$v ??
        _$SubmissionRequest._(
          mykadNumber: BuiltValueNullFieldError.checkNotNull(
              mykadNumber, r'SubmissionRequest', 'mykadNumber'),
          extractedName: BuiltValueNullFieldError.checkNotNull(
              extractedName, r'SubmissionRequest', 'extractedName'),
          ssmBusinessName: BuiltValueNullFieldError.checkNotNull(
              ssmBusinessName, r'SubmissionRequest', 'ssmBusinessName'),
          ssmOwnerName: BuiltValueNullFieldError.checkNotNull(
              ssmOwnerName, r'SubmissionRequest', 'ssmOwnerName'),
          agentTier: BuiltValueNullFieldError.checkNotNull(
              agentTier, r'SubmissionRequest', 'agentTier'),
          merchantGpsLat: merchantGpsLat,
          merchantGpsLng: merchantGpsLng,
          phoneNumber: phoneNumber,
        );
    replace(_$result);
    return _$result;
  }
}

// ignore_for_file: deprecated_member_use_from_same_package,type=lint
