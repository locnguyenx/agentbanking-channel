// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'error_response_error.dart';

// **************************************************************************
// BuiltValueGenerator
// **************************************************************************

const ErrorResponseErrorActionCodeEnum
    _$errorResponseErrorActionCodeEnum_DECLINE =
    const ErrorResponseErrorActionCodeEnum._('DECLINE');
const ErrorResponseErrorActionCodeEnum
    _$errorResponseErrorActionCodeEnum_RETRY =
    const ErrorResponseErrorActionCodeEnum._('RETRY');
const ErrorResponseErrorActionCodeEnum
    _$errorResponseErrorActionCodeEnum_REVIEW =
    const ErrorResponseErrorActionCodeEnum._('REVIEW');

ErrorResponseErrorActionCodeEnum _$errorResponseErrorActionCodeEnumValueOf(
    String name) {
  switch (name) {
    case 'DECLINE':
      return _$errorResponseErrorActionCodeEnum_DECLINE;
    case 'RETRY':
      return _$errorResponseErrorActionCodeEnum_RETRY;
    case 'REVIEW':
      return _$errorResponseErrorActionCodeEnum_REVIEW;
    default:
      throw ArgumentError(name);
  }
}

final BuiltSet<ErrorResponseErrorActionCodeEnum>
    _$errorResponseErrorActionCodeEnumValues = BuiltSet<
        ErrorResponseErrorActionCodeEnum>(const <ErrorResponseErrorActionCodeEnum>[
  _$errorResponseErrorActionCodeEnum_DECLINE,
  _$errorResponseErrorActionCodeEnum_RETRY,
  _$errorResponseErrorActionCodeEnum_REVIEW,
]);

Serializer<ErrorResponseErrorActionCodeEnum>
    _$errorResponseErrorActionCodeEnumSerializer =
    _$ErrorResponseErrorActionCodeEnumSerializer();

class _$ErrorResponseErrorActionCodeEnumSerializer
    implements PrimitiveSerializer<ErrorResponseErrorActionCodeEnum> {
  static const Map<String, Object> _toWire = const <String, Object>{
    'DECLINE': 'DECLINE',
    'RETRY': 'RETRY',
    'REVIEW': 'REVIEW',
  };
  static const Map<Object, String> _fromWire = const <Object, String>{
    'DECLINE': 'DECLINE',
    'RETRY': 'RETRY',
    'REVIEW': 'REVIEW',
  };

  @override
  final Iterable<Type> types = const <Type>[ErrorResponseErrorActionCodeEnum];
  @override
  final String wireName = 'ErrorResponseErrorActionCodeEnum';

  @override
  Object serialize(
          Serializers serializers, ErrorResponseErrorActionCodeEnum object,
          {FullType specifiedType = FullType.unspecified}) =>
      _toWire[object.name] ?? object.name;

  @override
  ErrorResponseErrorActionCodeEnum deserialize(
          Serializers serializers, Object serialized,
          {FullType specifiedType = FullType.unspecified}) =>
      ErrorResponseErrorActionCodeEnum.valueOf(
          _fromWire[serialized] ?? (serialized is String ? serialized : ''));
}

class _$ErrorResponseError extends ErrorResponseError {
  @override
  final String? code;
  @override
  final String? message;
  @override
  final ErrorResponseErrorActionCodeEnum? actionCode;
  @override
  final String? traceId;
  @override
  final DateTime? timestamp;

  factory _$ErrorResponseError(
          [void Function(ErrorResponseErrorBuilder)? updates]) =>
      (ErrorResponseErrorBuilder()..update(updates))._build();

  _$ErrorResponseError._(
      {this.code, this.message, this.actionCode, this.traceId, this.timestamp})
      : super._();
  @override
  ErrorResponseError rebuild(
          void Function(ErrorResponseErrorBuilder) updates) =>
      (toBuilder()..update(updates)).build();

  @override
  ErrorResponseErrorBuilder toBuilder() =>
      ErrorResponseErrorBuilder()..replace(this);

  @override
  bool operator ==(Object other) {
    if (identical(other, this)) return true;
    return other is ErrorResponseError &&
        code == other.code &&
        message == other.message &&
        actionCode == other.actionCode &&
        traceId == other.traceId &&
        timestamp == other.timestamp;
  }

  @override
  int get hashCode {
    var _$hash = 0;
    _$hash = $jc(_$hash, code.hashCode);
    _$hash = $jc(_$hash, message.hashCode);
    _$hash = $jc(_$hash, actionCode.hashCode);
    _$hash = $jc(_$hash, traceId.hashCode);
    _$hash = $jc(_$hash, timestamp.hashCode);
    _$hash = $jf(_$hash);
    return _$hash;
  }

  @override
  String toString() {
    return (newBuiltValueToStringHelper(r'ErrorResponseError')
          ..add('code', code)
          ..add('message', message)
          ..add('actionCode', actionCode)
          ..add('traceId', traceId)
          ..add('timestamp', timestamp))
        .toString();
  }
}

class ErrorResponseErrorBuilder
    implements Builder<ErrorResponseError, ErrorResponseErrorBuilder> {
  _$ErrorResponseError? _$v;

  String? _code;
  String? get code => _$this._code;
  set code(String? code) => _$this._code = code;

  String? _message;
  String? get message => _$this._message;
  set message(String? message) => _$this._message = message;

  ErrorResponseErrorActionCodeEnum? _actionCode;
  ErrorResponseErrorActionCodeEnum? get actionCode => _$this._actionCode;
  set actionCode(ErrorResponseErrorActionCodeEnum? actionCode) =>
      _$this._actionCode = actionCode;

  String? _traceId;
  String? get traceId => _$this._traceId;
  set traceId(String? traceId) => _$this._traceId = traceId;

  DateTime? _timestamp;
  DateTime? get timestamp => _$this._timestamp;
  set timestamp(DateTime? timestamp) => _$this._timestamp = timestamp;

  ErrorResponseErrorBuilder() {
    ErrorResponseError._defaults(this);
  }

  ErrorResponseErrorBuilder get _$this {
    final $v = _$v;
    if ($v != null) {
      _code = $v.code;
      _message = $v.message;
      _actionCode = $v.actionCode;
      _traceId = $v.traceId;
      _timestamp = $v.timestamp;
      _$v = null;
    }
    return this;
  }

  @override
  void replace(ErrorResponseError other) {
    _$v = other as _$ErrorResponseError;
  }

  @override
  void update(void Function(ErrorResponseErrorBuilder)? updates) {
    if (updates != null) updates(this);
  }

  @override
  ErrorResponseError build() => _build();

  _$ErrorResponseError _build() {
    final _$result = _$v ??
        _$ErrorResponseError._(
          code: code,
          message: message,
          actionCode: actionCode,
          traceId: traceId,
          timestamp: timestamp,
        );
    replace(_$result);
    return _$result;
  }
}

// ignore_for_file: deprecated_member_use_from_same_package,type=lint
