// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'discrepancy_maker_action_request.dart';

// **************************************************************************
// BuiltValueGenerator
// **************************************************************************

const DiscrepancyMakerActionRequestActionEnum
    _$discrepancyMakerActionRequestActionEnum_PROPOSE =
    const DiscrepancyMakerActionRequestActionEnum._('PROPOSE');
const DiscrepancyMakerActionRequestActionEnum
    _$discrepancyMakerActionRequestActionEnum_ESCALATE =
    const DiscrepancyMakerActionRequestActionEnum._('ESCALATE');

DiscrepancyMakerActionRequestActionEnum
    _$discrepancyMakerActionRequestActionEnumValueOf(String name) {
  switch (name) {
    case 'PROPOSE':
      return _$discrepancyMakerActionRequestActionEnum_PROPOSE;
    case 'ESCALATE':
      return _$discrepancyMakerActionRequestActionEnum_ESCALATE;
    default:
      throw ArgumentError(name);
  }
}

final BuiltSet<DiscrepancyMakerActionRequestActionEnum>
    _$discrepancyMakerActionRequestActionEnumValues = BuiltSet<
        DiscrepancyMakerActionRequestActionEnum>(const <DiscrepancyMakerActionRequestActionEnum>[
  _$discrepancyMakerActionRequestActionEnum_PROPOSE,
  _$discrepancyMakerActionRequestActionEnum_ESCALATE,
]);

Serializer<DiscrepancyMakerActionRequestActionEnum>
    _$discrepancyMakerActionRequestActionEnumSerializer =
    _$DiscrepancyMakerActionRequestActionEnumSerializer();

class _$DiscrepancyMakerActionRequestActionEnumSerializer
    implements PrimitiveSerializer<DiscrepancyMakerActionRequestActionEnum> {
  static const Map<String, Object> _toWire = const <String, Object>{
    'PROPOSE': 'PROPOSE',
    'ESCALATE': 'ESCALATE',
  };
  static const Map<Object, String> _fromWire = const <Object, String>{
    'PROPOSE': 'PROPOSE',
    'ESCALATE': 'ESCALATE',
  };

  @override
  final Iterable<Type> types = const <Type>[
    DiscrepancyMakerActionRequestActionEnum
  ];
  @override
  final String wireName = 'DiscrepancyMakerActionRequestActionEnum';

  @override
  Object serialize(Serializers serializers,
          DiscrepancyMakerActionRequestActionEnum object,
          {FullType specifiedType = FullType.unspecified}) =>
      _toWire[object.name] ?? object.name;

  @override
  DiscrepancyMakerActionRequestActionEnum deserialize(
          Serializers serializers, Object serialized,
          {FullType specifiedType = FullType.unspecified}) =>
      DiscrepancyMakerActionRequestActionEnum.valueOf(
          _fromWire[serialized] ?? (serialized is String ? serialized : ''));
}

class _$DiscrepancyMakerActionRequest extends DiscrepancyMakerActionRequest {
  @override
  final DiscrepancyMakerActionRequestActionEnum action;
  @override
  final String notes;
  @override
  final String? adjustmentAmount;

  factory _$DiscrepancyMakerActionRequest(
          [void Function(DiscrepancyMakerActionRequestBuilder)? updates]) =>
      (DiscrepancyMakerActionRequestBuilder()..update(updates))._build();

  _$DiscrepancyMakerActionRequest._(
      {required this.action, required this.notes, this.adjustmentAmount})
      : super._();
  @override
  DiscrepancyMakerActionRequest rebuild(
          void Function(DiscrepancyMakerActionRequestBuilder) updates) =>
      (toBuilder()..update(updates)).build();

  @override
  DiscrepancyMakerActionRequestBuilder toBuilder() =>
      DiscrepancyMakerActionRequestBuilder()..replace(this);

  @override
  bool operator ==(Object other) {
    if (identical(other, this)) return true;
    return other is DiscrepancyMakerActionRequest &&
        action == other.action &&
        notes == other.notes &&
        adjustmentAmount == other.adjustmentAmount;
  }

  @override
  int get hashCode {
    var _$hash = 0;
    _$hash = $jc(_$hash, action.hashCode);
    _$hash = $jc(_$hash, notes.hashCode);
    _$hash = $jc(_$hash, adjustmentAmount.hashCode);
    _$hash = $jf(_$hash);
    return _$hash;
  }

  @override
  String toString() {
    return (newBuiltValueToStringHelper(r'DiscrepancyMakerActionRequest')
          ..add('action', action)
          ..add('notes', notes)
          ..add('adjustmentAmount', adjustmentAmount))
        .toString();
  }
}

class DiscrepancyMakerActionRequestBuilder
    implements
        Builder<DiscrepancyMakerActionRequest,
            DiscrepancyMakerActionRequestBuilder> {
  _$DiscrepancyMakerActionRequest? _$v;

  DiscrepancyMakerActionRequestActionEnum? _action;
  DiscrepancyMakerActionRequestActionEnum? get action => _$this._action;
  set action(DiscrepancyMakerActionRequestActionEnum? action) =>
      _$this._action = action;

  String? _notes;
  String? get notes => _$this._notes;
  set notes(String? notes) => _$this._notes = notes;

  String? _adjustmentAmount;
  String? get adjustmentAmount => _$this._adjustmentAmount;
  set adjustmentAmount(String? adjustmentAmount) =>
      _$this._adjustmentAmount = adjustmentAmount;

  DiscrepancyMakerActionRequestBuilder() {
    DiscrepancyMakerActionRequest._defaults(this);
  }

  DiscrepancyMakerActionRequestBuilder get _$this {
    final $v = _$v;
    if ($v != null) {
      _action = $v.action;
      _notes = $v.notes;
      _adjustmentAmount = $v.adjustmentAmount;
      _$v = null;
    }
    return this;
  }

  @override
  void replace(DiscrepancyMakerActionRequest other) {
    _$v = other as _$DiscrepancyMakerActionRequest;
  }

  @override
  void update(void Function(DiscrepancyMakerActionRequestBuilder)? updates) {
    if (updates != null) updates(this);
  }

  @override
  DiscrepancyMakerActionRequest build() => _build();

  _$DiscrepancyMakerActionRequest _build() {
    final _$result = _$v ??
        _$DiscrepancyMakerActionRequest._(
          action: BuiltValueNullFieldError.checkNotNull(
              action, r'DiscrepancyMakerActionRequest', 'action'),
          notes: BuiltValueNullFieldError.checkNotNull(
              notes, r'DiscrepancyMakerActionRequest', 'notes'),
          adjustmentAmount: adjustmentAmount,
        );
    replace(_$result);
    return _$result;
  }
}

// ignore_for_file: deprecated_member_use_from_same_package,type=lint
