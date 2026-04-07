// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'transaction_start_response.dart';

// **************************************************************************
// BuiltValueGenerator
// **************************************************************************

const TransactionStartResponseStatusEnum
    _$transactionStartResponseStatusEnum_PENDING =
    const TransactionStartResponseStatusEnum._('PENDING');

TransactionStartResponseStatusEnum _$transactionStartResponseStatusEnumValueOf(
    String name) {
  switch (name) {
    case 'PENDING':
      return _$transactionStartResponseStatusEnum_PENDING;
    default:
      throw ArgumentError(name);
  }
}

final BuiltSet<TransactionStartResponseStatusEnum>
    _$transactionStartResponseStatusEnumValues = BuiltSet<
        TransactionStartResponseStatusEnum>(const <TransactionStartResponseStatusEnum>[
  _$transactionStartResponseStatusEnum_PENDING,
]);

Serializer<TransactionStartResponseStatusEnum>
    _$transactionStartResponseStatusEnumSerializer =
    _$TransactionStartResponseStatusEnumSerializer();

class _$TransactionStartResponseStatusEnumSerializer
    implements PrimitiveSerializer<TransactionStartResponseStatusEnum> {
  static const Map<String, Object> _toWire = const <String, Object>{
    'PENDING': 'PENDING',
  };
  static const Map<Object, String> _fromWire = const <Object, String>{
    'PENDING': 'PENDING',
  };

  @override
  final Iterable<Type> types = const <Type>[TransactionStartResponseStatusEnum];
  @override
  final String wireName = 'TransactionStartResponseStatusEnum';

  @override
  Object serialize(
          Serializers serializers, TransactionStartResponseStatusEnum object,
          {FullType specifiedType = FullType.unspecified}) =>
      _toWire[object.name] ?? object.name;

  @override
  TransactionStartResponseStatusEnum deserialize(
          Serializers serializers, Object serialized,
          {FullType specifiedType = FullType.unspecified}) =>
      TransactionStartResponseStatusEnum.valueOf(
          _fromWire[serialized] ?? (serialized is String ? serialized : ''));
}

class _$TransactionStartResponse extends TransactionStartResponse {
  @override
  final TransactionStartResponseStatusEnum? status;
  @override
  final String? workflowId;
  @override
  final String? pollUrl;

  factory _$TransactionStartResponse(
          [void Function(TransactionStartResponseBuilder)? updates]) =>
      (TransactionStartResponseBuilder()..update(updates))._build();

  _$TransactionStartResponse._({this.status, this.workflowId, this.pollUrl})
      : super._();
  @override
  TransactionStartResponse rebuild(
          void Function(TransactionStartResponseBuilder) updates) =>
      (toBuilder()..update(updates)).build();

  @override
  TransactionStartResponseBuilder toBuilder() =>
      TransactionStartResponseBuilder()..replace(this);

  @override
  bool operator ==(Object other) {
    if (identical(other, this)) return true;
    return other is TransactionStartResponse &&
        status == other.status &&
        workflowId == other.workflowId &&
        pollUrl == other.pollUrl;
  }

  @override
  int get hashCode {
    var _$hash = 0;
    _$hash = $jc(_$hash, status.hashCode);
    _$hash = $jc(_$hash, workflowId.hashCode);
    _$hash = $jc(_$hash, pollUrl.hashCode);
    _$hash = $jf(_$hash);
    return _$hash;
  }

  @override
  String toString() {
    return (newBuiltValueToStringHelper(r'TransactionStartResponse')
          ..add('status', status)
          ..add('workflowId', workflowId)
          ..add('pollUrl', pollUrl))
        .toString();
  }
}

class TransactionStartResponseBuilder
    implements
        Builder<TransactionStartResponse, TransactionStartResponseBuilder> {
  _$TransactionStartResponse? _$v;

  TransactionStartResponseStatusEnum? _status;
  TransactionStartResponseStatusEnum? get status => _$this._status;
  set status(TransactionStartResponseStatusEnum? status) =>
      _$this._status = status;

  String? _workflowId;
  String? get workflowId => _$this._workflowId;
  set workflowId(String? workflowId) => _$this._workflowId = workflowId;

  String? _pollUrl;
  String? get pollUrl => _$this._pollUrl;
  set pollUrl(String? pollUrl) => _$this._pollUrl = pollUrl;

  TransactionStartResponseBuilder() {
    TransactionStartResponse._defaults(this);
  }

  TransactionStartResponseBuilder get _$this {
    final $v = _$v;
    if ($v != null) {
      _status = $v.status;
      _workflowId = $v.workflowId;
      _pollUrl = $v.pollUrl;
      _$v = null;
    }
    return this;
  }

  @override
  void replace(TransactionStartResponse other) {
    _$v = other as _$TransactionStartResponse;
  }

  @override
  void update(void Function(TransactionStartResponseBuilder)? updates) {
    if (updates != null) updates(this);
  }

  @override
  TransactionStartResponse build() => _build();

  _$TransactionStartResponse _build() {
    final _$result = _$v ??
        _$TransactionStartResponse._(
          status: status,
          workflowId: workflowId,
          pollUrl: pollUrl,
        );
    replace(_$result);
    return _$result;
  }
}

// ignore_for_file: deprecated_member_use_from_same_package,type=lint
