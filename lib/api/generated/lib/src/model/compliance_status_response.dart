//
// AUTO-GENERATED FILE, DO NOT MODIFY!
//

// ignore_for_file: unused_element
import 'package:built_collection/built_collection.dart';
import 'package:built_value/built_value.dart';
import 'package:built_value/serializer.dart';

part 'compliance_status_response.g.dart';

/// ComplianceStatusResponse
///
/// Properties:
/// * [status] 
/// * [reason] 
/// * [checkedAt] 
@BuiltValue()
abstract class ComplianceStatusResponse implements Built<ComplianceStatusResponse, ComplianceStatusResponseBuilder> {
  @BuiltValueField(wireName: r'status')
  ComplianceStatusResponseStatusEnum? get status;
  // enum statusEnum {  LOCKED,  UNLOCKED,  };

  @BuiltValueField(wireName: r'reason')
  String? get reason;

  @BuiltValueField(wireName: r'checkedAt')
  DateTime? get checkedAt;

  ComplianceStatusResponse._();

  factory ComplianceStatusResponse([void updates(ComplianceStatusResponseBuilder b)]) = _$ComplianceStatusResponse;

  @BuiltValueHook(initializeBuilder: true)
  static void _defaults(ComplianceStatusResponseBuilder b) => b;

  @BuiltValueSerializer(custom: true)
  static Serializer<ComplianceStatusResponse> get serializer => _$ComplianceStatusResponseSerializer();
}

class _$ComplianceStatusResponseSerializer implements PrimitiveSerializer<ComplianceStatusResponse> {
  @override
  final Iterable<Type> types = const [ComplianceStatusResponse, _$ComplianceStatusResponse];

  @override
  final String wireName = r'ComplianceStatusResponse';

  Iterable<Object?> _serializeProperties(
    Serializers serializers,
    ComplianceStatusResponse object, {
    FullType specifiedType = FullType.unspecified,
  }) sync* {
    if (object.status != null) {
      yield r'status';
      yield serializers.serialize(
        object.status,
        specifiedType: const FullType(ComplianceStatusResponseStatusEnum),
      );
    }
    if (object.reason != null) {
      yield r'reason';
      yield serializers.serialize(
        object.reason,
        specifiedType: const FullType(String),
      );
    }
    if (object.checkedAt != null) {
      yield r'checkedAt';
      yield serializers.serialize(
        object.checkedAt,
        specifiedType: const FullType(DateTime),
      );
    }
  }

  @override
  Object serialize(
    Serializers serializers,
    ComplianceStatusResponse object, {
    FullType specifiedType = FullType.unspecified,
  }) {
    return _serializeProperties(serializers, object, specifiedType: specifiedType).toList();
  }

  void _deserializeProperties(
    Serializers serializers,
    Object serialized, {
    FullType specifiedType = FullType.unspecified,
    required List<Object?> serializedList,
    required ComplianceStatusResponseBuilder result,
    required List<Object?> unhandled,
  }) {
    for (var i = 0; i < serializedList.length; i += 2) {
      final key = serializedList[i] as String;
      final value = serializedList[i + 1];
      switch (key) {
        case r'status':
          final valueDes = serializers.deserialize(
            value,
            specifiedType: const FullType(ComplianceStatusResponseStatusEnum),
          ) as ComplianceStatusResponseStatusEnum;
          result.status = valueDes;
          break;
        case r'reason':
          final valueDes = serializers.deserialize(
            value,
            specifiedType: const FullType(String),
          ) as String;
          result.reason = valueDes;
          break;
        case r'checkedAt':
          final valueDes = serializers.deserialize(
            value,
            specifiedType: const FullType(DateTime),
          ) as DateTime;
          result.checkedAt = valueDes;
          break;
        default:
          unhandled.add(key);
          unhandled.add(value);
          break;
      }
    }
  }

  @override
  ComplianceStatusResponse deserialize(
    Serializers serializers,
    Object serialized, {
    FullType specifiedType = FullType.unspecified,
  }) {
    final result = ComplianceStatusResponseBuilder();
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

class ComplianceStatusResponseStatusEnum extends EnumClass {

  @BuiltValueEnumConst(wireName: r'LOCKED')
  static const ComplianceStatusResponseStatusEnum LOCKED = _$complianceStatusResponseStatusEnum_LOCKED;
  @BuiltValueEnumConst(wireName: r'UNLOCKED')
  static const ComplianceStatusResponseStatusEnum UNLOCKED = _$complianceStatusResponseStatusEnum_UNLOCKED;

  static Serializer<ComplianceStatusResponseStatusEnum> get serializer => _$complianceStatusResponseStatusEnumSerializer;

  const ComplianceStatusResponseStatusEnum._(String name): super(name);

  static BuiltSet<ComplianceStatusResponseStatusEnum> get values => _$complianceStatusResponseStatusEnumValues;
  static ComplianceStatusResponseStatusEnum valueOf(String name) => _$complianceStatusResponseStatusEnumValueOf(name);
}

