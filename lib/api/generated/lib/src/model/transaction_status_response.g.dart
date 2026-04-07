// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'transaction_status_response.dart';

// **************************************************************************
// BuiltValueGenerator
// **************************************************************************

const TransactionStatusResponseStatusEnum
    _$transactionStatusResponseStatusEnum_PENDING =
    const TransactionStatusResponseStatusEnum._('PENDING');
const TransactionStatusResponseStatusEnum
    _$transactionStatusResponseStatusEnum_RUNNING =
    const TransactionStatusResponseStatusEnum._('RUNNING');
const TransactionStatusResponseStatusEnum
    _$transactionStatusResponseStatusEnum_COMPLETED =
    const TransactionStatusResponseStatusEnum._('COMPLETED');
const TransactionStatusResponseStatusEnum
    _$transactionStatusResponseStatusEnum_FAILED =
    const TransactionStatusResponseStatusEnum._('FAILED');
const TransactionStatusResponseStatusEnum
    _$transactionStatusResponseStatusEnum_COMPENSATING =
    const TransactionStatusResponseStatusEnum._('COMPENSATING');
const TransactionStatusResponseStatusEnum
    _$transactionStatusResponseStatusEnum_UNKNOWN =
    const TransactionStatusResponseStatusEnum._('UNKNOWN');

TransactionStatusResponseStatusEnum
    _$transactionStatusResponseStatusEnumValueOf(String name) {
  switch (name) {
    case 'PENDING':
      return _$transactionStatusResponseStatusEnum_PENDING;
    case 'RUNNING':
      return _$transactionStatusResponseStatusEnum_RUNNING;
    case 'COMPLETED':
      return _$transactionStatusResponseStatusEnum_COMPLETED;
    case 'FAILED':
      return _$transactionStatusResponseStatusEnum_FAILED;
    case 'COMPENSATING':
      return _$transactionStatusResponseStatusEnum_COMPENSATING;
    case 'UNKNOWN':
      return _$transactionStatusResponseStatusEnum_UNKNOWN;
    default:
      throw ArgumentError(name);
  }
}

final BuiltSet<TransactionStatusResponseStatusEnum>
    _$transactionStatusResponseStatusEnumValues = BuiltSet<
        TransactionStatusResponseStatusEnum>(const <TransactionStatusResponseStatusEnum>[
  _$transactionStatusResponseStatusEnum_PENDING,
  _$transactionStatusResponseStatusEnum_RUNNING,
  _$transactionStatusResponseStatusEnum_COMPLETED,
  _$transactionStatusResponseStatusEnum_FAILED,
  _$transactionStatusResponseStatusEnum_COMPENSATING,
  _$transactionStatusResponseStatusEnum_UNKNOWN,
]);

const TransactionStatusResponseActionCodeEnum
    _$transactionStatusResponseActionCodeEnum_DECLINE =
    const TransactionStatusResponseActionCodeEnum._('DECLINE');
const TransactionStatusResponseActionCodeEnum
    _$transactionStatusResponseActionCodeEnum_RETRY =
    const TransactionStatusResponseActionCodeEnum._('RETRY');
const TransactionStatusResponseActionCodeEnum
    _$transactionStatusResponseActionCodeEnum_REVIEW =
    const TransactionStatusResponseActionCodeEnum._('REVIEW');

TransactionStatusResponseActionCodeEnum
    _$transactionStatusResponseActionCodeEnumValueOf(String name) {
  switch (name) {
    case 'DECLINE':
      return _$transactionStatusResponseActionCodeEnum_DECLINE;
    case 'RETRY':
      return _$transactionStatusResponseActionCodeEnum_RETRY;
    case 'REVIEW':
      return _$transactionStatusResponseActionCodeEnum_REVIEW;
    default:
      throw ArgumentError(name);
  }
}

final BuiltSet<TransactionStatusResponseActionCodeEnum>
    _$transactionStatusResponseActionCodeEnumValues = BuiltSet<
        TransactionStatusResponseActionCodeEnum>(const <TransactionStatusResponseActionCodeEnum>[
  _$transactionStatusResponseActionCodeEnum_DECLINE,
  _$transactionStatusResponseActionCodeEnum_RETRY,
  _$transactionStatusResponseActionCodeEnum_REVIEW,
]);

Serializer<TransactionStatusResponseStatusEnum>
    _$transactionStatusResponseStatusEnumSerializer =
    _$TransactionStatusResponseStatusEnumSerializer();
Serializer<TransactionStatusResponseActionCodeEnum>
    _$transactionStatusResponseActionCodeEnumSerializer =
    _$TransactionStatusResponseActionCodeEnumSerializer();

class _$TransactionStatusResponseStatusEnumSerializer
    implements PrimitiveSerializer<TransactionStatusResponseStatusEnum> {
  static const Map<String, Object> _toWire = const <String, Object>{
    'PENDING': 'PENDING',
    'RUNNING': 'RUNNING',
    'COMPLETED': 'COMPLETED',
    'FAILED': 'FAILED',
    'COMPENSATING': 'COMPENSATING',
    'UNKNOWN': 'UNKNOWN',
  };
  static const Map<Object, String> _fromWire = const <Object, String>{
    'PENDING': 'PENDING',
    'RUNNING': 'RUNNING',
    'COMPLETED': 'COMPLETED',
    'FAILED': 'FAILED',
    'COMPENSATING': 'COMPENSATING',
    'UNKNOWN': 'UNKNOWN',
  };

  @override
  final Iterable<Type> types = const <Type>[
    TransactionStatusResponseStatusEnum
  ];
  @override
  final String wireName = 'TransactionStatusResponseStatusEnum';

  @override
  Object serialize(
          Serializers serializers, TransactionStatusResponseStatusEnum object,
          {FullType specifiedType = FullType.unspecified}) =>
      _toWire[object.name] ?? object.name;

  @override
  TransactionStatusResponseStatusEnum deserialize(
          Serializers serializers, Object serialized,
          {FullType specifiedType = FullType.unspecified}) =>
      TransactionStatusResponseStatusEnum.valueOf(
          _fromWire[serialized] ?? (serialized is String ? serialized : ''));
}

class _$TransactionStatusResponseActionCodeEnumSerializer
    implements PrimitiveSerializer<TransactionStatusResponseActionCodeEnum> {
  static const Map<String, Object> _toWire = const <String, Object>{
    'DECLINE': 'DECLINE',
    'RETRY': 'RETRY',
    'REVIEW': 'REVIEW',
  };
  static const Map<Object, String> _fromWire = const <Object, String>{
    'DECLINE': 'DECLINE',
    'RETRY': 'RETRY',
    'REVIEW': 'REVIEW',
  };

  @override
  final Iterable<Type> types = const <Type>[
    TransactionStatusResponseActionCodeEnum
  ];
  @override
  final String wireName = 'TransactionStatusResponseActionCodeEnum';

  @override
  Object serialize(Serializers serializers,
          TransactionStatusResponseActionCodeEnum object,
          {FullType specifiedType = FullType.unspecified}) =>
      _toWire[object.name] ?? object.name;

  @override
  TransactionStatusResponseActionCodeEnum deserialize(
          Serializers serializers, Object serialized,
          {FullType specifiedType = FullType.unspecified}) =>
      TransactionStatusResponseActionCodeEnum.valueOf(
          _fromWire[serialized] ?? (serialized is String ? serialized : ''));
}

class _$TransactionStatusResponse extends TransactionStatusResponse {
  @override
  final TransactionStatusResponseStatusEnum? status;
  @override
  final String? workflowId;
  @override
  final String? transactionType;
  @override
  final double? amount;
  @override
  final double? customerFee;
  @override
  final String? referenceNumber;
  @override
  final String? errorCode;
  @override
  final String? errorMessage;
  @override
  final TransactionStatusResponseActionCodeEnum? actionCode;
  @override
  final DateTime? completedAt;

  factory _$TransactionStatusResponse(
          [void Function(TransactionStatusResponseBuilder)? updates]) =>
      (TransactionStatusResponseBuilder()..update(updates))._build();

  _$TransactionStatusResponse._(
      {this.status,
      this.workflowId,
      this.transactionType,
      this.amount,
      this.customerFee,
      this.referenceNumber,
      this.errorCode,
      this.errorMessage,
      this.actionCode,
      this.completedAt})
      : super._();
  @override
  TransactionStatusResponse rebuild(
          void Function(TransactionStatusResponseBuilder) updates) =>
      (toBuilder()..update(updates)).build();

  @override
  TransactionStatusResponseBuilder toBuilder() =>
      TransactionStatusResponseBuilder()..replace(this);

  @override
  bool operator ==(Object other) {
    if (identical(other, this)) return true;
    return other is TransactionStatusResponse &&
        status == other.status &&
        workflowId == other.workflowId &&
        transactionType == other.transactionType &&
        amount == other.amount &&
        customerFee == other.customerFee &&
        referenceNumber == other.referenceNumber &&
        errorCode == other.errorCode &&
        errorMessage == other.errorMessage &&
        actionCode == other.actionCode &&
        completedAt == other.completedAt;
  }

  @override
  int get hashCode {
    var _$hash = 0;
    _$hash = $jc(_$hash, status.hashCode);
    _$hash = $jc(_$hash, workflowId.hashCode);
    _$hash = $jc(_$hash, transactionType.hashCode);
    _$hash = $jc(_$hash, amount.hashCode);
    _$hash = $jc(_$hash, customerFee.hashCode);
    _$hash = $jc(_$hash, referenceNumber.hashCode);
    _$hash = $jc(_$hash, errorCode.hashCode);
    _$hash = $jc(_$hash, errorMessage.hashCode);
    _$hash = $jc(_$hash, actionCode.hashCode);
    _$hash = $jc(_$hash, completedAt.hashCode);
    _$hash = $jf(_$hash);
    return _$hash;
  }

  @override
  String toString() {
    return (newBuiltValueToStringHelper(r'TransactionStatusResponse')
          ..add('status', status)
          ..add('workflowId', workflowId)
          ..add('transactionType', transactionType)
          ..add('amount', amount)
          ..add('customerFee', customerFee)
          ..add('referenceNumber', referenceNumber)
          ..add('errorCode', errorCode)
          ..add('errorMessage', errorMessage)
          ..add('actionCode', actionCode)
          ..add('completedAt', completedAt))
        .toString();
  }
}

class TransactionStatusResponseBuilder
    implements
        Builder<TransactionStatusResponse, TransactionStatusResponseBuilder> {
  _$TransactionStatusResponse? _$v;

  TransactionStatusResponseStatusEnum? _status;
  TransactionStatusResponseStatusEnum? get status => _$this._status;
  set status(TransactionStatusResponseStatusEnum? status) =>
      _$this._status = status;

  String? _workflowId;
  String? get workflowId => _$this._workflowId;
  set workflowId(String? workflowId) => _$this._workflowId = workflowId;

  String? _transactionType;
  String? get transactionType => _$this._transactionType;
  set transactionType(String? transactionType) =>
      _$this._transactionType = transactionType;

  double? _amount;
  double? get amount => _$this._amount;
  set amount(double? amount) => _$this._amount = amount;

  double? _customerFee;
  double? get customerFee => _$this._customerFee;
  set customerFee(double? customerFee) => _$this._customerFee = customerFee;

  String? _referenceNumber;
  String? get referenceNumber => _$this._referenceNumber;
  set referenceNumber(String? referenceNumber) =>
      _$this._referenceNumber = referenceNumber;

  String? _errorCode;
  String? get errorCode => _$this._errorCode;
  set errorCode(String? errorCode) => _$this._errorCode = errorCode;

  String? _errorMessage;
  String? get errorMessage => _$this._errorMessage;
  set errorMessage(String? errorMessage) => _$this._errorMessage = errorMessage;

  TransactionStatusResponseActionCodeEnum? _actionCode;
  TransactionStatusResponseActionCodeEnum? get actionCode => _$this._actionCode;
  set actionCode(TransactionStatusResponseActionCodeEnum? actionCode) =>
      _$this._actionCode = actionCode;

  DateTime? _completedAt;
  DateTime? get completedAt => _$this._completedAt;
  set completedAt(DateTime? completedAt) => _$this._completedAt = completedAt;

  TransactionStatusResponseBuilder() {
    TransactionStatusResponse._defaults(this);
  }

  TransactionStatusResponseBuilder get _$this {
    final $v = _$v;
    if ($v != null) {
      _status = $v.status;
      _workflowId = $v.workflowId;
      _transactionType = $v.transactionType;
      _amount = $v.amount;
      _customerFee = $v.customerFee;
      _referenceNumber = $v.referenceNumber;
      _errorCode = $v.errorCode;
      _errorMessage = $v.errorMessage;
      _actionCode = $v.actionCode;
      _completedAt = $v.completedAt;
      _$v = null;
    }
    return this;
  }

  @override
  void replace(TransactionStatusResponse other) {
    _$v = other as _$TransactionStatusResponse;
  }

  @override
  void update(void Function(TransactionStatusResponseBuilder)? updates) {
    if (updates != null) updates(this);
  }

  @override
  TransactionStatusResponse build() => _build();

  _$TransactionStatusResponse _build() {
    final _$result = _$v ??
        _$TransactionStatusResponse._(
          status: status,
          workflowId: workflowId,
          transactionType: transactionType,
          amount: amount,
          customerFee: customerFee,
          referenceNumber: referenceNumber,
          errorCode: errorCode,
          errorMessage: errorMessage,
          actionCode: actionCode,
          completedAt: completedAt,
        );
    replace(_$result);
    return _$result;
  }
}

// ignore_for_file: deprecated_member_use_from_same_package,type=lint
