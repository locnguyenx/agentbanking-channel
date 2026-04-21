// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'audit_log_record.dart';

// **************************************************************************
// BuiltValueGenerator
// **************************************************************************

class _$AuditLogRecord extends AuditLogRecord {
  @override
  final String? logId;
  @override
  final String? entityType;
  @override
  final String? entityId;
  @override
  final String? action;
  @override
  final String? performedBy;
  @override
  final String? changes;
  @override
  final String? ipAddress;
  @override
  final DateTime? timestamp;

  factory _$AuditLogRecord([void Function(AuditLogRecordBuilder)? updates]) =>
      (AuditLogRecordBuilder()..update(updates))._build();

  _$AuditLogRecord._(
      {this.logId,
      this.entityType,
      this.entityId,
      this.action,
      this.performedBy,
      this.changes,
      this.ipAddress,
      this.timestamp})
      : super._();
  @override
  AuditLogRecord rebuild(void Function(AuditLogRecordBuilder) updates) =>
      (toBuilder()..update(updates)).build();

  @override
  AuditLogRecordBuilder toBuilder() => AuditLogRecordBuilder()..replace(this);

  @override
  bool operator ==(Object other) {
    if (identical(other, this)) return true;
    return other is AuditLogRecord &&
        logId == other.logId &&
        entityType == other.entityType &&
        entityId == other.entityId &&
        action == other.action &&
        performedBy == other.performedBy &&
        changes == other.changes &&
        ipAddress == other.ipAddress &&
        timestamp == other.timestamp;
  }

  @override
  int get hashCode {
    var _$hash = 0;
    _$hash = $jc(_$hash, logId.hashCode);
    _$hash = $jc(_$hash, entityType.hashCode);
    _$hash = $jc(_$hash, entityId.hashCode);
    _$hash = $jc(_$hash, action.hashCode);
    _$hash = $jc(_$hash, performedBy.hashCode);
    _$hash = $jc(_$hash, changes.hashCode);
    _$hash = $jc(_$hash, ipAddress.hashCode);
    _$hash = $jc(_$hash, timestamp.hashCode);
    _$hash = $jf(_$hash);
    return _$hash;
  }

  @override
  String toString() {
    return (newBuiltValueToStringHelper(r'AuditLogRecord')
          ..add('logId', logId)
          ..add('entityType', entityType)
          ..add('entityId', entityId)
          ..add('action', action)
          ..add('performedBy', performedBy)
          ..add('changes', changes)
          ..add('ipAddress', ipAddress)
          ..add('timestamp', timestamp))
        .toString();
  }
}

class AuditLogRecordBuilder
    implements Builder<AuditLogRecord, AuditLogRecordBuilder> {
  _$AuditLogRecord? _$v;

  String? _logId;
  String? get logId => _$this._logId;
  set logId(String? logId) => _$this._logId = logId;

  String? _entityType;
  String? get entityType => _$this._entityType;
  set entityType(String? entityType) => _$this._entityType = entityType;

  String? _entityId;
  String? get entityId => _$this._entityId;
  set entityId(String? entityId) => _$this._entityId = entityId;

  String? _action;
  String? get action => _$this._action;
  set action(String? action) => _$this._action = action;

  String? _performedBy;
  String? get performedBy => _$this._performedBy;
  set performedBy(String? performedBy) => _$this._performedBy = performedBy;

  String? _changes;
  String? get changes => _$this._changes;
  set changes(String? changes) => _$this._changes = changes;

  String? _ipAddress;
  String? get ipAddress => _$this._ipAddress;
  set ipAddress(String? ipAddress) => _$this._ipAddress = ipAddress;

  DateTime? _timestamp;
  DateTime? get timestamp => _$this._timestamp;
  set timestamp(DateTime? timestamp) => _$this._timestamp = timestamp;

  AuditLogRecordBuilder() {
    AuditLogRecord._defaults(this);
  }

  AuditLogRecordBuilder get _$this {
    final $v = _$v;
    if ($v != null) {
      _logId = $v.logId;
      _entityType = $v.entityType;
      _entityId = $v.entityId;
      _action = $v.action;
      _performedBy = $v.performedBy;
      _changes = $v.changes;
      _ipAddress = $v.ipAddress;
      _timestamp = $v.timestamp;
      _$v = null;
    }
    return this;
  }

  @override
  void replace(AuditLogRecord other) {
    _$v = other as _$AuditLogRecord;
  }

  @override
  void update(void Function(AuditLogRecordBuilder)? updates) {
    if (updates != null) updates(this);
  }

  @override
  AuditLogRecord build() => _build();

  _$AuditLogRecord _build() {
    final _$result = _$v ??
        _$AuditLogRecord._(
          logId: logId,
          entityType: entityType,
          entityId: entityId,
          action: action,
          performedBy: performedBy,
          changes: changes,
          ipAddress: ipAddress,
          timestamp: timestamp,
        );
    replace(_$result);
    return _$result;
  }
}

// ignore_for_file: deprecated_member_use_from_same_package,type=lint
