// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'discrepancy_checker_action_request.dart';

// **************************************************************************
// BuiltValueGenerator
// **************************************************************************

const DiscrepancyCheckerActionRequestActionEnum
    _$discrepancyCheckerActionRequestActionEnum_APPROVE =
    const DiscrepancyCheckerActionRequestActionEnum._('APPROVE');
const DiscrepancyCheckerActionRequestActionEnum
    _$discrepancyCheckerActionRequestActionEnum_REJECT =
    const DiscrepancyCheckerActionRequestActionEnum._('REJECT');

DiscrepancyCheckerActionRequestActionEnum
    _$discrepancyCheckerActionRequestActionEnumValueOf(String name) {
  switch (name) {
    case 'APPROVE':
      return _$discrepancyCheckerActionRequestActionEnum_APPROVE;
    case 'REJECT':
      return _$discrepancyCheckerActionRequestActionEnum_REJECT;
    default:
      throw ArgumentError(name);
  }
}

final BuiltSet<DiscrepancyCheckerActionRequestActionEnum>
    _$discrepancyCheckerActionRequestActionEnumValues = BuiltSet<
        DiscrepancyCheckerActionRequestActionEnum>(const <DiscrepancyCheckerActionRequestActionEnum>[
  _$discrepancyCheckerActionRequestActionEnum_APPROVE,
  _$discrepancyCheckerActionRequestActionEnum_REJECT,
]);

Serializer<DiscrepancyCheckerActionRequestActionEnum>
    _$discrepancyCheckerActionRequestActionEnumSerializer =
    _$DiscrepancyCheckerActionRequestActionEnumSerializer();

class _$DiscrepancyCheckerActionRequestActionEnumSerializer
    implements PrimitiveSerializer<DiscrepancyCheckerActionRequestActionEnum> {
  static const Map<String, Object> _toWire = const <String, Object>{
    'APPROVE': 'APPROVE',
    'REJECT': 'REJECT',
  };
  static const Map<Object, String> _fromWire = const <Object, String>{
    'APPROVE': 'APPROVE',
    'REJECT': 'REJECT',
  };

  @override
  final Iterable<Type> types = const <Type>[
    DiscrepancyCheckerActionRequestActionEnum
  ];
  @override
  final String wireName = 'DiscrepancyCheckerActionRequestActionEnum';

  @override
  Object serialize(Serializers serializers,
          DiscrepancyCheckerActionRequestActionEnum object,
          {FullType specifiedType = FullType.unspecified}) =>
      _toWire[object.name] ?? object.name;

  @override
  DiscrepancyCheckerActionRequestActionEnum deserialize(
          Serializers serializers, Object serialized,
          {FullType specifiedType = FullType.unspecified}) =>
      DiscrepancyCheckerActionRequestActionEnum.valueOf(
          _fromWire[serialized] ?? (serialized is String ? serialized : ''));
}

class _$DiscrepancyCheckerActionRequest
    extends DiscrepancyCheckerActionRequest {
  @override
  final DiscrepancyCheckerActionRequestActionEnum action;
  @override
  final String notes;

  factory _$DiscrepancyCheckerActionRequest(
          [void Function(DiscrepancyCheckerActionRequestBuilder)? updates]) =>
      (DiscrepancyCheckerActionRequestBuilder()..update(updates))._build();

  _$DiscrepancyCheckerActionRequest._(
      {required this.action, required this.notes})
      : super._();
  @override
  DiscrepancyCheckerActionRequest rebuild(
          void Function(DiscrepancyCheckerActionRequestBuilder) updates) =>
      (toBuilder()..update(updates)).build();

  @override
  DiscrepancyCheckerActionRequestBuilder toBuilder() =>
      DiscrepancyCheckerActionRequestBuilder()..replace(this);

  @override
  bool operator ==(Object other) {
    if (identical(other, this)) return true;
    return other is DiscrepancyCheckerActionRequest &&
        action == other.action &&
        notes == other.notes;
  }

  @override
  int get hashCode {
    var _$hash = 0;
    _$hash = $jc(_$hash, action.hashCode);
    _$hash = $jc(_$hash, notes.hashCode);
    _$hash = $jf(_$hash);
    return _$hash;
  }

  @override
  String toString() {
    return (newBuiltValueToStringHelper(r'DiscrepancyCheckerActionRequest')
          ..add('action', action)
          ..add('notes', notes))
        .toString();
  }
}

class DiscrepancyCheckerActionRequestBuilder
    implements
        Builder<DiscrepancyCheckerActionRequest,
            DiscrepancyCheckerActionRequestBuilder> {
  _$DiscrepancyCheckerActionRequest? _$v;

  DiscrepancyCheckerActionRequestActionEnum? _action;
  DiscrepancyCheckerActionRequestActionEnum? get action => _$this._action;
  set action(DiscrepancyCheckerActionRequestActionEnum? action) =>
      _$this._action = action;

  String? _notes;
  String? get notes => _$this._notes;
  set notes(String? notes) => _$this._notes = notes;

  DiscrepancyCheckerActionRequestBuilder() {
    DiscrepancyCheckerActionRequest._defaults(this);
  }

  DiscrepancyCheckerActionRequestBuilder get _$this {
    final $v = _$v;
    if ($v != null) {
      _action = $v.action;
      _notes = $v.notes;
      _$v = null;
    }
    return this;
  }

  @override
  void replace(DiscrepancyCheckerActionRequest other) {
    _$v = other as _$DiscrepancyCheckerActionRequest;
  }

  @override
  void update(void Function(DiscrepancyCheckerActionRequestBuilder)? updates) {
    if (updates != null) updates(this);
  }

  @override
  DiscrepancyCheckerActionRequest build() => _build();

  _$DiscrepancyCheckerActionRequest _build() {
    final _$result = _$v ??
        _$DiscrepancyCheckerActionRequest._(
          action: BuiltValueNullFieldError.checkNotNull(
              action, r'DiscrepancyCheckerActionRequest', 'action'),
          notes: BuiltValueNullFieldError.checkNotNull(
              notes, r'DiscrepancyCheckerActionRequest', 'notes'),
        );
    replace(_$result);
    return _$result;
  }
}

// ignore_for_file: deprecated_member_use_from_same_package,type=lint
