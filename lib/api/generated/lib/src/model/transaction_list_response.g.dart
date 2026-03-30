// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'transaction_list_response.dart';

// **************************************************************************
// BuiltValueGenerator
// **************************************************************************

class _$TransactionListResponse extends TransactionListResponse {
  @override
  final BuiltList<TransactionResponse>? transactions;
  @override
  final int? page;
  @override
  final int? size;
  @override
  final int? totalElements;
  @override
  final int? totalPages;

  factory _$TransactionListResponse(
          [void Function(TransactionListResponseBuilder)? updates]) =>
      (TransactionListResponseBuilder()..update(updates))._build();

  _$TransactionListResponse._(
      {this.transactions,
      this.page,
      this.size,
      this.totalElements,
      this.totalPages})
      : super._();
  @override
  TransactionListResponse rebuild(
          void Function(TransactionListResponseBuilder) updates) =>
      (toBuilder()..update(updates)).build();

  @override
  TransactionListResponseBuilder toBuilder() =>
      TransactionListResponseBuilder()..replace(this);

  @override
  bool operator ==(Object other) {
    if (identical(other, this)) return true;
    return other is TransactionListResponse &&
        transactions == other.transactions &&
        page == other.page &&
        size == other.size &&
        totalElements == other.totalElements &&
        totalPages == other.totalPages;
  }

  @override
  int get hashCode {
    var _$hash = 0;
    _$hash = $jc(_$hash, transactions.hashCode);
    _$hash = $jc(_$hash, page.hashCode);
    _$hash = $jc(_$hash, size.hashCode);
    _$hash = $jc(_$hash, totalElements.hashCode);
    _$hash = $jc(_$hash, totalPages.hashCode);
    _$hash = $jf(_$hash);
    return _$hash;
  }

  @override
  String toString() {
    return (newBuiltValueToStringHelper(r'TransactionListResponse')
          ..add('transactions', transactions)
          ..add('page', page)
          ..add('size', size)
          ..add('totalElements', totalElements)
          ..add('totalPages', totalPages))
        .toString();
  }
}

class TransactionListResponseBuilder
    implements
        Builder<TransactionListResponse, TransactionListResponseBuilder> {
  _$TransactionListResponse? _$v;

  ListBuilder<TransactionResponse>? _transactions;
  ListBuilder<TransactionResponse> get transactions =>
      _$this._transactions ??= ListBuilder<TransactionResponse>();
  set transactions(ListBuilder<TransactionResponse>? transactions) =>
      _$this._transactions = transactions;

  int? _page;
  int? get page => _$this._page;
  set page(int? page) => _$this._page = page;

  int? _size;
  int? get size => _$this._size;
  set size(int? size) => _$this._size = size;

  int? _totalElements;
  int? get totalElements => _$this._totalElements;
  set totalElements(int? totalElements) =>
      _$this._totalElements = totalElements;

  int? _totalPages;
  int? get totalPages => _$this._totalPages;
  set totalPages(int? totalPages) => _$this._totalPages = totalPages;

  TransactionListResponseBuilder() {
    TransactionListResponse._defaults(this);
  }

  TransactionListResponseBuilder get _$this {
    final $v = _$v;
    if ($v != null) {
      _transactions = $v.transactions?.toBuilder();
      _page = $v.page;
      _size = $v.size;
      _totalElements = $v.totalElements;
      _totalPages = $v.totalPages;
      _$v = null;
    }
    return this;
  }

  @override
  void replace(TransactionListResponse other) {
    _$v = other as _$TransactionListResponse;
  }

  @override
  void update(void Function(TransactionListResponseBuilder)? updates) {
    if (updates != null) updates(this);
  }

  @override
  TransactionListResponse build() => _build();

  _$TransactionListResponse _build() {
    _$TransactionListResponse _$result;
    try {
      _$result = _$v ??
          _$TransactionListResponse._(
            transactions: _transactions?.build(),
            page: page,
            size: size,
            totalElements: totalElements,
            totalPages: totalPages,
          );
    } catch (_) {
      late String _$failedField;
      try {
        _$failedField = 'transactions';
        _transactions?.build();
      } catch (e) {
        throw BuiltValueNestedFieldError(
            r'TransactionListResponse', _$failedField, e.toString());
      }
      rethrow;
    }
    replace(_$result);
    return _$result;
  }
}

// ignore_for_file: deprecated_member_use_from_same_package,type=lint
