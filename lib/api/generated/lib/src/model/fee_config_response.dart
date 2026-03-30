//
// AUTO-GENERATED FILE, DO NOT MODIFY!
//

// ignore_for_file: unused_element
import 'package:built_collection/built_collection.dart';
import 'package:built_value/built_value.dart';
import 'package:built_value/serializer.dart';

part 'fee_config_response.g.dart';

/// FeeConfigResponse
///
/// Properties:
/// * [feeConfigId] 
/// * [agentType] 
/// * [transactionType] 
/// * [feeType] 
/// * [feeAmount] 
/// * [percentage] 
/// * [status] 
/// * [effectiveFrom] 
/// * [effectiveTo] 
@BuiltValue()
abstract class FeeConfigResponse implements Built<FeeConfigResponse, FeeConfigResponseBuilder> {
  @BuiltValueField(wireName: r'feeConfigId')
  String? get feeConfigId;

  @BuiltValueField(wireName: r'agentType')
  String? get agentType;

  @BuiltValueField(wireName: r'transactionType')
  String? get transactionType;

  @BuiltValueField(wireName: r'feeType')
  String? get feeType;

  @BuiltValueField(wireName: r'feeAmount')
  num? get feeAmount;

  @BuiltValueField(wireName: r'percentage')
  num? get percentage;

  @BuiltValueField(wireName: r'status')
  FeeConfigResponseStatusEnum? get status;
  // enum statusEnum {  CREATED,  ACTIVE,  INACTIVE,  };

  @BuiltValueField(wireName: r'effectiveFrom')
  DateTime? get effectiveFrom;

  @BuiltValueField(wireName: r'effectiveTo')
  DateTime? get effectiveTo;

  FeeConfigResponse._();

  factory FeeConfigResponse([void updates(FeeConfigResponseBuilder b)]) = _$FeeConfigResponse;

  @BuiltValueHook(initializeBuilder: true)
  static void _defaults(FeeConfigResponseBuilder b) => b;

  @BuiltValueSerializer(custom: true)
  static Serializer<FeeConfigResponse> get serializer => _$FeeConfigResponseSerializer();
}

class _$FeeConfigResponseSerializer implements PrimitiveSerializer<FeeConfigResponse> {
  @override
  final Iterable<Type> types = const [FeeConfigResponse, _$FeeConfigResponse];

  @override
  final String wireName = r'FeeConfigResponse';

  Iterable<Object?> _serializeProperties(
    Serializers serializers,
    FeeConfigResponse object, {
    FullType specifiedType = FullType.unspecified,
  }) sync* {
    if (object.feeConfigId != null) {
      yield r'feeConfigId';
      yield serializers.serialize(
        object.feeConfigId,
        specifiedType: const FullType(String),
      );
    }
    if (object.agentType != null) {
      yield r'agentType';
      yield serializers.serialize(
        object.agentType,
        specifiedType: const FullType(String),
      );
    }
    if (object.transactionType != null) {
      yield r'transactionType';
      yield serializers.serialize(
        object.transactionType,
        specifiedType: const FullType(String),
      );
    }
    if (object.feeType != null) {
      yield r'feeType';
      yield serializers.serialize(
        object.feeType,
        specifiedType: const FullType(String),
      );
    }
    if (object.feeAmount != null) {
      yield r'feeAmount';
      yield serializers.serialize(
        object.feeAmount,
        specifiedType: const FullType(num),
      );
    }
    if (object.percentage != null) {
      yield r'percentage';
      yield serializers.serialize(
        object.percentage,
        specifiedType: const FullType(num),
      );
    }
    if (object.status != null) {
      yield r'status';
      yield serializers.serialize(
        object.status,
        specifiedType: const FullType(FeeConfigResponseStatusEnum),
      );
    }
    if (object.effectiveFrom != null) {
      yield r'effectiveFrom';
      yield serializers.serialize(
        object.effectiveFrom,
        specifiedType: const FullType(DateTime),
      );
    }
    if (object.effectiveTo != null) {
      yield r'effectiveTo';
      yield serializers.serialize(
        object.effectiveTo,
        specifiedType: const FullType(DateTime),
      );
    }
  }

  @override
  Object serialize(
    Serializers serializers,
    FeeConfigResponse object, {
    FullType specifiedType = FullType.unspecified,
  }) {
    return _serializeProperties(serializers, object, specifiedType: specifiedType).toList();
  }

  void _deserializeProperties(
    Serializers serializers,
    Object serialized, {
    FullType specifiedType = FullType.unspecified,
    required List<Object?> serializedList,
    required FeeConfigResponseBuilder result,
    required List<Object?> unhandled,
  }) {
    for (var i = 0; i < serializedList.length; i += 2) {
      final key = serializedList[i] as String;
      final value = serializedList[i + 1];
      switch (key) {
        case r'feeConfigId':
          final valueDes = serializers.deserialize(
            value,
            specifiedType: const FullType(String),
          ) as String;
          result.feeConfigId = valueDes;
          break;
        case r'agentType':
          final valueDes = serializers.deserialize(
            value,
            specifiedType: const FullType(String),
          ) as String;
          result.agentType = valueDes;
          break;
        case r'transactionType':
          final valueDes = serializers.deserialize(
            value,
            specifiedType: const FullType(String),
          ) as String;
          result.transactionType = valueDes;
          break;
        case r'feeType':
          final valueDes = serializers.deserialize(
            value,
            specifiedType: const FullType(String),
          ) as String;
          result.feeType = valueDes;
          break;
        case r'feeAmount':
          final valueDes = serializers.deserialize(
            value,
            specifiedType: const FullType(num),
          ) as num;
          result.feeAmount = valueDes;
          break;
        case r'percentage':
          final valueDes = serializers.deserialize(
            value,
            specifiedType: const FullType(num),
          ) as num;
          result.percentage = valueDes;
          break;
        case r'status':
          final valueDes = serializers.deserialize(
            value,
            specifiedType: const FullType(FeeConfigResponseStatusEnum),
          ) as FeeConfigResponseStatusEnum;
          result.status = valueDes;
          break;
        case r'effectiveFrom':
          final valueDes = serializers.deserialize(
            value,
            specifiedType: const FullType(DateTime),
          ) as DateTime;
          result.effectiveFrom = valueDes;
          break;
        case r'effectiveTo':
          final valueDes = serializers.deserialize(
            value,
            specifiedType: const FullType(DateTime),
          ) as DateTime;
          result.effectiveTo = valueDes;
          break;
        default:
          unhandled.add(key);
          unhandled.add(value);
          break;
      }
    }
  }

  @override
  FeeConfigResponse deserialize(
    Serializers serializers,
    Object serialized, {
    FullType specifiedType = FullType.unspecified,
  }) {
    final result = FeeConfigResponseBuilder();
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

class FeeConfigResponseStatusEnum extends EnumClass {

  @BuiltValueEnumConst(wireName: r'CREATED')
  static const FeeConfigResponseStatusEnum CREATED = _$feeConfigResponseStatusEnum_CREATED;
  @BuiltValueEnumConst(wireName: r'ACTIVE')
  static const FeeConfigResponseStatusEnum ACTIVE = _$feeConfigResponseStatusEnum_ACTIVE;
  @BuiltValueEnumConst(wireName: r'INACTIVE')
  static const FeeConfigResponseStatusEnum INACTIVE = _$feeConfigResponseStatusEnum_INACTIVE;

  static Serializer<FeeConfigResponseStatusEnum> get serializer => _$feeConfigResponseStatusEnumSerializer;

  const FeeConfigResponseStatusEnum._(String name): super(name);

  static BuiltSet<FeeConfigResponseStatusEnum> get values => _$feeConfigResponseStatusEnumValues;
  static FeeConfigResponseStatusEnum valueOf(String name) => _$feeConfigResponseStatusEnumValueOf(name);
}

