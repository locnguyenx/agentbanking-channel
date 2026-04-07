// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'reversal_request.dart';

// **************************************************************************
// BuiltValueGenerator
// **************************************************************************

class _$ReversalRequest extends ReversalRequest {
  @override
  final String originalTransactionId;
  @override
  final String originalReference;
  @override
  final String amount;

  factory _$ReversalRequest([void Function(ReversalRequestBuilder)? updates]) =>
      (ReversalRequestBuilder()..update(updates))._build();

  _$ReversalRequest._(
      {required this.originalTransactionId,
      required this.originalReference,
      required this.amount})
      : super._();
  @override
  ReversalRequest rebuild(void Function(ReversalRequestBuilder) updates) =>
      (toBuilder()..update(updates)).build();

  @override
  ReversalRequestBuilder toBuilder() => ReversalRequestBuilder()..replace(this);

  @override
  bool operator ==(Object other) {
    if (identical(other, this)) return true;
    return other is ReversalRequest &&
        originalTransactionId == other.originalTransactionId &&
        originalReference == other.originalReference &&
        amount == other.amount;
  }

  @override
  int get hashCode {
    var _$hash = 0;
    _$hash = $jc(_$hash, originalTransactionId.hashCode);
    _$hash = $jc(_$hash, originalReference.hashCode);
    _$hash = $jc(_$hash, amount.hashCode);
    _$hash = $jf(_$hash);
    return _$hash;
  }

  @override
  String toString() {
    return (newBuiltValueToStringHelper(r'ReversalRequest')
          ..add('originalTransactionId', originalTransactionId)
          ..add('originalReference', originalReference)
          ..add('amount', amount))
        .toString();
  }
}

class ReversalRequestBuilder
    implements Builder<ReversalRequest, ReversalRequestBuilder> {
  _$ReversalRequest? _$v;

  String? _originalTransactionId;
  String? get originalTransactionId => _$this._originalTransactionId;
  set originalTransactionId(String? originalTransactionId) =>
      _$this._originalTransactionId = originalTransactionId;

  String? _originalReference;
  String? get originalReference => _$this._originalReference;
  set originalReference(String? originalReference) =>
      _$this._originalReference = originalReference;

  String? _amount;
  String? get amount => _$this._amount;
  set amount(String? amount) => _$this._amount = amount;

  ReversalRequestBuilder() {
    ReversalRequest._defaults(this);
  }

  ReversalRequestBuilder get _$this {
    final $v = _$v;
    if ($v != null) {
      _originalTransactionId = $v.originalTransactionId;
      _originalReference = $v.originalReference;
      _amount = $v.amount;
      _$v = null;
    }
    return this;
  }

  @override
  void replace(ReversalRequest other) {
    _$v = other as _$ReversalRequest;
  }

  @override
  void update(void Function(ReversalRequestBuilder)? updates) {
    if (updates != null) updates(this);
  }

  @override
  ReversalRequest build() => _build();

  _$ReversalRequest _build() {
    final _$result = _$v ??
        _$ReversalRequest._(
          originalTransactionId: BuiltValueNullFieldError.checkNotNull(
              originalTransactionId,
              r'ReversalRequest',
              'originalTransactionId'),
          originalReference: BuiltValueNullFieldError.checkNotNull(
              originalReference, r'ReversalRequest', 'originalReference'),
          amount: BuiltValueNullFieldError.checkNotNull(
              amount, r'ReversalRequest', 'amount'),
        );
    replace(_$result);
    return _$result;
  }
}

// ignore_for_file: deprecated_member_use_from_same_package,type=lint
