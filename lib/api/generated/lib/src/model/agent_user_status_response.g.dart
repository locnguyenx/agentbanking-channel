// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'agent_user_status_response.dart';

// **************************************************************************
// BuiltValueGenerator
// **************************************************************************

const AgentUserStatusResponseStatusEnum
    _$agentUserStatusResponseStatusEnum_PENDING =
    const AgentUserStatusResponseStatusEnum._('PENDING');
const AgentUserStatusResponseStatusEnum
    _$agentUserStatusResponseStatusEnum_CREATED =
    const AgentUserStatusResponseStatusEnum._('CREATED');
const AgentUserStatusResponseStatusEnum
    _$agentUserStatusResponseStatusEnum_FAILED =
    const AgentUserStatusResponseStatusEnum._('FAILED');

AgentUserStatusResponseStatusEnum _$agentUserStatusResponseStatusEnumValueOf(
    String name) {
  switch (name) {
    case 'PENDING':
      return _$agentUserStatusResponseStatusEnum_PENDING;
    case 'CREATED':
      return _$agentUserStatusResponseStatusEnum_CREATED;
    case 'FAILED':
      return _$agentUserStatusResponseStatusEnum_FAILED;
    default:
      throw ArgumentError(name);
  }
}

final BuiltSet<AgentUserStatusResponseStatusEnum>
    _$agentUserStatusResponseStatusEnumValues = BuiltSet<
        AgentUserStatusResponseStatusEnum>(const <AgentUserStatusResponseStatusEnum>[
  _$agentUserStatusResponseStatusEnum_PENDING,
  _$agentUserStatusResponseStatusEnum_CREATED,
  _$agentUserStatusResponseStatusEnum_FAILED,
]);

Serializer<AgentUserStatusResponseStatusEnum>
    _$agentUserStatusResponseStatusEnumSerializer =
    _$AgentUserStatusResponseStatusEnumSerializer();

class _$AgentUserStatusResponseStatusEnumSerializer
    implements PrimitiveSerializer<AgentUserStatusResponseStatusEnum> {
  static const Map<String, Object> _toWire = const <String, Object>{
    'PENDING': 'PENDING',
    'CREATED': 'CREATED',
    'FAILED': 'FAILED',
  };
  static const Map<Object, String> _fromWire = const <Object, String>{
    'PENDING': 'PENDING',
    'CREATED': 'CREATED',
    'FAILED': 'FAILED',
  };

  @override
  final Iterable<Type> types = const <Type>[AgentUserStatusResponseStatusEnum];
  @override
  final String wireName = 'AgentUserStatusResponseStatusEnum';

  @override
  Object serialize(
          Serializers serializers, AgentUserStatusResponseStatusEnum object,
          {FullType specifiedType = FullType.unspecified}) =>
      _toWire[object.name] ?? object.name;

  @override
  AgentUserStatusResponseStatusEnum deserialize(
          Serializers serializers, Object serialized,
          {FullType specifiedType = FullType.unspecified}) =>
      AgentUserStatusResponseStatusEnum.valueOf(
          _fromWire[serialized] ?? (serialized is String ? serialized : ''));
}

class _$AgentUserStatusResponse extends AgentUserStatusResponse {
  @override
  final String? agentId;
  @override
  final AgentUserStatusResponseStatusEnum? status;
  @override
  final String? userId;
  @override
  final String? error;

  factory _$AgentUserStatusResponse(
          [void Function(AgentUserStatusResponseBuilder)? updates]) =>
      (AgentUserStatusResponseBuilder()..update(updates))._build();

  _$AgentUserStatusResponse._(
      {this.agentId, this.status, this.userId, this.error})
      : super._();
  @override
  AgentUserStatusResponse rebuild(
          void Function(AgentUserStatusResponseBuilder) updates) =>
      (toBuilder()..update(updates)).build();

  @override
  AgentUserStatusResponseBuilder toBuilder() =>
      AgentUserStatusResponseBuilder()..replace(this);

  @override
  bool operator ==(Object other) {
    if (identical(other, this)) return true;
    return other is AgentUserStatusResponse &&
        agentId == other.agentId &&
        status == other.status &&
        userId == other.userId &&
        error == other.error;
  }

  @override
  int get hashCode {
    var _$hash = 0;
    _$hash = $jc(_$hash, agentId.hashCode);
    _$hash = $jc(_$hash, status.hashCode);
    _$hash = $jc(_$hash, userId.hashCode);
    _$hash = $jc(_$hash, error.hashCode);
    _$hash = $jf(_$hash);
    return _$hash;
  }

  @override
  String toString() {
    return (newBuiltValueToStringHelper(r'AgentUserStatusResponse')
          ..add('agentId', agentId)
          ..add('status', status)
          ..add('userId', userId)
          ..add('error', error))
        .toString();
  }
}

class AgentUserStatusResponseBuilder
    implements
        Builder<AgentUserStatusResponse, AgentUserStatusResponseBuilder> {
  _$AgentUserStatusResponse? _$v;

  String? _agentId;
  String? get agentId => _$this._agentId;
  set agentId(String? agentId) => _$this._agentId = agentId;

  AgentUserStatusResponseStatusEnum? _status;
  AgentUserStatusResponseStatusEnum? get status => _$this._status;
  set status(AgentUserStatusResponseStatusEnum? status) =>
      _$this._status = status;

  String? _userId;
  String? get userId => _$this._userId;
  set userId(String? userId) => _$this._userId = userId;

  String? _error;
  String? get error => _$this._error;
  set error(String? error) => _$this._error = error;

  AgentUserStatusResponseBuilder() {
    AgentUserStatusResponse._defaults(this);
  }

  AgentUserStatusResponseBuilder get _$this {
    final $v = _$v;
    if ($v != null) {
      _agentId = $v.agentId;
      _status = $v.status;
      _userId = $v.userId;
      _error = $v.error;
      _$v = null;
    }
    return this;
  }

  @override
  void replace(AgentUserStatusResponse other) {
    _$v = other as _$AgentUserStatusResponse;
  }

  @override
  void update(void Function(AgentUserStatusResponseBuilder)? updates) {
    if (updates != null) updates(this);
  }

  @override
  AgentUserStatusResponse build() => _build();

  _$AgentUserStatusResponse _build() {
    final _$result = _$v ??
        _$AgentUserStatusResponse._(
          agentId: agentId,
          status: status,
          userId: userId,
          error: error,
        );
    replace(_$result);
    return _$result;
  }
}

// ignore_for_file: deprecated_member_use_from_same_package,type=lint
