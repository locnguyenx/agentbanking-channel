// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'reset_password_response.dart';

// **************************************************************************
// BuiltValueGenerator
// **************************************************************************

class _$ResetPasswordResponse extends ResetPasswordResponse {
  @override
  final String? message;

  factory _$ResetPasswordResponse(
          [void Function(ResetPasswordResponseBuilder)? updates]) =>
      (ResetPasswordResponseBuilder()..update(updates))._build();

  _$ResetPasswordResponse._({this.message}) : super._();
  @override
  ResetPasswordResponse rebuild(
          void Function(ResetPasswordResponseBuilder) updates) =>
      (toBuilder()..update(updates)).build();

  @override
  ResetPasswordResponseBuilder toBuilder() =>
      ResetPasswordResponseBuilder()..replace(this);

  @override
  bool operator ==(Object other) {
    if (identical(other, this)) return true;
    return other is ResetPasswordResponse && message == other.message;
  }

  @override
  int get hashCode {
    var _$hash = 0;
    _$hash = $jc(_$hash, message.hashCode);
    _$hash = $jf(_$hash);
    return _$hash;
  }

  @override
  String toString() {
    return (newBuiltValueToStringHelper(r'ResetPasswordResponse')
          ..add('message', message))
        .toString();
  }
}

class ResetPasswordResponseBuilder
    implements Builder<ResetPasswordResponse, ResetPasswordResponseBuilder> {
  _$ResetPasswordResponse? _$v;

  String? _message;
  String? get message => _$this._message;
  set message(String? message) => _$this._message = message;

  ResetPasswordResponseBuilder() {
    ResetPasswordResponse._defaults(this);
  }

  ResetPasswordResponseBuilder get _$this {
    final $v = _$v;
    if ($v != null) {
      _message = $v.message;
      _$v = null;
    }
    return this;
  }

  @override
  void replace(ResetPasswordResponse other) {
    _$v = other as _$ResetPasswordResponse;
  }

  @override
  void update(void Function(ResetPasswordResponseBuilder)? updates) {
    if (updates != null) updates(this);
  }

  @override
  ResetPasswordResponse build() => _build();

  _$ResetPasswordResponse _build() {
    final _$result = _$v ??
        _$ResetPasswordResponse._(
          message: message,
        );
    replace(_$result);
    return _$result;
  }
}

// ignore_for_file: deprecated_member_use_from_same_package,type=lint
