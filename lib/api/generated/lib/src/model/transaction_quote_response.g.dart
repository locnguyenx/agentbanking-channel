// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'transaction_quote_response.dart';

// **************************************************************************
// BuiltValueGenerator
// **************************************************************************

class _$TransactionQuoteResponse extends TransactionQuoteResponse {
  @override
  final String quoteId;
  @override
  final String amount;
  @override
  final String fee;
  @override
  final String total;
  @override
  final String commission;

  factory _$TransactionQuoteResponse(
          [void Function(TransactionQuoteResponseBuilder)? updates]) =>
      (TransactionQuoteResponseBuilder()..update(updates))._build();

  _$TransactionQuoteResponse._(
      {required this.quoteId,
      required this.amount,
      required this.fee,
      required this.total,
      required this.commission})
      : super._();
  @override
  TransactionQuoteResponse rebuild(
          void Function(TransactionQuoteResponseBuilder) updates) =>
      (toBuilder()..update(updates)).build();

  @override
  TransactionQuoteResponseBuilder toBuilder() =>
      TransactionQuoteResponseBuilder()..replace(this);

  @override
  bool operator ==(Object other) {
    if (identical(other, this)) return true;
    return other is TransactionQuoteResponse &&
        quoteId == other.quoteId &&
        amount == other.amount &&
        fee == other.fee &&
        total == other.total &&
        commission == other.commission;
  }

  @override
  int get hashCode {
    var _$hash = 0;
    _$hash = $jc(_$hash, quoteId.hashCode);
    _$hash = $jc(_$hash, amount.hashCode);
    _$hash = $jc(_$hash, fee.hashCode);
    _$hash = $jc(_$hash, total.hashCode);
    _$hash = $jc(_$hash, commission.hashCode);
    _$hash = $jf(_$hash);
    return _$hash;
  }

  @override
  String toString() {
    return (newBuiltValueToStringHelper(r'TransactionQuoteResponse')
          ..add('quoteId', quoteId)
          ..add('amount', amount)
          ..add('fee', fee)
          ..add('total', total)
          ..add('commission', commission))
        .toString();
  }
}

class TransactionQuoteResponseBuilder
    implements
        Builder<TransactionQuoteResponse, TransactionQuoteResponseBuilder> {
  _$TransactionQuoteResponse? _$v;

  String? _quoteId;
  String? get quoteId => _$this._quoteId;
  set quoteId(String? quoteId) => _$this._quoteId = quoteId;

  String? _amount;
  String? get amount => _$this._amount;
  set amount(String? amount) => _$this._amount = amount;

  String? _fee;
  String? get fee => _$this._fee;
  set fee(String? fee) => _$this._fee = fee;

  String? _total;
  String? get total => _$this._total;
  set total(String? total) => _$this._total = total;

  String? _commission;
  String? get commission => _$this._commission;
  set commission(String? commission) => _$this._commission = commission;

  TransactionQuoteResponseBuilder() {
    TransactionQuoteResponse._defaults(this);
  }

  TransactionQuoteResponseBuilder get _$this {
    final $v = _$v;
    if ($v != null) {
      _quoteId = $v.quoteId;
      _amount = $v.amount;
      _fee = $v.fee;
      _total = $v.total;
      _commission = $v.commission;
      _$v = null;
    }
    return this;
  }

  @override
  void replace(TransactionQuoteResponse other) {
    _$v = other as _$TransactionQuoteResponse;
  }

  @override
  void update(void Function(TransactionQuoteResponseBuilder)? updates) {
    if (updates != null) updates(this);
  }

  @override
  TransactionQuoteResponse build() => _build();

  _$TransactionQuoteResponse _build() {
    final _$result = _$v ??
        _$TransactionQuoteResponse._(
          quoteId: BuiltValueNullFieldError.checkNotNull(
              quoteId, r'TransactionQuoteResponse', 'quoteId'),
          amount: BuiltValueNullFieldError.checkNotNull(
              amount, r'TransactionQuoteResponse', 'amount'),
          fee: BuiltValueNullFieldError.checkNotNull(
              fee, r'TransactionQuoteResponse', 'fee'),
          total: BuiltValueNullFieldError.checkNotNull(
              total, r'TransactionQuoteResponse', 'total'),
          commission: BuiltValueNullFieldError.checkNotNull(
              commission, r'TransactionQuoteResponse', 'commission'),
        );
    replace(_$result);
    return _$result;
  }
}

// ignore_for_file: deprecated_member_use_from_same_package,type=lint
