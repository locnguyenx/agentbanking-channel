// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'forgot_password_response.dart';

// **************************************************************************
// BuiltValueGenerator
// **************************************************************************

class _$ForgotPasswordResponse extends ForgotPasswordResponse {
  @override
  final String? message;

  factory _$ForgotPasswordResponse(
          [void Function(ForgotPasswordResponseBuilder)? updates]) =>
      (ForgotPasswordResponseBuilder()..update(updates))._build();

  _$ForgotPasswordResponse._({this.message}) : super._();
  @override
  ForgotPasswordResponse rebuild(
          void Function(ForgotPasswordResponseBuilder) updates) =>
      (toBuilder()..update(updates)).build();

  @override
  ForgotPasswordResponseBuilder toBuilder() =>
      ForgotPasswordResponseBuilder()..replace(this);

  @override
  bool operator ==(Object other) {
    if (identical(other, this)) return true;
    return other is ForgotPasswordResponse && message == other.message;
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
    return (newBuiltValueToStringHelper(r'ForgotPasswordResponse')
          ..add('message', message))
        .toString();
  }
}

class ForgotPasswordResponseBuilder
    implements Builder<ForgotPasswordResponse, ForgotPasswordResponseBuilder> {
  _$ForgotPasswordResponse? _$v;

  String? _message;
  String? get message => _$this._message;
  set message(String? message) => _$this._message = message;

  ForgotPasswordResponseBuilder() {
    ForgotPasswordResponse._defaults(this);
  }

  ForgotPasswordResponseBuilder get _$this {
    final $v = _$v;
    if ($v != null) {
      _message = $v.message;
      _$v = null;
    }
    return this;
  }

  @override
  void replace(ForgotPasswordResponse other) {
    _$v = other as _$ForgotPasswordResponse;
  }

  @override
  void update(void Function(ForgotPasswordResponseBuilder)? updates) {
    if (updates != null) updates(this);
  }

  @override
  ForgotPasswordResponse build() => _build();

  _$ForgotPasswordResponse _build() {
    final _$result = _$v ??
        _$ForgotPasswordResponse._(
          message: message,
        );
    replace(_$result);
    return _$result;
  }
}

// ignore_for_file: deprecated_member_use_from_same_package,type=lint
