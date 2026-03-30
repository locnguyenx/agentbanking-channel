// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'error_response.dart';

// **************************************************************************
// BuiltValueGenerator
// **************************************************************************

const ErrorResponseStatusEnum _$errorResponseStatusEnum_FAILED =
    const ErrorResponseStatusEnum._('FAILED');

ErrorResponseStatusEnum _$errorResponseStatusEnumValueOf(String name) {
  switch (name) {
    case 'FAILED':
      return _$errorResponseStatusEnum_FAILED;
    default:
      throw ArgumentError(name);
  }
}

final BuiltSet<ErrorResponseStatusEnum> _$errorResponseStatusEnumValues =
    BuiltSet<ErrorResponseStatusEnum>(const <ErrorResponseStatusEnum>[
  _$errorResponseStatusEnum_FAILED,
]);

Serializer<ErrorResponseStatusEnum> _$errorResponseStatusEnumSerializer =
    _$ErrorResponseStatusEnumSerializer();

class _$ErrorResponseStatusEnumSerializer
    implements PrimitiveSerializer<ErrorResponseStatusEnum> {
  static const Map<String, Object> _toWire = const <String, Object>{
    'FAILED': 'FAILED',
  };
  static const Map<Object, String> _fromWire = const <Object, String>{
    'FAILED': 'FAILED',
  };

  @override
  final Iterable<Type> types = const <Type>[ErrorResponseStatusEnum];
  @override
  final String wireName = 'ErrorResponseStatusEnum';

  @override
  Object serialize(Serializers serializers, ErrorResponseStatusEnum object,
          {FullType specifiedType = FullType.unspecified}) =>
      _toWire[object.name] ?? object.name;

  @override
  ErrorResponseStatusEnum deserialize(
          Serializers serializers, Object serialized,
          {FullType specifiedType = FullType.unspecified}) =>
      ErrorResponseStatusEnum.valueOf(
          _fromWire[serialized] ?? (serialized is String ? serialized : ''));
}

class _$ErrorResponse extends ErrorResponse {
  @override
  final ErrorResponseStatusEnum status;
  @override
  final ErrorResponseError error;

  factory _$ErrorResponse([void Function(ErrorResponseBuilder)? updates]) =>
      (ErrorResponseBuilder()..update(updates))._build();

  _$ErrorResponse._({required this.status, required this.error}) : super._();
  @override
  ErrorResponse rebuild(void Function(ErrorResponseBuilder) updates) =>
      (toBuilder()..update(updates)).build();

  @override
  ErrorResponseBuilder toBuilder() => ErrorResponseBuilder()..replace(this);

  @override
  bool operator ==(Object other) {
    if (identical(other, this)) return true;
    return other is ErrorResponse &&
        status == other.status &&
        error == other.error;
  }

  @override
  int get hashCode {
    var _$hash = 0;
    _$hash = $jc(_$hash, status.hashCode);
    _$hash = $jc(_$hash, error.hashCode);
    _$hash = $jf(_$hash);
    return _$hash;
  }

  @override
  String toString() {
    return (newBuiltValueToStringHelper(r'ErrorResponse')
          ..add('status', status)
          ..add('error', error))
        .toString();
  }
}

class ErrorResponseBuilder
    implements Builder<ErrorResponse, ErrorResponseBuilder> {
  _$ErrorResponse? _$v;

  ErrorResponseStatusEnum? _status;
  ErrorResponseStatusEnum? get status => _$this._status;
  set status(ErrorResponseStatusEnum? status) => _$this._status = status;

  ErrorResponseErrorBuilder? _error;
  ErrorResponseErrorBuilder get error =>
      _$this._error ??= ErrorResponseErrorBuilder();
  set error(ErrorResponseErrorBuilder? error) => _$this._error = error;

  ErrorResponseBuilder() {
    ErrorResponse._defaults(this);
  }

  ErrorResponseBuilder get _$this {
    final $v = _$v;
    if ($v != null) {
      _status = $v.status;
      _error = $v.error.toBuilder();
      _$v = null;
    }
    return this;
  }

  @override
  void replace(ErrorResponse other) {
    _$v = other as _$ErrorResponse;
  }

  @override
  void update(void Function(ErrorResponseBuilder)? updates) {
    if (updates != null) updates(this);
  }

  @override
  ErrorResponse build() => _build();

  _$ErrorResponse _build() {
    _$ErrorResponse _$result;
    try {
      _$result = _$v ??
          _$ErrorResponse._(
            status: BuiltValueNullFieldError.checkNotNull(
                status, r'ErrorResponse', 'status'),
            error: error.build(),
          );
    } catch (_) {
      late String _$failedField;
      try {
        _$failedField = 'error';
        error.build();
      } catch (e) {
        throw BuiltValueNestedFieldError(
            r'ErrorResponse', _$failedField, e.toString());
      }
      rethrow;
    }
    replace(_$result);
    return _$result;
  }
}

// ignore_for_file: deprecated_member_use_from_same_package,type=lint
