// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'agent_list_response.dart';

// **************************************************************************
// BuiltValueGenerator
// **************************************************************************

class _$AgentListResponse extends AgentListResponse {
  @override
  final BuiltList<AgentResponse>? agents;
  @override
  final AgentStats? stats;
  @override
  final int? page;
  @override
  final int? size;

  factory _$AgentListResponse(
          [void Function(AgentListResponseBuilder)? updates]) =>
      (AgentListResponseBuilder()..update(updates))._build();

  _$AgentListResponse._({this.agents, this.stats, this.page, this.size})
      : super._();
  @override
  AgentListResponse rebuild(void Function(AgentListResponseBuilder) updates) =>
      (toBuilder()..update(updates)).build();

  @override
  AgentListResponseBuilder toBuilder() =>
      AgentListResponseBuilder()..replace(this);

  @override
  bool operator ==(Object other) {
    if (identical(other, this)) return true;
    return other is AgentListResponse &&
        agents == other.agents &&
        stats == other.stats &&
        page == other.page &&
        size == other.size;
  }

  @override
  int get hashCode {
    var _$hash = 0;
    _$hash = $jc(_$hash, agents.hashCode);
    _$hash = $jc(_$hash, stats.hashCode);
    _$hash = $jc(_$hash, page.hashCode);
    _$hash = $jc(_$hash, size.hashCode);
    _$hash = $jf(_$hash);
    return _$hash;
  }

  @override
  String toString() {
    return (newBuiltValueToStringHelper(r'AgentListResponse')
          ..add('agents', agents)
          ..add('stats', stats)
          ..add('page', page)
          ..add('size', size))
        .toString();
  }
}

class AgentListResponseBuilder
    implements Builder<AgentListResponse, AgentListResponseBuilder> {
  _$AgentListResponse? _$v;

  ListBuilder<AgentResponse>? _agents;
  ListBuilder<AgentResponse> get agents =>
      _$this._agents ??= ListBuilder<AgentResponse>();
  set agents(ListBuilder<AgentResponse>? agents) => _$this._agents = agents;

  AgentStatsBuilder? _stats;
  AgentStatsBuilder get stats => _$this._stats ??= AgentStatsBuilder();
  set stats(AgentStatsBuilder? stats) => _$this._stats = stats;

  int? _page;
  int? get page => _$this._page;
  set page(int? page) => _$this._page = page;

  int? _size;
  int? get size => _$this._size;
  set size(int? size) => _$this._size = size;

  AgentListResponseBuilder() {
    AgentListResponse._defaults(this);
  }

  AgentListResponseBuilder get _$this {
    final $v = _$v;
    if ($v != null) {
      _agents = $v.agents?.toBuilder();
      _stats = $v.stats?.toBuilder();
      _page = $v.page;
      _size = $v.size;
      _$v = null;
    }
    return this;
  }

  @override
  void replace(AgentListResponse other) {
    _$v = other as _$AgentListResponse;
  }

  @override
  void update(void Function(AgentListResponseBuilder)? updates) {
    if (updates != null) updates(this);
  }

  @override
  AgentListResponse build() => _build();

  _$AgentListResponse _build() {
    _$AgentListResponse _$result;
    try {
      _$result = _$v ??
          _$AgentListResponse._(
            agents: _agents?.build(),
            stats: _stats?.build(),
            page: page,
            size: size,
          );
    } catch (_) {
      late String _$failedField;
      try {
        _$failedField = 'agents';
        _agents?.build();
        _$failedField = 'stats';
        _stats?.build();
      } catch (e) {
        throw BuiltValueNestedFieldError(
            r'AgentListResponse', _$failedField, e.toString());
      }
      rethrow;
    }
    replace(_$result);
    return _$result;
  }
}

// ignore_for_file: deprecated_member_use_from_same_package,type=lint
