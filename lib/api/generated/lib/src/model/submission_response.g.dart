// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'submission_response.dart';

// **************************************************************************
// BuiltValueGenerator
// **************************************************************************

class _$SubmissionResponse extends SubmissionResponse {
  @override
  final String? applicationId;
  @override
  final String? status;
  @override
  final String? message;

  factory _$SubmissionResponse(
          [void Function(SubmissionResponseBuilder)? updates]) =>
      (SubmissionResponseBuilder()..update(updates))._build();

  _$SubmissionResponse._({this.applicationId, this.status, this.message})
      : super._();
  @override
  SubmissionResponse rebuild(
          void Function(SubmissionResponseBuilder) updates) =>
      (toBuilder()..update(updates)).build();

  @override
  SubmissionResponseBuilder toBuilder() =>
      SubmissionResponseBuilder()..replace(this);

  @override
  bool operator ==(Object other) {
    if (identical(other, this)) return true;
    return other is SubmissionResponse &&
        applicationId == other.applicationId &&
        status == other.status &&
        message == other.message;
  }

  @override
  int get hashCode {
    var _$hash = 0;
    _$hash = $jc(_$hash, applicationId.hashCode);
    _$hash = $jc(_$hash, status.hashCode);
    _$hash = $jc(_$hash, message.hashCode);
    _$hash = $jf(_$hash);
    return _$hash;
  }

  @override
  String toString() {
    return (newBuiltValueToStringHelper(r'SubmissionResponse')
          ..add('applicationId', applicationId)
          ..add('status', status)
          ..add('message', message))
        .toString();
  }
}

class SubmissionResponseBuilder
    implements Builder<SubmissionResponse, SubmissionResponseBuilder> {
  _$SubmissionResponse? _$v;

  String? _applicationId;
  String? get applicationId => _$this._applicationId;
  set applicationId(String? applicationId) =>
      _$this._applicationId = applicationId;

  String? _status;
  String? get status => _$this._status;
  set status(String? status) => _$this._status = status;

  String? _message;
  String? get message => _$this._message;
  set message(String? message) => _$this._message = message;

  SubmissionResponseBuilder() {
    SubmissionResponse._defaults(this);
  }

  SubmissionResponseBuilder get _$this {
    final $v = _$v;
    if ($v != null) {
      _applicationId = $v.applicationId;
      _status = $v.status;
      _message = $v.message;
      _$v = null;
    }
    return this;
  }

  @override
  void replace(SubmissionResponse other) {
    _$v = other as _$SubmissionResponse;
  }

  @override
  void update(void Function(SubmissionResponseBuilder)? updates) {
    if (updates != null) updates(this);
  }

  @override
  SubmissionResponse build() => _build();

  _$SubmissionResponse _build() {
    final _$result = _$v ??
        _$SubmissionResponse._(
          applicationId: applicationId,
          status: status,
          message: message,
        );
    replace(_$result);
    return _$result;
  }
}

// ignore_for_file: deprecated_member_use_from_same_package,type=lint
