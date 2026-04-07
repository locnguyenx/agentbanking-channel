// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'resolution_response.dart';

// **************************************************************************
// BuiltValueGenerator
// **************************************************************************

const ResolutionResponseProposedActionEnum
    _$resolutionResponseProposedActionEnum_COMMIT =
    const ResolutionResponseProposedActionEnum._('COMMIT');
const ResolutionResponseProposedActionEnum
    _$resolutionResponseProposedActionEnum_ROLLBACK =
    const ResolutionResponseProposedActionEnum._('ROLLBACK');
const ResolutionResponseProposedActionEnum
    _$resolutionResponseProposedActionEnum_ESCALATE =
    const ResolutionResponseProposedActionEnum._('ESCALATE');

ResolutionResponseProposedActionEnum
    _$resolutionResponseProposedActionEnumValueOf(String name) {
  switch (name) {
    case 'COMMIT':
      return _$resolutionResponseProposedActionEnum_COMMIT;
    case 'ROLLBACK':
      return _$resolutionResponseProposedActionEnum_ROLLBACK;
    case 'ESCALATE':
      return _$resolutionResponseProposedActionEnum_ESCALATE;
    default:
      throw ArgumentError(name);
  }
}

final BuiltSet<ResolutionResponseProposedActionEnum>
    _$resolutionResponseProposedActionEnumValues = BuiltSet<
        ResolutionResponseProposedActionEnum>(const <ResolutionResponseProposedActionEnum>[
  _$resolutionResponseProposedActionEnum_COMMIT,
  _$resolutionResponseProposedActionEnum_ROLLBACK,
  _$resolutionResponseProposedActionEnum_ESCALATE,
]);

const ResolutionResponseStatusEnum
    _$resolutionResponseStatusEnum_PENDING_MAKER =
    const ResolutionResponseStatusEnum._('PENDING_MAKER');
const ResolutionResponseStatusEnum
    _$resolutionResponseStatusEnum_PENDING_CHECKER =
    const ResolutionResponseStatusEnum._('PENDING_CHECKER');
const ResolutionResponseStatusEnum _$resolutionResponseStatusEnum_APPROVED =
    const ResolutionResponseStatusEnum._('APPROVED');
const ResolutionResponseStatusEnum _$resolutionResponseStatusEnum_REJECTED =
    const ResolutionResponseStatusEnum._('REJECTED');

ResolutionResponseStatusEnum _$resolutionResponseStatusEnumValueOf(
    String name) {
  switch (name) {
    case 'PENDING_MAKER':
      return _$resolutionResponseStatusEnum_PENDING_MAKER;
    case 'PENDING_CHECKER':
      return _$resolutionResponseStatusEnum_PENDING_CHECKER;
    case 'APPROVED':
      return _$resolutionResponseStatusEnum_APPROVED;
    case 'REJECTED':
      return _$resolutionResponseStatusEnum_REJECTED;
    default:
      throw ArgumentError(name);
  }
}

final BuiltSet<ResolutionResponseStatusEnum>
    _$resolutionResponseStatusEnumValues =
    BuiltSet<ResolutionResponseStatusEnum>(const <ResolutionResponseStatusEnum>[
  _$resolutionResponseStatusEnum_PENDING_MAKER,
  _$resolutionResponseStatusEnum_PENDING_CHECKER,
  _$resolutionResponseStatusEnum_APPROVED,
  _$resolutionResponseStatusEnum_REJECTED,
]);

Serializer<ResolutionResponseProposedActionEnum>
    _$resolutionResponseProposedActionEnumSerializer =
    _$ResolutionResponseProposedActionEnumSerializer();
Serializer<ResolutionResponseStatusEnum>
    _$resolutionResponseStatusEnumSerializer =
    _$ResolutionResponseStatusEnumSerializer();

class _$ResolutionResponseProposedActionEnumSerializer
    implements PrimitiveSerializer<ResolutionResponseProposedActionEnum> {
  static const Map<String, Object> _toWire = const <String, Object>{
    'COMMIT': 'COMMIT',
    'ROLLBACK': 'ROLLBACK',
    'ESCALATE': 'ESCALATE',
  };
  static const Map<Object, String> _fromWire = const <Object, String>{
    'COMMIT': 'COMMIT',
    'ROLLBACK': 'ROLLBACK',
    'ESCALATE': 'ESCALATE',
  };

  @override
  final Iterable<Type> types = const <Type>[
    ResolutionResponseProposedActionEnum
  ];
  @override
  final String wireName = 'ResolutionResponseProposedActionEnum';

  @override
  Object serialize(
          Serializers serializers, ResolutionResponseProposedActionEnum object,
          {FullType specifiedType = FullType.unspecified}) =>
      _toWire[object.name] ?? object.name;

  @override
  ResolutionResponseProposedActionEnum deserialize(
          Serializers serializers, Object serialized,
          {FullType specifiedType = FullType.unspecified}) =>
      ResolutionResponseProposedActionEnum.valueOf(
          _fromWire[serialized] ?? (serialized is String ? serialized : ''));
}

class _$ResolutionResponseStatusEnumSerializer
    implements PrimitiveSerializer<ResolutionResponseStatusEnum> {
  static const Map<String, Object> _toWire = const <String, Object>{
    'PENDING_MAKER': 'PENDING_MAKER',
    'PENDING_CHECKER': 'PENDING_CHECKER',
    'APPROVED': 'APPROVED',
    'REJECTED': 'REJECTED',
  };
  static const Map<Object, String> _fromWire = const <Object, String>{
    'PENDING_MAKER': 'PENDING_MAKER',
    'PENDING_CHECKER': 'PENDING_CHECKER',
    'APPROVED': 'APPROVED',
    'REJECTED': 'REJECTED',
  };

  @override
  final Iterable<Type> types = const <Type>[ResolutionResponseStatusEnum];
  @override
  final String wireName = 'ResolutionResponseStatusEnum';

  @override
  Object serialize(Serializers serializers, ResolutionResponseStatusEnum object,
          {FullType specifiedType = FullType.unspecified}) =>
      _toWire[object.name] ?? object.name;

  @override
  ResolutionResponseStatusEnum deserialize(
          Serializers serializers, Object serialized,
          {FullType specifiedType = FullType.unspecified}) =>
      ResolutionResponseStatusEnum.valueOf(
          _fromWire[serialized] ?? (serialized is String ? serialized : ''));
}

class _$ResolutionResponse extends ResolutionResponse {
  @override
  final String? id;
  @override
  final String? workflowId;
  @override
  final String? transactionId;
  @override
  final ResolutionResponseProposedActionEnum? proposedAction;
  @override
  final String? reasonCode;
  @override
  final String? reason;
  @override
  final String? evidenceUrl;
  @override
  final ResolutionResponseStatusEnum? status;
  @override
  final String? makerUserId;
  @override
  final DateTime? makerCreatedAt;
  @override
  final String? checkerUserId;
  @override
  final String? checkerAction;
  @override
  final String? checkerReason;
  @override
  final DateTime? checkerCompletedAt;
  @override
  final DateTime? createdAt;
  @override
  final DateTime? updatedAt;

  factory _$ResolutionResponse(
          [void Function(ResolutionResponseBuilder)? updates]) =>
      (ResolutionResponseBuilder()..update(updates))._build();

  _$ResolutionResponse._(
      {this.id,
      this.workflowId,
      this.transactionId,
      this.proposedAction,
      this.reasonCode,
      this.reason,
      this.evidenceUrl,
      this.status,
      this.makerUserId,
      this.makerCreatedAt,
      this.checkerUserId,
      this.checkerAction,
      this.checkerReason,
      this.checkerCompletedAt,
      this.createdAt,
      this.updatedAt})
      : super._();
  @override
  ResolutionResponse rebuild(
          void Function(ResolutionResponseBuilder) updates) =>
      (toBuilder()..update(updates)).build();

  @override
  ResolutionResponseBuilder toBuilder() =>
      ResolutionResponseBuilder()..replace(this);

  @override
  bool operator ==(Object other) {
    if (identical(other, this)) return true;
    return other is ResolutionResponse &&
        id == other.id &&
        workflowId == other.workflowId &&
        transactionId == other.transactionId &&
        proposedAction == other.proposedAction &&
        reasonCode == other.reasonCode &&
        reason == other.reason &&
        evidenceUrl == other.evidenceUrl &&
        status == other.status &&
        makerUserId == other.makerUserId &&
        makerCreatedAt == other.makerCreatedAt &&
        checkerUserId == other.checkerUserId &&
        checkerAction == other.checkerAction &&
        checkerReason == other.checkerReason &&
        checkerCompletedAt == other.checkerCompletedAt &&
        createdAt == other.createdAt &&
        updatedAt == other.updatedAt;
  }

  @override
  int get hashCode {
    var _$hash = 0;
    _$hash = $jc(_$hash, id.hashCode);
    _$hash = $jc(_$hash, workflowId.hashCode);
    _$hash = $jc(_$hash, transactionId.hashCode);
    _$hash = $jc(_$hash, proposedAction.hashCode);
    _$hash = $jc(_$hash, reasonCode.hashCode);
    _$hash = $jc(_$hash, reason.hashCode);
    _$hash = $jc(_$hash, evidenceUrl.hashCode);
    _$hash = $jc(_$hash, status.hashCode);
    _$hash = $jc(_$hash, makerUserId.hashCode);
    _$hash = $jc(_$hash, makerCreatedAt.hashCode);
    _$hash = $jc(_$hash, checkerUserId.hashCode);
    _$hash = $jc(_$hash, checkerAction.hashCode);
    _$hash = $jc(_$hash, checkerReason.hashCode);
    _$hash = $jc(_$hash, checkerCompletedAt.hashCode);
    _$hash = $jc(_$hash, createdAt.hashCode);
    _$hash = $jc(_$hash, updatedAt.hashCode);
    _$hash = $jf(_$hash);
    return _$hash;
  }

  @override
  String toString() {
    return (newBuiltValueToStringHelper(r'ResolutionResponse')
          ..add('id', id)
          ..add('workflowId', workflowId)
          ..add('transactionId', transactionId)
          ..add('proposedAction', proposedAction)
          ..add('reasonCode', reasonCode)
          ..add('reason', reason)
          ..add('evidenceUrl', evidenceUrl)
          ..add('status', status)
          ..add('makerUserId', makerUserId)
          ..add('makerCreatedAt', makerCreatedAt)
          ..add('checkerUserId', checkerUserId)
          ..add('checkerAction', checkerAction)
          ..add('checkerReason', checkerReason)
          ..add('checkerCompletedAt', checkerCompletedAt)
          ..add('createdAt', createdAt)
          ..add('updatedAt', updatedAt))
        .toString();
  }
}

class ResolutionResponseBuilder
    implements Builder<ResolutionResponse, ResolutionResponseBuilder> {
  _$ResolutionResponse? _$v;

  String? _id;
  String? get id => _$this._id;
  set id(String? id) => _$this._id = id;

  String? _workflowId;
  String? get workflowId => _$this._workflowId;
  set workflowId(String? workflowId) => _$this._workflowId = workflowId;

  String? _transactionId;
  String? get transactionId => _$this._transactionId;
  set transactionId(String? transactionId) =>
      _$this._transactionId = transactionId;

  ResolutionResponseProposedActionEnum? _proposedAction;
  ResolutionResponseProposedActionEnum? get proposedAction =>
      _$this._proposedAction;
  set proposedAction(ResolutionResponseProposedActionEnum? proposedAction) =>
      _$this._proposedAction = proposedAction;

  String? _reasonCode;
  String? get reasonCode => _$this._reasonCode;
  set reasonCode(String? reasonCode) => _$this._reasonCode = reasonCode;

  String? _reason;
  String? get reason => _$this._reason;
  set reason(String? reason) => _$this._reason = reason;

  String? _evidenceUrl;
  String? get evidenceUrl => _$this._evidenceUrl;
  set evidenceUrl(String? evidenceUrl) => _$this._evidenceUrl = evidenceUrl;

  ResolutionResponseStatusEnum? _status;
  ResolutionResponseStatusEnum? get status => _$this._status;
  set status(ResolutionResponseStatusEnum? status) => _$this._status = status;

  String? _makerUserId;
  String? get makerUserId => _$this._makerUserId;
  set makerUserId(String? makerUserId) => _$this._makerUserId = makerUserId;

  DateTime? _makerCreatedAt;
  DateTime? get makerCreatedAt => _$this._makerCreatedAt;
  set makerCreatedAt(DateTime? makerCreatedAt) =>
      _$this._makerCreatedAt = makerCreatedAt;

  String? _checkerUserId;
  String? get checkerUserId => _$this._checkerUserId;
  set checkerUserId(String? checkerUserId) =>
      _$this._checkerUserId = checkerUserId;

  String? _checkerAction;
  String? get checkerAction => _$this._checkerAction;
  set checkerAction(String? checkerAction) =>
      _$this._checkerAction = checkerAction;

  String? _checkerReason;
  String? get checkerReason => _$this._checkerReason;
  set checkerReason(String? checkerReason) =>
      _$this._checkerReason = checkerReason;

  DateTime? _checkerCompletedAt;
  DateTime? get checkerCompletedAt => _$this._checkerCompletedAt;
  set checkerCompletedAt(DateTime? checkerCompletedAt) =>
      _$this._checkerCompletedAt = checkerCompletedAt;

  DateTime? _createdAt;
  DateTime? get createdAt => _$this._createdAt;
  set createdAt(DateTime? createdAt) => _$this._createdAt = createdAt;

  DateTime? _updatedAt;
  DateTime? get updatedAt => _$this._updatedAt;
  set updatedAt(DateTime? updatedAt) => _$this._updatedAt = updatedAt;

  ResolutionResponseBuilder() {
    ResolutionResponse._defaults(this);
  }

  ResolutionResponseBuilder get _$this {
    final $v = _$v;
    if ($v != null) {
      _id = $v.id;
      _workflowId = $v.workflowId;
      _transactionId = $v.transactionId;
      _proposedAction = $v.proposedAction;
      _reasonCode = $v.reasonCode;
      _reason = $v.reason;
      _evidenceUrl = $v.evidenceUrl;
      _status = $v.status;
      _makerUserId = $v.makerUserId;
      _makerCreatedAt = $v.makerCreatedAt;
      _checkerUserId = $v.checkerUserId;
      _checkerAction = $v.checkerAction;
      _checkerReason = $v.checkerReason;
      _checkerCompletedAt = $v.checkerCompletedAt;
      _createdAt = $v.createdAt;
      _updatedAt = $v.updatedAt;
      _$v = null;
    }
    return this;
  }

  @override
  void replace(ResolutionResponse other) {
    _$v = other as _$ResolutionResponse;
  }

  @override
  void update(void Function(ResolutionResponseBuilder)? updates) {
    if (updates != null) updates(this);
  }

  @override
  ResolutionResponse build() => _build();

  _$ResolutionResponse _build() {
    final _$result = _$v ??
        _$ResolutionResponse._(
          id: id,
          workflowId: workflowId,
          transactionId: transactionId,
          proposedAction: proposedAction,
          reasonCode: reasonCode,
          reason: reason,
          evidenceUrl: evidenceUrl,
          status: status,
          makerUserId: makerUserId,
          makerCreatedAt: makerCreatedAt,
          checkerUserId: checkerUserId,
          checkerAction: checkerAction,
          checkerReason: checkerReason,
          checkerCompletedAt: checkerCompletedAt,
          createdAt: createdAt,
          updatedAt: updatedAt,
        );
    replace(_$result);
    return _$result;
  }
}

// ignore_for_file: deprecated_member_use_from_same_package,type=lint
