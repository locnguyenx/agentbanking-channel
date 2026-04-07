// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'force_resolve_request.dart';

// **************************************************************************
// BuiltValueGenerator
// **************************************************************************

const ForceResolveRequestActionEnum _$forceResolveRequestActionEnum_RETRY =
    const ForceResolveRequestActionEnum._('RETRY');
const ForceResolveRequestActionEnum _$forceResolveRequestActionEnum_ABORT =
    const ForceResolveRequestActionEnum._('ABORT');

ForceResolveRequestActionEnum _$forceResolveRequestActionEnumValueOf(
    String name) {
  switch (name) {
    case 'RETRY':
      return _$forceResolveRequestActionEnum_RETRY;
    case 'ABORT':
      return _$forceResolveRequestActionEnum_ABORT;
    default:
      throw ArgumentError(name);
  }
}

final BuiltSet<ForceResolveRequestActionEnum>
    _$forceResolveRequestActionEnumValues = BuiltSet<
        ForceResolveRequestActionEnum>(const <ForceResolveRequestActionEnum>[
  _$forceResolveRequestActionEnum_RETRY,
  _$forceResolveRequestActionEnum_ABORT,
]);

Serializer<ForceResolveRequestActionEnum>
    _$forceResolveRequestActionEnumSerializer =
    _$ForceResolveRequestActionEnumSerializer();

class _$ForceResolveRequestActionEnumSerializer
    implements PrimitiveSerializer<ForceResolveRequestActionEnum> {
  static const Map<String, Object> _toWire = const <String, Object>{
    'RETRY': 'RETRY',
    'ABORT': 'ABORT',
  };
  static const Map<Object, String> _fromWire = const <Object, String>{
    'RETRY': 'RETRY',
    'ABORT': 'ABORT',
  };

  @override
  final Iterable<Type> types = const <Type>[ForceResolveRequestActionEnum];
  @override
  final String wireName = 'ForceResolveRequestActionEnum';

  @override
  Object serialize(
          Serializers serializers, ForceResolveRequestActionEnum object,
          {FullType specifiedType = FullType.unspecified}) =>
      _toWire[object.name] ?? object.name;

  @override
  ForceResolveRequestActionEnum deserialize(
          Serializers serializers, Object serialized,
          {FullType specifiedType = FullType.unspecified}) =>
      ForceResolveRequestActionEnum.valueOf(
          _fromWire[serialized] ?? (serialized is String ? serialized : ''));
}

class _$ForceResolveRequest extends ForceResolveRequest {
  @override
  final ForceResolveRequestActionEnum action;
  @override
  final String? reason;
  @override
  final String adminId;

  factory _$ForceResolveRequest(
          [void Function(ForceResolveRequestBuilder)? updates]) =>
      (ForceResolveRequestBuilder()..update(updates))._build();

  _$ForceResolveRequest._(
      {required this.action, this.reason, required this.adminId})
      : super._();
  @override
  ForceResolveRequest rebuild(
          void Function(ForceResolveRequestBuilder) updates) =>
      (toBuilder()..update(updates)).build();

  @override
  ForceResolveRequestBuilder toBuilder() =>
      ForceResolveRequestBuilder()..replace(this);

  @override
  bool operator ==(Object other) {
    if (identical(other, this)) return true;
    return other is ForceResolveRequest &&
        action == other.action &&
        reason == other.reason &&
        adminId == other.adminId;
  }

  @override
  int get hashCode {
    var _$hash = 0;
    _$hash = $jc(_$hash, action.hashCode);
    _$hash = $jc(_$hash, reason.hashCode);
    _$hash = $jc(_$hash, adminId.hashCode);
    _$hash = $jf(_$hash);
    return _$hash;
  }

  @override
  String toString() {
    return (newBuiltValueToStringHelper(r'ForceResolveRequest')
          ..add('action', action)
          ..add('reason', reason)
          ..add('adminId', adminId))
        .toString();
  }
}

class ForceResolveRequestBuilder
    implements Builder<ForceResolveRequest, ForceResolveRequestBuilder> {
  _$ForceResolveRequest? _$v;

  ForceResolveRequestActionEnum? _action;
  ForceResolveRequestActionEnum? get action => _$this._action;
  set action(ForceResolveRequestActionEnum? action) => _$this._action = action;

  String? _reason;
  String? get reason => _$this._reason;
  set reason(String? reason) => _$this._reason = reason;

  String? _adminId;
  String? get adminId => _$this._adminId;
  set adminId(String? adminId) => _$this._adminId = adminId;

  ForceResolveRequestBuilder() {
    ForceResolveRequest._defaults(this);
  }

  ForceResolveRequestBuilder get _$this {
    final $v = _$v;
    if ($v != null) {
      _action = $v.action;
      _reason = $v.reason;
      _adminId = $v.adminId;
      _$v = null;
    }
    return this;
  }

  @override
  void replace(ForceResolveRequest other) {
    _$v = other as _$ForceResolveRequest;
  }

  @override
  void update(void Function(ForceResolveRequestBuilder)? updates) {
    if (updates != null) updates(this);
  }

  @override
  ForceResolveRequest build() => _build();

  _$ForceResolveRequest _build() {
    final _$result = _$v ??
        _$ForceResolveRequest._(
          action: BuiltValueNullFieldError.checkNotNull(
              action, r'ForceResolveRequest', 'action'),
          reason: reason,
          adminId: BuiltValueNullFieldError.checkNotNull(
              adminId, r'ForceResolveRequest', 'adminId'),
        );
    replace(_$result);
    return _$result;
  }
}

// ignore_for_file: deprecated_member_use_from_same_package,type=lint
