// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'force_resolve_transaction200_response.dart';

// **************************************************************************
// BuiltValueGenerator
// **************************************************************************

class _$ForceResolveTransaction200Response
    extends ForceResolveTransaction200Response {
  @override
  final String? status;
  @override
  final String? message;

  factory _$ForceResolveTransaction200Response(
          [void Function(ForceResolveTransaction200ResponseBuilder)?
              updates]) =>
      (ForceResolveTransaction200ResponseBuilder()..update(updates))._build();

  _$ForceResolveTransaction200Response._({this.status, this.message})
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
        status == other.status &&
        message == other.message;
  }

  @override
  int get hashCode {
    var _$hash = 0;
    _$hash = $jc(_$hash, status.hashCode);
    _$hash = $jc(_$hash, message.hashCode);
    _$hash = $jf(_$hash);
    return _$hash;
  }

  @override
  String toString() {
    return (newBuiltValueToStringHelper(r'ForceResolveTransaction200Response')
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
          status: status,
          message: message,
        );
    replace(_$result);
    return _$result;
  }
}

// ignore_for_file: deprecated_member_use_from_same_package,type=lint
