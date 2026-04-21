// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'maker_propose_action_legacy_request.dart';

// **************************************************************************
// BuiltValueGenerator
// **************************************************************************

class _$MakerProposeActionLegacyRequest
    extends MakerProposeActionLegacyRequest {
  @override
  final String caseId;
  @override
  final String action;
  @override
  final String userId;
  @override
  final String? reason;

  factory _$MakerProposeActionLegacyRequest(
          [void Function(MakerProposeActionLegacyRequestBuilder)? updates]) =>
      (MakerProposeActionLegacyRequestBuilder()..update(updates))._build();

  _$MakerProposeActionLegacyRequest._(
      {required this.caseId,
      required this.action,
      required this.userId,
      this.reason})
      : super._();
  @override
  MakerProposeActionLegacyRequest rebuild(
          void Function(MakerProposeActionLegacyRequestBuilder) updates) =>
      (toBuilder()..update(updates)).build();

  @override
  MakerProposeActionLegacyRequestBuilder toBuilder() =>
      MakerProposeActionLegacyRequestBuilder()..replace(this);

  @override
  bool operator ==(Object other) {
    if (identical(other, this)) return true;
    return other is MakerProposeActionLegacyRequest &&
        caseId == other.caseId &&
        action == other.action &&
        userId == other.userId &&
        reason == other.reason;
  }

  @override
  int get hashCode {
    var _$hash = 0;
    _$hash = $jc(_$hash, caseId.hashCode);
    _$hash = $jc(_$hash, action.hashCode);
    _$hash = $jc(_$hash, userId.hashCode);
    _$hash = $jc(_$hash, reason.hashCode);
    _$hash = $jf(_$hash);
    return _$hash;
  }

  @override
  String toString() {
    return (newBuiltValueToStringHelper(r'MakerProposeActionLegacyRequest')
          ..add('caseId', caseId)
          ..add('action', action)
          ..add('userId', userId)
          ..add('reason', reason))
        .toString();
  }
}

class MakerProposeActionLegacyRequestBuilder
    implements
        Builder<MakerProposeActionLegacyRequest,
            MakerProposeActionLegacyRequestBuilder> {
  _$MakerProposeActionLegacyRequest? _$v;

  String? _caseId;
  String? get caseId => _$this._caseId;
  set caseId(String? caseId) => _$this._caseId = caseId;

  String? _action;
  String? get action => _$this._action;
  set action(String? action) => _$this._action = action;

  String? _userId;
  String? get userId => _$this._userId;
  set userId(String? userId) => _$this._userId = userId;

  String? _reason;
  String? get reason => _$this._reason;
  set reason(String? reason) => _$this._reason = reason;

  MakerProposeActionLegacyRequestBuilder() {
    MakerProposeActionLegacyRequest._defaults(this);
  }

  MakerProposeActionLegacyRequestBuilder get _$this {
    final $v = _$v;
    if ($v != null) {
      _caseId = $v.caseId;
      _action = $v.action;
      _userId = $v.userId;
      _reason = $v.reason;
      _$v = null;
    }
    return this;
  }

  @override
  void replace(MakerProposeActionLegacyRequest other) {
    _$v = other as _$MakerProposeActionLegacyRequest;
  }

  @override
  void update(void Function(MakerProposeActionLegacyRequestBuilder)? updates) {
    if (updates != null) updates(this);
  }

  @override
  MakerProposeActionLegacyRequest build() => _build();

  _$MakerProposeActionLegacyRequest _build() {
    final _$result = _$v ??
        _$MakerProposeActionLegacyRequest._(
          caseId: BuiltValueNullFieldError.checkNotNull(
              caseId, r'MakerProposeActionLegacyRequest', 'caseId'),
          action: BuiltValueNullFieldError.checkNotNull(
              action, r'MakerProposeActionLegacyRequest', 'action'),
          userId: BuiltValueNullFieldError.checkNotNull(
              userId, r'MakerProposeActionLegacyRequest', 'userId'),
          reason: reason,
        );
    replace(_$result);
    return _$result;
  }
}

// ignore_for_file: deprecated_member_use_from_same_package,type=lint
