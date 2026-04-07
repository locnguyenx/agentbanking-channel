// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'dashboard_response_daily_stats_inner.dart';

// **************************************************************************
// BuiltValueGenerator
// **************************************************************************

class _$DashboardResponseDailyStatsInner
    extends DashboardResponseDailyStatsInner {
  @override
  final String? date;
  @override
  final int? transactionCount;
  @override
  final String? volume;

  factory _$DashboardResponseDailyStatsInner(
          [void Function(DashboardResponseDailyStatsInnerBuilder)? updates]) =>
      (DashboardResponseDailyStatsInnerBuilder()..update(updates))._build();

  _$DashboardResponseDailyStatsInner._(
      {this.date, this.transactionCount, this.volume})
      : super._();
  @override
  DashboardResponseDailyStatsInner rebuild(
          void Function(DashboardResponseDailyStatsInnerBuilder) updates) =>
      (toBuilder()..update(updates)).build();

  @override
  DashboardResponseDailyStatsInnerBuilder toBuilder() =>
      DashboardResponseDailyStatsInnerBuilder()..replace(this);

  @override
  bool operator ==(Object other) {
    if (identical(other, this)) return true;
    return other is DashboardResponseDailyStatsInner &&
        date == other.date &&
        transactionCount == other.transactionCount &&
        volume == other.volume;
  }

  @override
  int get hashCode {
    var _$hash = 0;
    _$hash = $jc(_$hash, date.hashCode);
    _$hash = $jc(_$hash, transactionCount.hashCode);
    _$hash = $jc(_$hash, volume.hashCode);
    _$hash = $jf(_$hash);
    return _$hash;
  }

  @override
  String toString() {
    return (newBuiltValueToStringHelper(r'DashboardResponseDailyStatsInner')
          ..add('date', date)
          ..add('transactionCount', transactionCount)
          ..add('volume', volume))
        .toString();
  }
}

class DashboardResponseDailyStatsInnerBuilder
    implements
        Builder<DashboardResponseDailyStatsInner,
            DashboardResponseDailyStatsInnerBuilder> {
  _$DashboardResponseDailyStatsInner? _$v;

  String? _date;
  String? get date => _$this._date;
  set date(String? date) => _$this._date = date;

  int? _transactionCount;
  int? get transactionCount => _$this._transactionCount;
  set transactionCount(int? transactionCount) =>
      _$this._transactionCount = transactionCount;

  String? _volume;
  String? get volume => _$this._volume;
  set volume(String? volume) => _$this._volume = volume;

  DashboardResponseDailyStatsInnerBuilder() {
    DashboardResponseDailyStatsInner._defaults(this);
  }

  DashboardResponseDailyStatsInnerBuilder get _$this {
    final $v = _$v;
    if ($v != null) {
      _date = $v.date;
      _transactionCount = $v.transactionCount;
      _volume = $v.volume;
      _$v = null;
    }
    return this;
  }

  @override
  void replace(DashboardResponseDailyStatsInner other) {
    _$v = other as _$DashboardResponseDailyStatsInner;
  }

  @override
  void update(void Function(DashboardResponseDailyStatsInnerBuilder)? updates) {
    if (updates != null) updates(this);
  }

  @override
  DashboardResponseDailyStatsInner build() => _build();

  _$DashboardResponseDailyStatsInner _build() {
    final _$result = _$v ??
        _$DashboardResponseDailyStatsInner._(
          date: date,
          transactionCount: transactionCount,
          volume: volume,
        );
    replace(_$result);
    return _$result;
  }
}

// ignore_for_file: deprecated_member_use_from_same_package,type=lint
