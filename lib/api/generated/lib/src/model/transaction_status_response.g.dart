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
  @override
  final String? agentTier;
  @override
  final String? billerCode;
  @override
  final String? customerCardMasked;
  @override
  final String? destinationAccount;
  @override
  final JsonObject? errorDetails;
  @override
  final double? geofenceLat;
  @override
  final double? geofenceLng;
  @override
  final String? pendingReason;
  @override
  final String? ref1;
  @override
  final String? ref2;
  @override
  final String? targetBin;

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
      this.completedAt,
      this.agentTier,
      this.billerCode,
      this.customerCardMasked,
      this.destinationAccount,
      this.errorDetails,
      this.geofenceLat,
      this.geofenceLng,
      this.pendingReason,
      this.ref1,
      this.ref2,
      this.targetBin})
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
        completedAt == other.completedAt &&
        agentTier == other.agentTier &&
        billerCode == other.billerCode &&
        customerCardMasked == other.customerCardMasked &&
        destinationAccount == other.destinationAccount &&
        errorDetails == other.errorDetails &&
        geofenceLat == other.geofenceLat &&
        geofenceLng == other.geofenceLng &&
        pendingReason == other.pendingReason &&
        ref1 == other.ref1 &&
        ref2 == other.ref2 &&
        targetBin == other.targetBin;
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
    _$hash = $jc(_$hash, agentTier.hashCode);
    _$hash = $jc(_$hash, billerCode.hashCode);
    _$hash = $jc(_$hash, customerCardMasked.hashCode);
    _$hash = $jc(_$hash, destinationAccount.hashCode);
    _$hash = $jc(_$hash, errorDetails.hashCode);
    _$hash = $jc(_$hash, geofenceLat.hashCode);
    _$hash = $jc(_$hash, geofenceLng.hashCode);
    _$hash = $jc(_$hash, pendingReason.hashCode);
    _$hash = $jc(_$hash, ref1.hashCode);
    _$hash = $jc(_$hash, ref2.hashCode);
    _$hash = $jc(_$hash, targetBin.hashCode);
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
          ..add('completedAt', completedAt)
          ..add('agentTier', agentTier)
          ..add('billerCode', billerCode)
          ..add('customerCardMasked', customerCardMasked)
          ..add('destinationAccount', destinationAccount)
          ..add('errorDetails', errorDetails)
          ..add('geofenceLat', geofenceLat)
          ..add('geofenceLng', geofenceLng)
          ..add('pendingReason', pendingReason)
          ..add('ref1', ref1)
          ..add('ref2', ref2)
          ..add('targetBin', targetBin))
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

  String? _agentTier;
  String? get agentTier => _$this._agentTier;
  set agentTier(String? agentTier) => _$this._agentTier = agentTier;

  String? _billerCode;
  String? get billerCode => _$this._billerCode;
  set billerCode(String? billerCode) => _$this._billerCode = billerCode;

  String? _customerCardMasked;
  String? get customerCardMasked => _$this._customerCardMasked;
  set customerCardMasked(String? customerCardMasked) =>
      _$this._customerCardMasked = customerCardMasked;

  String? _destinationAccount;
  String? get destinationAccount => _$this._destinationAccount;
  set destinationAccount(String? destinationAccount) =>
      _$this._destinationAccount = destinationAccount;

  JsonObject? _errorDetails;
  JsonObject? get errorDetails => _$this._errorDetails;
  set errorDetails(JsonObject? errorDetails) =>
      _$this._errorDetails = errorDetails;

  double? _geofenceLat;
  double? get geofenceLat => _$this._geofenceLat;
  set geofenceLat(double? geofenceLat) => _$this._geofenceLat = geofenceLat;

  double? _geofenceLng;
  double? get geofenceLng => _$this._geofenceLng;
  set geofenceLng(double? geofenceLng) => _$this._geofenceLng = geofenceLng;

  String? _pendingReason;
  String? get pendingReason => _$this._pendingReason;
  set pendingReason(String? pendingReason) =>
      _$this._pendingReason = pendingReason;

  String? _ref1;
  String? get ref1 => _$this._ref1;
  set ref1(String? ref1) => _$this._ref1 = ref1;

  String? _ref2;
  String? get ref2 => _$this._ref2;
  set ref2(String? ref2) => _$this._ref2 = ref2;

  String? _targetBin;
  String? get targetBin => _$this._targetBin;
  set targetBin(String? targetBin) => _$this._targetBin = targetBin;

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
      _agentTier = $v.agentTier;
      _billerCode = $v.billerCode;
      _customerCardMasked = $v.customerCardMasked;
      _destinationAccount = $v.destinationAccount;
      _errorDetails = $v.errorDetails;
      _geofenceLat = $v.geofenceLat;
      _geofenceLng = $v.geofenceLng;
      _pendingReason = $v.pendingReason;
      _ref1 = $v.ref1;
      _ref2 = $v.ref2;
      _targetBin = $v.targetBin;
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
          agentTier: agentTier,
          billerCode: billerCode,
          customerCardMasked: customerCardMasked,
          destinationAccount: destinationAccount,
          errorDetails: errorDetails,
          geofenceLat: geofenceLat,
          geofenceLng: geofenceLng,
          pendingReason: pendingReason,
          ref1: ref1,
          ref2: ref2,
          targetBin: targetBin,
        );
    replace(_$result);
    return _$result;
  }
}

// ignore_for_file: deprecated_member_use_from_same_package,type=lint
