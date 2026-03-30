// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'balance_inquiry_external_request.dart';

// **************************************************************************
// BuiltValueGenerator
// **************************************************************************

class _$BalanceInquiryExternalRequest extends BalanceInquiryExternalRequest {
  @override
  final String encryptedCardData;
  @override
  final String pinBlock;

  factory _$BalanceInquiryExternalRequest(
          [void Function(BalanceInquiryExternalRequestBuilder)? updates]) =>
      (BalanceInquiryExternalRequestBuilder()..update(updates))._build();

  _$BalanceInquiryExternalRequest._(
      {required this.encryptedCardData, required this.pinBlock})
      : super._();
  @override
  BalanceInquiryExternalRequest rebuild(
          void Function(BalanceInquiryExternalRequestBuilder) updates) =>
      (toBuilder()..update(updates)).build();

  @override
  BalanceInquiryExternalRequestBuilder toBuilder() =>
      BalanceInquiryExternalRequestBuilder()..replace(this);

  @override
  bool operator ==(Object other) {
    if (identical(other, this)) return true;
    return other is BalanceInquiryExternalRequest &&
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
    return (newBuiltValueToStringHelper(r'BalanceInquiryExternalRequest')
          ..add('encryptedCardData', encryptedCardData)
          ..add('pinBlock', pinBlock))
        .toString();
  }
}

class BalanceInquiryExternalRequestBuilder
    implements
        Builder<BalanceInquiryExternalRequest,
            BalanceInquiryExternalRequestBuilder> {
  _$BalanceInquiryExternalRequest? _$v;

  String? _encryptedCardData;
  String? get encryptedCardData => _$this._encryptedCardData;
  set encryptedCardData(String? encryptedCardData) =>
      _$this._encryptedCardData = encryptedCardData;

  String? _pinBlock;
  String? get pinBlock => _$this._pinBlock;
  set pinBlock(String? pinBlock) => _$this._pinBlock = pinBlock;

  BalanceInquiryExternalRequestBuilder() {
    BalanceInquiryExternalRequest._defaults(this);
  }

  BalanceInquiryExternalRequestBuilder get _$this {
    final $v = _$v;
    if ($v != null) {
      _encryptedCardData = $v.encryptedCardData;
      _pinBlock = $v.pinBlock;
      _$v = null;
    }
    return this;
  }

  @override
  void replace(BalanceInquiryExternalRequest other) {
    _$v = other as _$BalanceInquiryExternalRequest;
  }

  @override
  void update(void Function(BalanceInquiryExternalRequestBuilder)? updates) {
    if (updates != null) updates(this);
  }

  @override
  BalanceInquiryExternalRequest build() => _build();

  _$BalanceInquiryExternalRequest _build() {
    final _$result = _$v ??
        _$BalanceInquiryExternalRequest._(
          encryptedCardData: BuiltValueNullFieldError.checkNotNull(
              encryptedCardData,
              r'BalanceInquiryExternalRequest',
              'encryptedCardData'),
          pinBlock: BuiltValueNullFieldError.checkNotNull(
              pinBlock, r'BalanceInquiryExternalRequest', 'pinBlock'),
        );
    replace(_$result);
    return _$result;
  }
}

// ignore_for_file: deprecated_member_use_from_same_package,type=lint
