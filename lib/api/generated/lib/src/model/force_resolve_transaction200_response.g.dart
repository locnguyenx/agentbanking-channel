// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'force_resolve_transaction200_response.dart';

// **************************************************************************
// BuiltValueGenerator
// **************************************************************************

const ForceResolveTransaction200ResponseActionEnum
    _$forceResolveTransaction200ResponseActionEnum_MANUAL_RETRY =
    const ForceResolveTransaction200ResponseActionEnum._('MANUAL_RETRY');
const ForceResolveTransaction200ResponseActionEnum
    _$forceResolveTransaction200ResponseActionEnum_MANUAL_CANCEL =
    const ForceResolveTransaction200ResponseActionEnum._('MANUAL_CANCEL');
const ForceResolveTransaction200ResponseActionEnum
    _$forceResolveTransaction200ResponseActionEnum_MANUAL_COMPLETE =
    const ForceResolveTransaction200ResponseActionEnum._('MANUAL_COMPLETE');

ForceResolveTransaction200ResponseActionEnum
    _$forceResolveTransaction200ResponseActionEnumValueOf(String name) {
  switch (name) {
    case 'MANUAL_RETRY':
      return _$forceResolveTransaction200ResponseActionEnum_MANUAL_RETRY;
    case 'MANUAL_CANCEL':
      return _$forceResolveTransaction200ResponseActionEnum_MANUAL_CANCEL;
    case 'MANUAL_COMPLETE':
      return _$forceResolveTransaction200ResponseActionEnum_MANUAL_COMPLETE;
    default:
      throw ArgumentError(name);
  }
}

final BuiltSet<ForceResolveTransaction200ResponseActionEnum>
    _$forceResolveTransaction200ResponseActionEnumValues = BuiltSet<
        ForceResolveTransaction200ResponseActionEnum>(const <ForceResolveTransaction200ResponseActionEnum>[
  _$forceResolveTransaction200ResponseActionEnum_MANUAL_RETRY,
  _$forceResolveTransaction200ResponseActionEnum_MANUAL_CANCEL,
  _$forceResolveTransaction200ResponseActionEnum_MANUAL_COMPLETE,
]);

Serializer<ForceResolveTransaction200ResponseActionEnum>
    _$forceResolveTransaction200ResponseActionEnumSerializer =
    _$ForceResolveTransaction200ResponseActionEnumSerializer();

class _$ForceResolveTransaction200ResponseActionEnumSerializer
    implements
        PrimitiveSerializer<ForceResolveTransaction200ResponseActionEnum> {
  static const Map<String, Object> _toWire = const <String, Object>{
    'MANUAL_RETRY': 'MANUAL_RETRY',
    'MANUAL_CANCEL': 'MANUAL_CANCEL',
    'MANUAL_COMPLETE': 'MANUAL_COMPLETE',
  };
  static const Map<Object, String> _fromWire = const <Object, String>{
    'MANUAL_RETRY': 'MANUAL_RETRY',
    'MANUAL_CANCEL': 'MANUAL_CANCEL',
    'MANUAL_COMPLETE': 'MANUAL_COMPLETE',
  };

  @override
  final Iterable<Type> types = const <Type>[
    ForceResolveTransaction200ResponseActionEnum
  ];
  @override
  final String wireName = 'ForceResolveTransaction200ResponseActionEnum';

  @override
  Object serialize(Serializers serializers,
          ForceResolveTransaction200ResponseActionEnum object,
          {FullType specifiedType = FullType.unspecified}) =>
      _toWire[object.name] ?? object.name;

  @override
  ForceResolveTransaction200ResponseActionEnum deserialize(
          Serializers serializers, Object serialized,
          {FullType specifiedType = FullType.unspecified}) =>
      ForceResolveTransaction200ResponseActionEnum.valueOf(
          _fromWire[serialized] ?? (serialized is String ? serialized : ''));
}

class _$ForceResolveTransaction200Response
    extends ForceResolveTransaction200Response {
  @override
  final ForceResolveTransaction200ResponseActionEnum action;
  @override
  final String? reason;
  @override
  final String? status;
  @override
  final String? message;

  factory _$ForceResolveTransaction200Response(
          [void Function(ForceResolveTransaction200ResponseBuilder)?
              updates]) =>
      (ForceResolveTransaction200ResponseBuilder()..update(updates))._build();

  _$ForceResolveTransaction200Response._(
      {required this.action, this.reason, this.status, this.message})
      : super._();
  @override
  ForceResolveTransaction200Response rebuild(
          void Function(ForceResolveTransaction200ResponseBuilder) updates) =>
      (toBuilder()..update(updates)).build();

  @override
  ForceResolveTransaction200ResponseBuilder toBuilder() =>
      ForceResolveTransaction200ResponseBuilder()..replace(this);

  @override
  bool operator ==(Object other) {
    if (identical(other, this)) return true;
    return other is ForceResolveTransaction200Response &&
        action == other.action &&
        reason == other.reason &&
        status == other.status &&
        message == other.message;
  }

  @override
  int get hashCode {
    var _$hash = 0;
    _$hash = $jc(_$hash, action.hashCode);
    _$hash = $jc(_$hash, reason.hashCode);
    _$hash = $jc(_$hash, status.hashCode);
    _$hash = $jc(_$hash, message.hashCode);
    _$hash = $jf(_$hash);
    return _$hash;
  }

  @override
  String toString() {
    return (newBuiltValueToStringHelper(r'ForceResolveTransaction200Response')
          ..add('action', action)
          ..add('reason', reason)
          ..add('status', status)
          ..add('message', message))
        .toString();
  }
}

class ForceResolveTransaction200ResponseBuilder
    implements
        Builder<ForceResolveTransaction200Response,
            ForceResolveTransaction200ResponseBuilder> {
  _$ForceResolveTransaction200Response? _$v;

  ForceResolveTransaction200ResponseActionEnum? _action;
  ForceResolveTransaction200ResponseActionEnum? get action => _$this._action;
  set action(ForceResolveTransaction200ResponseActionEnum? action) =>
      _$this._action = action;

  String? _reason;
  String? get reason => _$this._reason;
  set reason(String? reason) => _$this._reason = reason;

  String? _status;
  String? get status => _$this._status;
  set status(String? status) => _$this._status = status;

  String? _message;
  String? get message => _$this._message;
  set message(String? message) => _$this._message = message;

  ForceResolveTransaction200ResponseBuilder() {
    ForceResolveTransaction200Response._defaults(this);
  }

  ForceResolveTransaction200ResponseBuilder get _$this {
    final $v = _$v;
    if ($v != null) {
      _action = $v.action;
      _reason = $v.reason;
      _status = $v.status;
      _message = $v.message;
      _$v = null;
    }
    return this;
  }

  @override
  void replace(ForceResolveTransaction200Response other) {
    _$v = other as _$ForceResolveTransaction200Response;
  }

  @override
  void update(
      void Function(ForceResolveTransaction200ResponseBuilder)? updates) {
    if (updates != null) updates(this);
  }

  @override
  ForceResolveTransaction200Response build() => _build();

  _$ForceResolveTransaction200Response _build() {
    final _$result = _$v ??
        _$ForceResolveTransaction200Response._(
          action: BuiltValueNullFieldError.checkNotNull(
              action, r'ForceResolveTransaction200Response', 'action'),
          reason: reason,
          status: status,
          message: message,
        );
    replace(_$result);
    return _$result;
  }
}

// ignore_for_file: deprecated_member_use_from_same_package,type=lint
