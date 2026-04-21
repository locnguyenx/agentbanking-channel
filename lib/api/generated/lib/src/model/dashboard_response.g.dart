// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'dashboard_response.dart';

// **************************************************************************
// BuiltValueGenerator
// **************************************************************************

class _$DashboardResponse extends DashboardResponse {
  @override
  final int? totalAgents;
  @override
  final int? activeAgents;
  @override
  final int? totalTransactions;
  @override
  final num? totalVolume;
  @override
  final num? totalCredits;
  @override
  final num? totalDebits;
  @override
  final int? pendingKyc;
  @override
  final num? successRate;
  @override
  final BuiltList<DashboardResponseDailyStatsInner>? dailyStats;

  factory _$DashboardResponse(
          [void Function(DashboardResponseBuilder)? updates]) =>
      (DashboardResponseBuilder()..update(updates))._build();

  _$DashboardResponse._(
      {this.totalAgents,
      this.activeAgents,
      this.totalTransactions,
      this.totalVolume,
      this.totalCredits,
      this.totalDebits,
      this.pendingKyc,
      this.successRate,
      this.dailyStats})
      : super._();
  @override
  DashboardResponse rebuild(void Function(DashboardResponseBuilder) updates) =>
      (toBuilder()..update(updates)).build();

  @override
  DashboardResponseBuilder toBuilder() =>
      DashboardResponseBuilder()..replace(this);

  @override
  bool operator ==(Object other) {
    if (identical(other, this)) return true;
    return other is DashboardResponse &&
        totalAgents == other.totalAgents &&
        activeAgents == other.activeAgents &&
        totalTransactions == other.totalTransactions &&
        totalVolume == other.totalVolume &&
        totalCredits == other.totalCredits &&
        totalDebits == other.totalDebits &&
        pendingKyc == other.pendingKyc &&
        successRate == other.successRate &&
        dailyStats == other.dailyStats;
  }

  @override
  int get hashCode {
    var _$hash = 0;
    _$hash = $jc(_$hash, totalAgents.hashCode);
    _$hash = $jc(_$hash, activeAgents.hashCode);
    _$hash = $jc(_$hash, totalTransactions.hashCode);
    _$hash = $jc(_$hash, totalVolume.hashCode);
    _$hash = $jc(_$hash, totalCredits.hashCode);
    _$hash = $jc(_$hash, totalDebits.hashCode);
    _$hash = $jc(_$hash, pendingKyc.hashCode);
    _$hash = $jc(_$hash, successRate.hashCode);
    _$hash = $jc(_$hash, dailyStats.hashCode);
    _$hash = $jf(_$hash);
    return _$hash;
  }

  @override
  String toString() {
    return (newBuiltValueToStringHelper(r'DashboardResponse')
          ..add('totalAgents', totalAgents)
          ..add('activeAgents', activeAgents)
          ..add('totalTransactions', totalTransactions)
          ..add('totalVolume', totalVolume)
          ..add('totalCredits', totalCredits)
          ..add('totalDebits', totalDebits)
          ..add('pendingKyc', pendingKyc)
          ..add('successRate', successRate)
          ..add('dailyStats', dailyStats))
        .toString();
  }
}

class DashboardResponseBuilder
    implements Builder<DashboardResponse, DashboardResponseBuilder> {
  _$DashboardResponse? _$v;

  int? _totalAgents;
  int? get totalAgents => _$this._totalAgents;
  set totalAgents(int? totalAgents) => _$this._totalAgents = totalAgents;

  int? _activeAgents;
  int? get activeAgents => _$this._activeAgents;
  set activeAgents(int? activeAgents) => _$this._activeAgents = activeAgents;

  int? _totalTransactions;
  int? get totalTransactions => _$this._totalTransactions;
  set totalTransactions(int? totalTransactions) =>
      _$this._totalTransactions = totalTransactions;

  num? _totalVolume;
  num? get totalVolume => _$this._totalVolume;
  set totalVolume(num? totalVolume) => _$this._totalVolume = totalVolume;

  num? _totalCredits;
  num? get totalCredits => _$this._totalCredits;
  set totalCredits(num? totalCredits) => _$this._totalCredits = totalCredits;

  num? _totalDebits;
  num? get totalDebits => _$this._totalDebits;
  set totalDebits(num? totalDebits) => _$this._totalDebits = totalDebits;

  int? _pendingKyc;
  int? get pendingKyc => _$this._pendingKyc;
  set pendingKyc(int? pendingKyc) => _$this._pendingKyc = pendingKyc;

  num? _successRate;
  num? get successRate => _$this._successRate;
  set successRate(num? successRate) => _$this._successRate = successRate;

  ListBuilder<DashboardResponseDailyStatsInner>? _dailyStats;
  ListBuilder<DashboardResponseDailyStatsInner> get dailyStats =>
      _$this._dailyStats ??= ListBuilder<DashboardResponseDailyStatsInner>();
  set dailyStats(ListBuilder<DashboardResponseDailyStatsInner>? dailyStats) =>
      _$this._dailyStats = dailyStats;

  DashboardResponseBuilder() {
    DashboardResponse._defaults(this);
  }

  DashboardResponseBuilder get _$this {
    final $v = _$v;
    if ($v != null) {
      _totalAgents = $v.totalAgents;
      _activeAgents = $v.activeAgents;
      _totalTransactions = $v.totalTransactions;
      _totalVolume = $v.totalVolume;
      _totalCredits = $v.totalCredits;
      _totalDebits = $v.totalDebits;
      _pendingKyc = $v.pendingKyc;
      _successRate = $v.successRate;
      _dailyStats = $v.dailyStats?.toBuilder();
      _$v = null;
    }
    return this;
  }

  @override
  void replace(DashboardResponse other) {
    _$v = other as _$DashboardResponse;
  }

  @override
  void update(void Function(DashboardResponseBuilder)? updates) {
    if (updates != null) updates(this);
  }

  @override
  DashboardResponse build() => _build();

  _$DashboardResponse _build() {
    _$DashboardResponse _$result;
    try {
      _$result = _$v ??
          _$DashboardResponse._(
            totalAgents: totalAgents,
            activeAgents: activeAgents,
            totalTransactions: totalTransactions,
            totalVolume: totalVolume,
            totalCredits: totalCredits,
            totalDebits: totalDebits,
            pendingKyc: pendingKyc,
            successRate: successRate,
            dailyStats: _dailyStats?.build(),
          );
    } catch (_) {
      late String _$failedField;
      try {
        _$failedField = 'dailyStats';
        _dailyStats?.build();
      } catch (e) {
        throw BuiltValueNestedFieldError(
            r'DashboardResponse', _$failedField, e.toString());
      }
      rethrow;
    }
    replace(_$result);
    return _$result;
  }
}

// ignore_for_file: deprecated_member_use_from_same_package,type=lint
