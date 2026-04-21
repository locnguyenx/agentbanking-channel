// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'backoffice_audit_log_list_response.dart';

// **************************************************************************
// BuiltValueGenerator
// **************************************************************************

class _$BackofficeAuditLogListResponse extends BackofficeAuditLogListResponse {
  @override
  final BuiltList<AuditLogRecord>? content;
  @override
  final int? totalElements;
  @override
  final int? totalPages;
  @override
  final int? page;
  @override
  final int? size;

  factory _$BackofficeAuditLogListResponse(
          [void Function(BackofficeAuditLogListResponseBuilder)? updates]) =>
      (BackofficeAuditLogListResponseBuilder()..update(updates))._build();

  _$BackofficeAuditLogListResponse._(
      {this.content, this.totalElements, this.totalPages, this.page, this.size})
      : super._();
  @override
  BackofficeAuditLogListResponse rebuild(
          void Function(BackofficeAuditLogListResponseBuilder) updates) =>
      (toBuilder()..update(updates)).build();

  @override
  BackofficeAuditLogListResponseBuilder toBuilder() =>
      BackofficeAuditLogListResponseBuilder()..replace(this);

  @override
  bool operator ==(Object other) {
    if (identical(other, this)) return true;
    return other is BackofficeAuditLogListResponse &&
        content == other.content &&
        totalElements == other.totalElements &&
        totalPages == other.totalPages &&
        page == other.page &&
        size == other.size;
  }

  @override
  int get hashCode {
    var _$hash = 0;
    _$hash = $jc(_$hash, content.hashCode);
    _$hash = $jc(_$hash, totalElements.hashCode);
    _$hash = $jc(_$hash, totalPages.hashCode);
    _$hash = $jc(_$hash, page.hashCode);
    _$hash = $jc(_$hash, size.hashCode);
    _$hash = $jf(_$hash);
    return _$hash;
  }

  @override
  String toString() {
    return (newBuiltValueToStringHelper(r'BackofficeAuditLogListResponse')
          ..add('content', content)
          ..add('totalElements', totalElements)
          ..add('totalPages', totalPages)
          ..add('page', page)
          ..add('size', size))
        .toString();
  }
}

class BackofficeAuditLogListResponseBuilder
    implements
        Builder<BackofficeAuditLogListResponse,
            BackofficeAuditLogListResponseBuilder> {
  _$BackofficeAuditLogListResponse? _$v;

  ListBuilder<AuditLogRecord>? _content;
  ListBuilder<AuditLogRecord> get content =>
      _$this._content ??= ListBuilder<AuditLogRecord>();
  set content(ListBuilder<AuditLogRecord>? content) =>
      _$this._content = content;

  int? _totalElements;
  int? get totalElements => _$this._totalElements;
  set totalElements(int? totalElements) =>
      _$this._totalElements = totalElements;

  int? _totalPages;
  int? get totalPages => _$this._totalPages;
  set totalPages(int? totalPages) => _$this._totalPages = totalPages;

  int? _page;
  int? get page => _$this._page;
  set page(int? page) => _$this._page = page;

  int? _size;
  int? get size => _$this._size;
  set size(int? size) => _$this._size = size;

  BackofficeAuditLogListResponseBuilder() {
    BackofficeAuditLogListResponse._defaults(this);
  }

  BackofficeAuditLogListResponseBuilder get _$this {
    final $v = _$v;
    if ($v != null) {
      _content = $v.content?.toBuilder();
      _totalElements = $v.totalElements;
      _totalPages = $v.totalPages;
      _page = $v.page;
      _size = $v.size;
      _$v = null;
    }
    return this;
  }

  @override
  void replace(BackofficeAuditLogListResponse other) {
    _$v = other as _$BackofficeAuditLogListResponse;
  }

  @override
  void update(void Function(BackofficeAuditLogListResponseBuilder)? updates) {
    if (updates != null) updates(this);
  }

  @override
  BackofficeAuditLogListResponse build() => _build();

  _$BackofficeAuditLogListResponse _build() {
    _$BackofficeAuditLogListResponse _$result;
    try {
      _$result = _$v ??
          _$BackofficeAuditLogListResponse._(
            content: _content?.build(),
            totalElements: totalElements,
            totalPages: totalPages,
            page: page,
            size: size,
          );
    } catch (_) {
      late String _$failedField;
      try {
        _$failedField = 'content';
        _content?.build();
      } catch (e) {
        throw BuiltValueNestedFieldError(
            r'BackofficeAuditLogListResponse', _$failedField, e.toString());
      }
      rethrow;
    }
    replace(_$result);
    return _$result;
  }
}

// ignore_for_file: deprecated_member_use_from_same_package,type=lint
