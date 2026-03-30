// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'balance_inquiry_request.dart';

// **************************************************************************
// BuiltValueGenerator
// **************************************************************************

class _$BalanceInquiryRequest extends BalanceInquiryRequest {
  @override
  final String encryptedCardData;
  @override
  final String pinBlock;

  factory _$BalanceInquiryRequest(
          [void Function(BalanceInquiryRequestBuilder)? updates]) =>
      (BalanceInquiryRequestBuilder()..update(updates))._build();

  _$BalanceInquiryRequest._(
      {required this.encryptedCardData, required this.pinBlock})
      : super._();
  @override
  BalanceInquiryRequest rebuild(
          void Function(BalanceInquiryRequestBuilder) updates) =>
      (toBuilder()..update(updates)).build();

  @override
  BalanceInquiryRequestBuilder toBuilder() =>
      BalanceInquiryRequestBuilder()..replace(this);

  @override
  bool operator ==(Object other) {
    if (identical(other, this)) return true;
    return other is BalanceInquiryRequest &&
        encryptedCardData == other.encryptedCardData &&
        pinBlock == other.pinBlock;
  }

  @override
  int get hashCode {
    var _$hash = 0;
    _$hash = $jc(_$hash, encryptedCardData.hashCode);
    _$hash = $jc(_$hash, pinBlock.hashCode);
    _$hash = $jf(_$hash);
    return _$hash;
  }

  @override
  String toString() {
    return (newBuiltValueToStringHelper(r'BalanceInquiryRequest')
          ..add('encryptedCardData', encryptedCardData)
          ..add('pinBlock', pinBlock))
        .toString();
  }
}

class BalanceInquiryRequestBuilder
    implements Builder<BalanceInquiryRequest, BalanceInquiryRequestBuilder> {
  _$BalanceInquiryRequest? _$v;

  String? _encryptedCardData;
  String? get encryptedCardData => _$this._encryptedCardData;
  set encryptedCardData(String? encryptedCardData) =>
      _$this._encryptedCardData = encryptedCardData;

  String? _pinBlock;
  String? get pinBlock => _$this._pinBlock;
  set pinBlock(String? pinBlock) => _$this._pinBlock = pinBlock;

  BalanceInquiryRequestBuilder() {
    BalanceInquiryRequest._defaults(this);
  }

  BalanceInquiryRequestBuilder get _$this {
    final $v = _$v;
    if ($v != null) {
      _encryptedCardData = $v.encryptedCardData;
      _pinBlock = $v.pinBlock;
      _$v = null;
    }
    return this;
  }

  @override
  void replace(BalanceInquiryRequest other) {
    _$v = other as _$BalanceInquiryRequest;
  }

  @override
  void update(void Function(BalanceInquiryRequestBuilder)? updates) {
    if (updates != null) updates(this);
  }

  @override
  BalanceInquiryRequest build() => _build();

  _$BalanceInquiryRequest _build() {
    final _$result = _$v ??
        _$BalanceInquiryRequest._(
          encryptedCardData: BuiltValueNullFieldError.checkNotNull(
              encryptedCardData, r'BalanceInquiryRequest', 'encryptedCardData'),
          pinBlock: BuiltValueNullFieldError.checkNotNull(
              pinBlock, r'BalanceInquiryRequest', 'pinBlock'),
        );
    replace(_$result);
    return _$result;
  }
}

// ignore_for_file: deprecated_member_use_from_same_package,type=lint
