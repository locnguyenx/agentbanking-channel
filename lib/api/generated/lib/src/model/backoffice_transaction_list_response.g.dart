// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'backoffice_transaction_list_response.dart';

// **************************************************************************
// BuiltValueGenerator
// **************************************************************************

class _$BackofficeTransactionListResponse
    extends BackofficeTransactionListResponse {
  @override
  final BuiltList<BuiltMap<String, JsonObject?>>? content;
  @override
  final int? total;

  factory _$BackofficeTransactionListResponse(
          [void Function(BackofficeTransactionListResponseBuilder)? updates]) =>
      (BackofficeTransactionListResponseBuilder()..update(updates))._build();

  _$BackofficeTransactionListResponse._({this.content, this.total}) : super._();
  @override
  BackofficeTransactionListResponse rebuild(
          void Function(BackofficeTransactionListResponseBuilder) updates) =>
      (toBuilder()..update(updates)).build();

  @override
  BackofficeTransactionListResponseBuilder toBuilder() =>
      BackofficeTransactionListResponseBuilder()..replace(this);

  @override
  bool operator ==(Object other) {
    if (identical(other, this)) return true;
    return other is BackofficeTransactionListResponse &&
        content == other.content &&
        total == other.total;
  }

  @override
  int get hashCode {
    var _$hash = 0;
    _$hash = $jc(_$hash, content.hashCode);
    _$hash = $jc(_$hash, total.hashCode);
    _$hash = $jf(_$hash);
    return _$hash;
  }

  @override
  String toString() {
    return (newBuiltValueToStringHelper(r'BackofficeTransactionListResponse')
          ..add('content', content)
          ..add('total', total))
        .toString();
  }
}

class BackofficeTransactionListResponseBuilder
    implements
        Builder<BackofficeTransactionListResponse,
            BackofficeTransactionListResponseBuilder> {
  _$BackofficeTransactionListResponse? _$v;

  ListBuilder<BuiltMap<String, JsonObject?>>? _content;
  ListBuilder<BuiltMap<String, JsonObject?>> get content =>
      _$this._content ??= ListBuilder<BuiltMap<String, JsonObject?>>();
  set content(ListBuilder<BuiltMap<String, JsonObject?>>? content) =>
      _$this._content = content;

  int? _total;
  int? get total => _$this._total;
  set total(int? total) => _$this._total = total;

  BackofficeTransactionListResponseBuilder() {
    BackofficeTransactionListResponse._defaults(this);
  }

  BackofficeTransactionListResponseBuilder get _$this {
    final $v = _$v;
    if ($v != null) {
      _content = $v.content?.toBuilder();
      _total = $v.total;
      _$v = null;
    }
    return this;
  }

  @override
  void replace(BackofficeTransactionListResponse other) {
    _$v = other as _$BackofficeTransactionListResponse;
  }

  @override
  void update(
      void Function(BackofficeTransactionListResponseBuilder)? updates) {
    if (updates != null) updates(this);
  }

  @override
  BackofficeTransactionListResponse build() => _build();

  _$BackofficeTransactionListResponse _build() {
    _$BackofficeTransactionListResponse _$result;
    try {
      _$result = _$v ??
          _$BackofficeTransactionListResponse._(
            content: _content?.build(),
            total: total,
          );
    } catch (_) {
      late String _$failedField;
      try {
        _$failedField = 'content';
        _content?.build();
      } catch (e) {
        throw BuiltValueNestedFieldError(
            r'BackofficeTransactionListResponse', _$failedField, e.toString());
      }
      rethrow;
    }
    replace(_$result);
    return _$result;
  }
}

// ignore_for_file: deprecated_member_use_from_same_package,type=lint
