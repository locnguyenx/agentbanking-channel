// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'compliance_status_response.dart';

// **************************************************************************
// BuiltValueGenerator
// **************************************************************************

const ComplianceStatusResponseStatusEnum
    _$complianceStatusResponseStatusEnum_LOCKED =
    const ComplianceStatusResponseStatusEnum._('LOCKED');
const ComplianceStatusResponseStatusEnum
    _$complianceStatusResponseStatusEnum_UNLOCKED =
    const ComplianceStatusResponseStatusEnum._('UNLOCKED');

ComplianceStatusResponseStatusEnum _$complianceStatusResponseStatusEnumValueOf(
    String name) {
  switch (name) {
    case 'LOCKED':
      return _$complianceStatusResponseStatusEnum_LOCKED;
    case 'UNLOCKED':
      return _$complianceStatusResponseStatusEnum_UNLOCKED;
    default:
      throw ArgumentError(name);
  }
}

final BuiltSet<ComplianceStatusResponseStatusEnum>
    _$complianceStatusResponseStatusEnumValues = BuiltSet<
        ComplianceStatusResponseStatusEnum>(const <ComplianceStatusResponseStatusEnum>[
  _$complianceStatusResponseStatusEnum_LOCKED,
  _$complianceStatusResponseStatusEnum_UNLOCKED,
]);

Serializer<ComplianceStatusResponseStatusEnum>
    _$complianceStatusResponseStatusEnumSerializer =
    _$ComplianceStatusResponseStatusEnumSerializer();

class _$ComplianceStatusResponseStatusEnumSerializer
    implements PrimitiveSerializer<ComplianceStatusResponseStatusEnum> {
  static const Map<String, Object> _toWire = const <String, Object>{
    'LOCKED': 'LOCKED',
    'UNLOCKED': 'UNLOCKED',
  };
  static const Map<Object, String> _fromWire = const <Object, String>{
    'LOCKED': 'LOCKED',
    'UNLOCKED': 'UNLOCKED',
  };

  @override
  final Iterable<Type> types = const <Type>[ComplianceStatusResponseStatusEnum];
  @override
  final String wireName = 'ComplianceStatusResponseStatusEnum';

  @override
  Object serialize(
          Serializers serializers, ComplianceStatusResponseStatusEnum object,
          {FullType specifiedType = FullType.unspecified}) =>
      _toWire[object.name] ?? object.name;

  @override
  ComplianceStatusResponseStatusEnum deserialize(
          Serializers serializers, Object serialized,
          {FullType specifiedType = FullType.unspecified}) =>
      ComplianceStatusResponseStatusEnum.valueOf(
          _fromWire[serialized] ?? (serialized is String ? serialized : ''));
}

class _$ComplianceStatusResponse extends ComplianceStatusResponse {
  @override
  final ComplianceStatusResponseStatusEnum? status;
  @override
  final String? reason;
  @override
  final DateTime? checkedAt;

  factory _$ComplianceStatusResponse(
          [void Function(ComplianceStatusResponseBuilder)? updates]) =>
      (ComplianceStatusResponseBuilder()..update(updates))._build();

  _$ComplianceStatusResponse._({this.status, this.reason, this.checkedAt})
      : super._();
  @override
  ComplianceStatusResponse rebuild(
          void Function(ComplianceStatusResponseBuilder) updates) =>
      (toBuilder()..update(updates)).build();

  @override
  ComplianceStatusResponseBuilder toBuilder() =>
      ComplianceStatusResponseBuilder()..replace(this);

  @override
  bool operator ==(Object other) {
    if (identical(other, this)) return true;
    return other is ComplianceStatusResponse &&
        status == other.status &&
        reason == other.reason &&
        checkedAt == other.checkedAt;
  }

  @override
  int get hashCode {
    var _$hash = 0;
    _$hash = $jc(_$hash, status.hashCode);
    _$hash = $jc(_$hash, reason.hashCode);
    _$hash = $jc(_$hash, checkedAt.hashCode);
    _$hash = $jf(_$hash);
    return _$hash;
  }

  @override
  String toString() {
    return (newBuiltValueToStringHelper(r'ComplianceStatusResponse')
          ..add('status', status)
          ..add('reason', reason)
          ..add('checkedAt', checkedAt))
        .toString();
  }
}

class ComplianceStatusResponseBuilder
    implements
        Builder<ComplianceStatusResponse, ComplianceStatusResponseBuilder> {
  _$ComplianceStatusResponse? _$v;

  ComplianceStatusResponseStatusEnum? _status;
  ComplianceStatusResponseStatusEnum? get status => _$this._status;
  set status(ComplianceStatusResponseStatusEnum? status) =>
      _$this._status = status;

  String? _reason;
  String? get reason => _$this._reason;
  set reason(String? reason) => _$this._reason = reason;

  DateTime? _checkedAt;
  DateTime? get checkedAt => _$this._checkedAt;
  set checkedAt(DateTime? checkedAt) => _$this._checkedAt = checkedAt;

  ComplianceStatusResponseBuilder() {
    ComplianceStatusResponse._defaults(this);
  }

  ComplianceStatusResponseBuilder get _$this {
    final $v = _$v;
    if ($v != null) {
      _status = $v.status;
      _reason = $v.reason;
      _checkedAt = $v.checkedAt;
      _$v = null;
    }
    return this;
  }

  @override
  void replace(ComplianceStatusResponse other) {
    _$v = other as _$ComplianceStatusResponse;
  }

  @override
  void update(void Function(ComplianceStatusResponseBuilder)? updates) {
    if (updates != null) updates(this);
  }

  @override
  ComplianceStatusResponse build() => _build();

  _$ComplianceStatusResponse _build() {
    final _$result = _$v ??
        _$ComplianceStatusResponse._(
          status: status,
          reason: reason,
          checkedAt: checkedAt,
        );
    replace(_$result);
    return _$result;
  }
}

// ignore_for_file: deprecated_member_use_from_same_package,type=lint
