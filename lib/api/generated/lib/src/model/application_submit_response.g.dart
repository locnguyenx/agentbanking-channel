// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'application_submit_response.dart';

// **************************************************************************
// BuiltValueGenerator
// **************************************************************************

const ApplicationSubmitResponseStatusEnum
    _$applicationSubmitResponseStatusEnum_SUBMITTED =
    const ApplicationSubmitResponseStatusEnum._('SUBMITTED');
const ApplicationSubmitResponseStatusEnum
    _$applicationSubmitResponseStatusEnum_PENDING_REVIEW =
    const ApplicationSubmitResponseStatusEnum._('PENDING_REVIEW');
const ApplicationSubmitResponseStatusEnum
    _$applicationSubmitResponseStatusEnum_APPROVED =
    const ApplicationSubmitResponseStatusEnum._('APPROVED');
const ApplicationSubmitResponseStatusEnum
    _$applicationSubmitResponseStatusEnum_REJECTED =
    const ApplicationSubmitResponseStatusEnum._('REJECTED');

ApplicationSubmitResponseStatusEnum
    _$applicationSubmitResponseStatusEnumValueOf(String name) {
  switch (name) {
    case 'SUBMITTED':
      return _$applicationSubmitResponseStatusEnum_SUBMITTED;
    case 'PENDING_REVIEW':
      return _$applicationSubmitResponseStatusEnum_PENDING_REVIEW;
    case 'APPROVED':
      return _$applicationSubmitResponseStatusEnum_APPROVED;
    case 'REJECTED':
      return _$applicationSubmitResponseStatusEnum_REJECTED;
    default:
      throw ArgumentError(name);
  }
}

final BuiltSet<ApplicationSubmitResponseStatusEnum>
    _$applicationSubmitResponseStatusEnumValues = BuiltSet<
        ApplicationSubmitResponseStatusEnum>(const <ApplicationSubmitResponseStatusEnum>[
  _$applicationSubmitResponseStatusEnum_SUBMITTED,
  _$applicationSubmitResponseStatusEnum_PENDING_REVIEW,
  _$applicationSubmitResponseStatusEnum_APPROVED,
  _$applicationSubmitResponseStatusEnum_REJECTED,
]);

Serializer<ApplicationSubmitResponseStatusEnum>
    _$applicationSubmitResponseStatusEnumSerializer =
    _$ApplicationSubmitResponseStatusEnumSerializer();

class _$ApplicationSubmitResponseStatusEnumSerializer
    implements PrimitiveSerializer<ApplicationSubmitResponseStatusEnum> {
  static const Map<String, Object> _toWire = const <String, Object>{
    'SUBMITTED': 'SUBMITTED',
    'PENDING_REVIEW': 'PENDING_REVIEW',
    'APPROVED': 'APPROVED',
    'REJECTED': 'REJECTED',
  };
  static const Map<Object, String> _fromWire = const <Object, String>{
    'SUBMITTED': 'SUBMITTED',
    'PENDING_REVIEW': 'PENDING_REVIEW',
    'APPROVED': 'APPROVED',
    'REJECTED': 'REJECTED',
  };

  @override
  final Iterable<Type> types = const <Type>[
    ApplicationSubmitResponseStatusEnum
  ];
  @override
  final String wireName = 'ApplicationSubmitResponseStatusEnum';

  @override
  Object serialize(
          Serializers serializers, ApplicationSubmitResponseStatusEnum object,
          {FullType specifiedType = FullType.unspecified}) =>
      _toWire[object.name] ?? object.name;

  @override
  ApplicationSubmitResponseStatusEnum deserialize(
          Serializers serializers, Object serialized,
          {FullType specifiedType = FullType.unspecified}) =>
      ApplicationSubmitResponseStatusEnum.valueOf(
          _fromWire[serialized] ?? (serialized is String ? serialized : ''));
}

class _$ApplicationSubmitResponse extends ApplicationSubmitResponse {
  @override
  final String? applicationId;
  @override
  final ApplicationSubmitResponseStatusEnum? status;
  @override
  final String? message;
  @override
  final DateTime? submittedAt;

  factory _$ApplicationSubmitResponse(
          [void Function(ApplicationSubmitResponseBuilder)? updates]) =>
      (ApplicationSubmitResponseBuilder()..update(updates))._build();

  _$ApplicationSubmitResponse._(
      {this.applicationId, this.status, this.message, this.submittedAt})
      : super._();
  @override
  ApplicationSubmitResponse rebuild(
          void Function(ApplicationSubmitResponseBuilder) updates) =>
      (toBuilder()..update(updates)).build();

  @override
  ApplicationSubmitResponseBuilder toBuilder() =>
      ApplicationSubmitResponseBuilder()..replace(this);

  @override
  bool operator ==(Object other) {
    if (identical(other, this)) return true;
    return other is ApplicationSubmitResponse &&
        applicationId == other.applicationId &&
        status == other.status &&
        message == other.message &&
        submittedAt == other.submittedAt;
  }

  @override
  int get hashCode {
    var _$hash = 0;
    _$hash = $jc(_$hash, applicationId.hashCode);
    _$hash = $jc(_$hash, status.hashCode);
    _$hash = $jc(_$hash, message.hashCode);
    _$hash = $jc(_$hash, submittedAt.hashCode);
    _$hash = $jf(_$hash);
    return _$hash;
  }

  @override
  String toString() {
    return (newBuiltValueToStringHelper(r'ApplicationSubmitResponse')
          ..add('applicationId', applicationId)
          ..add('status', status)
          ..add('message', message)
          ..add('submittedAt', submittedAt))
        .toString();
  }
}

class ApplicationSubmitResponseBuilder
    implements
        Builder<ApplicationSubmitResponse, ApplicationSubmitResponseBuilder> {
  _$ApplicationSubmitResponse? _$v;

  String? _applicationId;
  String? get applicationId => _$this._applicationId;
  set applicationId(String? applicationId) =>
      _$this._applicationId = applicationId;

  ApplicationSubmitResponseStatusEnum? _status;
  ApplicationSubmitResponseStatusEnum? get status => _$this._status;
  set status(ApplicationSubmitResponseStatusEnum? status) =>
      _$this._status = status;

  String? _message;
  String? get message => _$this._message;
  set message(String? message) => _$this._message = message;

  DateTime? _submittedAt;
  DateTime? get submittedAt => _$this._submittedAt;
  set submittedAt(DateTime? submittedAt) => _$this._submittedAt = submittedAt;

  ApplicationSubmitResponseBuilder() {
    ApplicationSubmitResponse._defaults(this);
  }

  ApplicationSubmitResponseBuilder get _$this {
    final $v = _$v;
    if ($v != null) {
      _applicationId = $v.applicationId;
      _status = $v.status;
      _message = $v.message;
      _submittedAt = $v.submittedAt;
      _$v = null;
    }
    return this;
  }

  @override
  void replace(ApplicationSubmitResponse other) {
    _$v = other as _$ApplicationSubmitResponse;
  }

  @override
  void update(void Function(ApplicationSubmitResponseBuilder)? updates) {
    if (updates != null) updates(this);
  }

  @override
  ApplicationSubmitResponse build() => _build();

  _$ApplicationSubmitResponse _build() {
    final _$result = _$v ??
        _$ApplicationSubmitResponse._(
          applicationId: applicationId,
          status: status,
          message: message,
          submittedAt: submittedAt,
        );
    replace(_$result);
    return _$result;
  }
}

// ignore_for_file: deprecated_member_use_from_same_package,type=lint
