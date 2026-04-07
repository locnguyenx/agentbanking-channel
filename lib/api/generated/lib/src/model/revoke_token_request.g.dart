// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'revoke_token_request.dart';

// **************************************************************************
// BuiltValueGenerator
// **************************************************************************

class _$RevokeTokenRequest extends RevokeTokenRequest {
  @override
  final String? token;

  factory _$RevokeTokenRequest(
          [void Function(RevokeTokenRequestBuilder)? updates]) =>
      (RevokeTokenRequestBuilder()..update(updates))._build();

  _$RevokeTokenRequest._({this.token}) : super._();
  @override
  RevokeTokenRequest rebuild(
          void Function(RevokeTokenRequestBuilder) updates) =>
      (toBuilder()..update(updates)).build();

  @override
  RevokeTokenRequestBuilder toBuilder() =>
      RevokeTokenRequestBuilder()..replace(this);

  @override
  bool operator ==(Object other) {
    if (identical(other, this)) return true;
    return other is RevokeTokenRequest && token == other.token;
  }

  @override
  int get hashCode {
    var _$hash = 0;
    _$hash = $jc(_$hash, token.hashCode);
    _$hash = $jf(_$hash);
    return _$hash;
  }

  @override
  String toString() {
    return (newBuiltValueToStringHelper(r'RevokeTokenRequest')
          ..add('token', token))
        .toString();
  }
}

class RevokeTokenRequestBuilder
    implements Builder<RevokeTokenRequest, RevokeTokenRequestBuilder> {
  _$RevokeTokenRequest? _$v;

  String? _token;
  String? get token => _$this._token;
  set token(String? token) => _$this._token = token;

  RevokeTokenRequestBuilder() {
    RevokeTokenRequest._defaults(this);
  }

  RevokeTokenRequestBuilder get _$this {
    final $v = _$v;
    if ($v != null) {
      _token = $v.token;
      _$v = null;
    }
    return this;
  }

  @override
  void replace(RevokeTokenRequest other) {
    _$v = other as _$RevokeTokenRequest;
  }

  @override
  void update(void Function(RevokeTokenRequestBuilder)? updates) {
    if (updates != null) updates(this);
  }

  @override
  RevokeTokenRequest build() => _build();

  _$RevokeTokenRequest _build() {
    final _$result = _$v ??
        _$RevokeTokenRequest._(
          token: token,
        );
    replace(_$result);
    return _$result;
  }
}

// ignore_for_file: deprecated_member_use_from_same_package,type=lint
