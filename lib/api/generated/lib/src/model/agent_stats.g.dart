// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'agent_stats.dart';

// **************************************************************************
// BuiltValueGenerator
// **************************************************************************

class _$AgentStats extends AgentStats {
  @override
  final int? total;
  @override
  final int? active;
  @override
  final int? suspended;
  @override
  final int? inactive;

  factory _$AgentStats([void Function(AgentStatsBuilder)? updates]) =>
      (AgentStatsBuilder()..update(updates))._build();

  _$AgentStats._({this.total, this.active, this.suspended, this.inactive})
      : super._();
  @override
  AgentStats rebuild(void Function(AgentStatsBuilder) updates) =>
      (toBuilder()..update(updates)).build();

  @override
  AgentStatsBuilder toBuilder() => AgentStatsBuilder()..replace(this);

  @override
  bool operator ==(Object other) {
    if (identical(other, this)) return true;
    return other is AgentStats &&
        total == other.total &&
        active == other.active &&
        suspended == other.suspended &&
        inactive == other.inactive;
  }

  @override
  int get hashCode {
    var _$hash = 0;
    _$hash = $jc(_$hash, total.hashCode);
    _$hash = $jc(_$hash, active.hashCode);
    _$hash = $jc(_$hash, suspended.hashCode);
    _$hash = $jc(_$hash, inactive.hashCode);
    _$hash = $jf(_$hash);
    return _$hash;
  }

  @override
  String toString() {
    return (newBuiltValueToStringHelper(r'AgentStats')
          ..add('total', total)
          ..add('active', active)
          ..add('suspended', suspended)
          ..add('inactive', inactive))
        .toString();
  }
}

class AgentStatsBuilder implements Builder<AgentStats, AgentStatsBuilder> {
  _$AgentStats? _$v;

  int? _total;
  int? get total => _$this._total;
  set total(int? total) => _$this._total = total;

  int? _active;
  int? get active => _$this._active;
  set active(int? active) => _$this._active = active;

  int? _suspended;
  int? get suspended => _$this._suspended;
  set suspended(int? suspended) => _$this._suspended = suspended;

  int? _inactive;
  int? get inactive => _$this._inactive;
  set inactive(int? inactive) => _$this._inactive = inactive;

  AgentStatsBuilder() {
    AgentStats._defaults(this);
  }

  AgentStatsBuilder get _$this {
    final $v = _$v;
    if ($v != null) {
      _total = $v.total;
      _active = $v.active;
      _suspended = $v.suspended;
      _inactive = $v.inactive;
      _$v = null;
    }
    return this;
  }

  @override
  void replace(AgentStats other) {
    _$v = other as _$AgentStats;
  }

  @override
  void update(void Function(AgentStatsBuilder)? updates) {
    if (updates != null) updates(this);
  }

  @override
  AgentStats build() => _build();

  _$AgentStats _build() {
    final _$result = _$v ??
        _$AgentStats._(
          total: total,
          active: active,
          suspended: suspended,
          inactive: inactive,
        );
    replace(_$result);
    return _$result;
  }
}

// ignore_for_file: deprecated_member_use_from_same_package,type=lint
