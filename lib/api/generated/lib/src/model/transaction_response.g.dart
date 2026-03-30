// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'transaction_response.dart';

// **************************************************************************
// BuiltValueGenerator
// **************************************************************************

const TransactionResponseStatusEnum _$transactionResponseStatusEnum_SUCCESS =
    const TransactionResponseStatusEnum._('SUCCESS');
const TransactionResponseStatusEnum _$transactionResponseStatusEnum_PENDING =
    const TransactionResponseStatusEnum._('PENDING');
const TransactionResponseStatusEnum _$transactionResponseStatusEnum_FAILED =
    const TransactionResponseStatusEnum._('FAILED');

TransactionResponseStatusEnum _$transactionResponseStatusEnumValueOf(
    String name) {
  switch (name) {
    case 'SUCCESS':
      return _$transactionResponseStatusEnum_SUCCESS;
    case 'PENDING':
      return _$transactionResponseStatusEnum_PENDING;
    case 'FAILED':
      return _$transactionResponseStatusEnum_FAILED;
    default:
      throw ArgumentError(name);
  }
}

final BuiltSet<TransactionResponseStatusEnum>
    _$transactionResponseStatusEnumValues = BuiltSet<
        TransactionResponseStatusEnum>(const <TransactionResponseStatusEnum>[
  _$transactionResponseStatusEnum_SUCCESS,
  _$transactionResponseStatusEnum_PENDING,
  _$transactionResponseStatusEnum_FAILED,
]);

Serializer<TransactionResponseStatusEnum>
    _$transactionResponseStatusEnumSerializer =
    _$TransactionResponseStatusEnumSerializer();

class _$TransactionResponseStatusEnumSerializer
    implements PrimitiveSerializer<TransactionResponseStatusEnum> {
  static const Map<String, Object> _toWire = const <String, Object>{
    'SUCCESS': 'SUCCESS',
    'PENDING': 'PENDING',
    'FAILED': 'FAILED',
  };
  static const Map<Object, String> _fromWire = const <Object, String>{
    'SUCCESS': 'SUCCESS',
    'PENDING': 'PENDING',
    'FAILED': 'FAILED',
  };

  @override
  final Iterable<Type> types = const <Type>[TransactionResponseStatusEnum];
  @override
  final String wireName = 'TransactionResponseStatusEnum';

  @override
  Object serialize(
          Serializers serializers, TransactionResponseStatusEnum object,
          {FullType specifiedType = FullType.unspecified}) =>
      _toWire[object.name] ?? object.name;

  @override
  TransactionResponseStatusEnum deserialize(
          Serializers serializers, Object serialized,
          {FullType specifiedType = FullType.unspecified}) =>
      TransactionResponseStatusEnum.valueOf(
          _fromWire[serialized] ?? (serialized is String ? serialized : ''));
}

class _$TransactionResponse extends TransactionResponse {
  @override
  final TransactionResponseStatusEnum? status;
  @override
  final String? transactionId;
  @override
  final num? amount;
  @override
  final String? currency;
  @override
  final String? transactionType;
  @override
  final DateTime? timestamp;
  @override
  final String? message;
  @override
  final String? reference;

  factory _$TransactionResponse(
          [void Function(TransactionResponseBuilder)? updates]) =>
      (TransactionResponseBuilder()..update(updates))._build();

  _$TransactionResponse._(
      {this.status,
      this.transactionId,
      this.amount,
      this.currency,
      this.transactionType,
      this.timestamp,
      this.message,
      this.reference})
      : super._();
  @override
  TransactionResponse rebuild(
          void Function(TransactionResponseBuilder) updates) =>
      (toBuilder()..update(updates)).build();

  @override
  TransactionResponseBuilder toBuilder() =>
      TransactionResponseBuilder()..replace(this);

  @override
  bool operator ==(Object other) {
    if (identical(other, this)) return true;
    return other is TransactionResponse &&
        status == other.status &&
        transactionId == other.transactionId &&
        amount == other.amount &&
        currency == other.currency &&
        transactionType == other.transactionType &&
        timestamp == other.timestamp &&
        message == other.message &&
        reference == other.reference;
  }

  @override
  int get hashCode {
    var _$hash = 0;
    _$hash = $jc(_$hash, status.hashCode);
    _$hash = $jc(_$hash, transactionId.hashCode);
    _$hash = $jc(_$hash, amount.hashCode);
    _$hash = $jc(_$hash, currency.hashCode);
    _$hash = $jc(_$hash, transactionType.hashCode);
    _$hash = $jc(_$hash, timestamp.hashCode);
    _$hash = $jc(_$hash, message.hashCode);
    _$hash = $jc(_$hash, reference.hashCode);
    _$hash = $jf(_$hash);
    return _$hash;
  }

  @override
  String toString() {
    return (newBuiltValueToStringHelper(r'TransactionResponse')
          ..add('status', status)
          ..add('transactionId', transactionId)
          ..add('amount', amount)
          ..add('currency', currency)
          ..add('transactionType', transactionType)
          ..add('timestamp', timestamp)
          ..add('message', message)
          ..add('reference', reference))
        .toString();
  }
}

class TransactionResponseBuilder
    implements Builder<TransactionResponse, TransactionResponseBuilder> {
  _$TransactionResponse? _$v;

  TransactionResponseStatusEnum? _status;
  TransactionResponseStatusEnum? get status => _$this._status;
  set status(TransactionResponseStatusEnum? status) => _$this._status = status;

  String? _transactionId;
  String? get transactionId => _$this._transactionId;
  set transactionId(String? transactionId) =>
      _$this._transactionId = transactionId;

  num? _amount;
  num? get amount => _$this._amount;
  set amount(num? amount) => _$this._amount = amount;

  String? _currency;
  String? get currency => _$this._currency;
  set currency(String? currency) => _$this._currency = currency;

  String? _transactionType;
  String? get transactionType => _$this._transactionType;
  set transactionType(String? transactionType) =>
      _$this._transactionType = transactionType;

  DateTime? _timestamp;
  DateTime? get timestamp => _$this._timestamp;
  set timestamp(DateTime? timestamp) => _$this._timestamp = timestamp;

  String? _message;
  String? get message => _$this._message;
  set message(String? message) => _$this._message = message;

  String? _reference;
  String? get reference => _$this._reference;
  set reference(String? reference) => _$this._reference = reference;

  TransactionResponseBuilder() {
    TransactionResponse._defaults(this);
  }

  TransactionResponseBuilder get _$this {
    final $v = _$v;
    if ($v != null) {
      _status = $v.status;
      _transactionId = $v.transactionId;
      _amount = $v.amount;
      _currency = $v.currency;
      _transactionType = $v.transactionType;
      _timestamp = $v.timestamp;
      _message = $v.message;
      _reference = $v.reference;
      _$v = null;
    }
    return this;
  }

  @override
  void replace(TransactionResponse other) {
    _$v = other as _$TransactionResponse;
  }

  @override
  void update(void Function(TransactionResponseBuilder)? updates) {
    if (updates != null) updates(this);
  }

  @override
  TransactionResponse build() => _build();

  _$TransactionResponse _build() {
    final _$result = _$v ??
        _$TransactionResponse._(
          status: status,
          transactionId: transactionId,
          amount: amount,
          currency: currency,
          transactionType: transactionType,
          timestamp: timestamp,
          message: message,
          reference: reference,
        );
    replace(_$result);
    return _$result;
  }
}

// ignore_for_file: deprecated_member_use_from_same_package,type=lint
