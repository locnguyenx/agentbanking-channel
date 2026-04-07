//
// AUTO-GENERATED FILE, DO NOT MODIFY!
//

// ignore_for_file: unused_element
import 'package:built_collection/built_collection.dart';
import 'package:built_value/built_value.dart';
import 'package:built_value/serializer.dart';

part 'discrepancy_checker_action_request.g.dart';

/// DiscrepancyCheckerActionRequest
///
/// Properties:
/// * [action] 
/// * [notes] 
@BuiltValue()
abstract class DiscrepancyCheckerActionRequest implements Built<DiscrepancyCheckerActionRequest, DiscrepancyCheckerActionRequestBuilder> {
  @BuiltValueField(wireName: r'action')
  DiscrepancyCheckerActionRequestActionEnum get action;
  // enum actionEnum {  APPROVE,  REJECT,  };

  @BuiltValueField(wireName: r'notes')
  String get notes;

  DiscrepancyCheckerActionRequest._();

  factory DiscrepancyCheckerActionRequest([void updates(DiscrepancyCheckerActionRequestBuilder b)]) = _$DiscrepancyCheckerActionRequest;

  @BuiltValueHook(initializeBuilder: true)
  static void _defaults(DiscrepancyCheckerActionRequestBuilder b) => b;

  @BuiltValueSerializer(custom: true)
  static Serializer<DiscrepancyCheckerActionRequest> get serializer => _$DiscrepancyCheckerActionRequestSerializer();
}

class _$DiscrepancyCheckerActionRequestSerializer implements PrimitiveSerializer<DiscrepancyCheckerActionRequest> {
  @override
  final Iterable<Type> types = const [DiscrepancyCheckerActionRequest, _$DiscrepancyCheckerActionRequest];

  @override
  final String wireName = r'DiscrepancyCheckerActionRequest';

  Iterable<Object?> _serializeProperties(
    Serializers serializers,
    DiscrepancyCheckerActionRequest object, {
    FullType specifiedType = FullType.unspecified,
  }) sync* {
    yield r'action';
    yield serializers.serialize(
      object.action,
      specifiedType: const FullType(DiscrepancyCheckerActionRequestActionEnum),
    );
    yield r'notes';
    yield serializers.serialize(
      object.notes,
      specifiedType: const FullType(String),
    );
  }

  @override
  Object serialize(
    Serializers serializers,
    DiscrepancyCheckerActionRequest object, {
    FullType specifiedType = FullType.unspecified,
  }) {
    return _serializeProperties(serializers, object, specifiedType: specifiedType).toList();
  }

  void _deserializeProperties(
    Serializers serializers,
    Object serialized, {
    FullType specifiedType = FullType.unspecified,
    required List<Object?> serializedList,
    required DiscrepancyCheckerActionRequestBuilder result,
    required List<Object?> unhandled,
  }) {
    for (var i = 0; i < serializedList.length; i += 2) {
      final key = serializedList[i] as String;
      final value = serializedList[i + 1];
      switch (key) {
        case r'action':
          final valueDes = serializers.deserialize(
            value,
            specifiedType: const FullType(DiscrepancyCheckerActionRequestActionEnum),
          ) as DiscrepancyCheckerActionRequestActionEnum;
          result.action = valueDes;
          break;
        case r'notes':
          final valueDes = serializers.deserialize(
            value,
            specifiedType: const FullType(String),
          ) as String;
          result.notes = valueDes;
          break;
        default:
          unhandled.add(key);
          unhandled.add(value);
          break;
      }
    }
  }

  @override
  DiscrepancyCheckerActionRequest deserialize(
    Serializers serializers,
    Object serialized, {
    FullType specifiedType = FullType.unspecified,
  }) {
    final result = DiscrepancyCheckerActionRequestBuilder();
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

class DiscrepancyCheckerActionRequestActionEnum extends EnumClass {

  @BuiltValueEnumConst(wireName: r'APPROVE')
  static const DiscrepancyCheckerActionRequestActionEnum APPROVE = _$discrepancyCheckerActionRequestActionEnum_APPROVE;
  @BuiltValueEnumConst(wireName: r'REJECT')
  static const DiscrepancyCheckerActionRequestActionEnum REJECT = _$discrepancyCheckerActionRequestActionEnum_REJECT;

  static Serializer<DiscrepancyCheckerActionRequestActionEnum> get serializer => _$discrepancyCheckerActionRequestActionEnumSerializer;

  const DiscrepancyCheckerActionRequestActionEnum._(String name): super(name);

  static BuiltSet<DiscrepancyCheckerActionRequestActionEnum> get values => _$discrepancyCheckerActionRequestActionEnumValues;
  static DiscrepancyCheckerActionRequestActionEnum valueOf(String name) => _$discrepancyCheckerActionRequestActionEnumValueOf(name);
}

