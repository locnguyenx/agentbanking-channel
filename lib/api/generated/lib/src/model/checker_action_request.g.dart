// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'checker_action_request.dart';

// **************************************************************************
// BuiltValueGenerator
// **************************************************************************

class _$CheckerActionRequest extends CheckerActionRequest {
  @override
  final String reason;

  factory _$CheckerActionRequest(
          [void Function(CheckerActionRequestBuilder)? updates]) =>
      (CheckerActionRequestBuilder()..update(updates))._build();

  _$CheckerActionRequest._({required this.reason}) : super._();
  @override
  CheckerActionRequest rebuild(
          void Function(CheckerActionRequestBuilder) updates) =>
      (toBuilder()..update(updates)).build();

  @override
  CheckerActionRequestBuilder toBuilder() =>
      CheckerActionRequestBuilder()..replace(this);

  @override
  bool operator ==(Object other) {
    if (identical(other, this)) return true;
    return other is CheckerActionRequest && reason == other.reason;
  }

  @override
  int get hashCode {
    var _$hash = 0;
    _$hash = $jc(_$hash, reason.hashCode);
    _$hash = $jf(_$hash);
    return _$hash;
  }

  @override
  String toString() {
    return (newBuiltValueToStringHelper(r'CheckerActionRequest')
          ..add('reason', reason))
        .toString();
  }
}

class CheckerActionRequestBuilder
    implements Builder<CheckerActionRequest, CheckerActionRequestBuilder> {
  _$CheckerActionRequest? _$v;

  String? _reason;
  String? get reason => _$this._reason;
  set reason(String? reason) => _$this._reason = reason;

  CheckerActionRequestBuilder() {
    CheckerActionRequest._defaults(this);
  }

  CheckerActionRequestBuilder get _$this {
    final $v = _$v;
    if ($v != null) {
      _reason = $v.reason;
      _$v = null;
    }
    return this;
  }

  @override
  void replace(CheckerActionRequest other) {
    _$v = other as _$CheckerActionRequest;
  }

  @override
  void update(void Function(CheckerActionRequestBuilder)? updates) {
    if (updates != null) updates(this);
  }

  @override
  CheckerActionRequest build() => _build();

  _$CheckerActionRequest _build() {
    final _$result = _$v ??
        _$CheckerActionRequest._(
          reason: BuiltValueNullFieldError.checkNotNull(
              reason, r'CheckerActionRequest', 'reason'),
        );
    replace(_$result);
    return _$result;
  }
}

// ignore_for_file: deprecated_member_use_from_same_package,type=lint
