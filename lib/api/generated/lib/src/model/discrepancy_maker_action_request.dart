//
// AUTO-GENERATED FILE, DO NOT MODIFY!
//

// ignore_for_file: unused_element
import 'package:built_collection/built_collection.dart';
import 'package:built_value/built_value.dart';
import 'package:built_value/serializer.dart';

part 'discrepancy_maker_action_request.g.dart';

/// DiscrepancyMakerActionRequest
///
/// Properties:
/// * [action] 
/// * [notes] 
/// * [adjustmentAmount] 
@BuiltValue()
abstract class DiscrepancyMakerActionRequest implements Built<DiscrepancyMakerActionRequest, DiscrepancyMakerActionRequestBuilder> {
  @BuiltValueField(wireName: r'action')
  DiscrepancyMakerActionRequestActionEnum get action;
  // enum actionEnum {  PROPOSE,  ESCALATE,  };

  @BuiltValueField(wireName: r'notes')
  String get notes;

  @BuiltValueField(wireName: r'adjustmentAmount')
  num? get adjustmentAmount;

  DiscrepancyMakerActionRequest._();

  factory DiscrepancyMakerActionRequest([void updates(DiscrepancyMakerActionRequestBuilder b)]) = _$DiscrepancyMakerActionRequest;

  @BuiltValueHook(initializeBuilder: true)
  static void _defaults(DiscrepancyMakerActionRequestBuilder b) => b;

  @BuiltValueSerializer(custom: true)
  static Serializer<DiscrepancyMakerActionRequest> get serializer => _$DiscrepancyMakerActionRequestSerializer();
}

class _$DiscrepancyMakerActionRequestSerializer implements PrimitiveSerializer<DiscrepancyMakerActionRequest> {
  @override
  final Iterable<Type> types = const [DiscrepancyMakerActionRequest, _$DiscrepancyMakerActionRequest];

  @override
  final String wireName = r'DiscrepancyMakerActionRequest';

  Iterable<Object?> _serializeProperties(
    Serializers serializers,
    DiscrepancyMakerActionRequest object, {
    FullType specifiedType = FullType.unspecified,
  }) sync* {
    yield r'action';
    yield serializers.serialize(
      object.action,
      specifiedType: const FullType(DiscrepancyMakerActionRequestActionEnum),
    );
    yield r'notes';
    yield serializers.serialize(
      object.notes,
      specifiedType: const FullType(String),
    );
    if (object.adjustmentAmount != null) {
      yield r'adjustmentAmount';
      yield serializers.serialize(
        object.adjustmentAmount,
        specifiedType: const FullType(num),
      );
    }
  }

  @override
  Object serialize(
    Serializers serializers,
    DiscrepancyMakerActionRequest object, {
    FullType specifiedType = FullType.unspecified,
  }) {
    return _serializeProperties(serializers, object, specifiedType: specifiedType).toList();
  }

  void _deserializeProperties(
    Serializers serializers,
    Object serialized, {
    FullType specifiedType = FullType.unspecified,
    required List<Object?> serializedList,
    required DiscrepancyMakerActionRequestBuilder result,
    required List<Object?> unhandled,
  }) {
    for (var i = 0; i < serializedList.length; i += 2) {
      final key = serializedList[i] as String;
      final value = serializedList[i + 1];
      switch (key) {
        case r'action':
          final valueDes = serializers.deserialize(
            value,
            specifiedType: const FullType(DiscrepancyMakerActionRequestActionEnum),
          ) as DiscrepancyMakerActionRequestActionEnum;
          result.action = valueDes;
          break;
        case r'notes':
          final valueDes = serializers.deserialize(
            value,
            specifiedType: const FullType(String),
          ) as String;
          result.notes = valueDes;
          break;
        case r'adjustmentAmount':
          final valueDes = serializers.deserialize(
            value,
            specifiedType: const FullType(num),
          ) as num;
          result.adjustmentAmount = valueDes;
          break;
        default:
          unhandled.add(key);
          unhandled.add(value);
          break;
      }
    }
  }

  @override
  DiscrepancyMakerActionRequest deserialize(
    Serializers serializers,
    Object serialized, {
    FullType specifiedType = FullType.unspecified,
  }) {
    final result = DiscrepancyMakerActionRequestBuilder();
    final serializedList = (serialized as Iterable<Object?>).toList();
    final unhandled = <Object?>[];
    _deserializeProperties(
      serializers,
      serialized,
      specifiedType: specifiedType,
      serializedList: serializedList,
      unhandled: unhandled,
      result: result,
    );
    return result.build();
  }
}

class DiscrepancyMakerActionRequestActionEnum extends EnumClass {

  @BuiltValueEnumConst(wireName: r'PROPOSE')
  static const DiscrepancyMakerActionRequestActionEnum PROPOSE = _$discrepancyMakerActionRequestActionEnum_PROPOSE;
  @BuiltValueEnumConst(wireName: r'ESCALATE')
  static const DiscrepancyMakerActionRequestActionEnum ESCALATE = _$discrepancyMakerActionRequestActionEnum_ESCALATE;

  static Serializer<DiscrepancyMakerActionRequestActionEnum> get serializer => _$discrepancyMakerActionRequestActionEnumSerializer;

  const DiscrepancyMakerActionRequestActionEnum._(String name): super(name);

  static BuiltSet<DiscrepancyMakerActionRequestActionEnum> get values => _$discrepancyMakerActionRequestActionEnumValues;
  static DiscrepancyMakerActionRequestActionEnum valueOf(String name) => _$discrepancyMakerActionRequestActionEnumValueOf(name);
}

