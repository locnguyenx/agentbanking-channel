//
// AUTO-GENERATED FILE, DO NOT MODIFY!
//

// ignore_for_file: unused_element
import 'package:agent_api/src/model/date.dart';
import 'package:built_value/built_value.dart';
import 'package:built_value/serializer.dart';

part 'my_kad_verify_request.g.dart';

/// MyKadVerifyRequest
///
/// Properties:
/// * [mykadNumber] - MyKad number (12 digits)
/// * [name] - Full name from MyKad
/// * [dateOfBirth] 
/// * [address] 
@BuiltValue()
abstract class MyKadVerifyRequest implements Built<MyKadVerifyRequest, MyKadVerifyRequestBuilder> {
  /// MyKad number (12 digits)
  @BuiltValueField(wireName: r'mykadNumber')
  String get mykadNumber;

  /// Full name from MyKad
  @BuiltValueField(wireName: r'name')
  String? get name;

  @BuiltValueField(wireName: r'dateOfBirth')
  Date? get dateOfBirth;

  @BuiltValueField(wireName: r'address')
  String? get address;

  MyKadVerifyRequest._();

  factory MyKadVerifyRequest([void updates(MyKadVerifyRequestBuilder b)]) = _$MyKadVerifyRequest;

  @BuiltValueHook(initializeBuilder: true)
  static void _defaults(MyKadVerifyRequestBuilder b) => b;

  @BuiltValueSerializer(custom: true)
  static Serializer<MyKadVerifyRequest> get serializer => _$MyKadVerifyRequestSerializer();
}

class _$MyKadVerifyRequestSerializer implements PrimitiveSerializer<MyKadVerifyRequest> {
  @override
  final Iterable<Type> types = const [MyKadVerifyRequest, _$MyKadVerifyRequest];

  @override
  final String wireName = r'MyKadVerifyRequest';

  Iterable<Object?> _serializeProperties(
    Serializers serializers,
    MyKadVerifyRequest object, {
    FullType specifiedType = FullType.unspecified,
  }) sync* {
    yield r'mykadNumber';
    yield serializers.serialize(
      object.mykadNumber,
      specifiedType: const FullType(String),
    );
    if (object.name != null) {
      yield r'name';
      yield serializers.serialize(
        object.name,
        specifiedType: const FullType(String),
      );
    }
    if (object.dateOfBirth != null) {
      yield r'dateOfBirth';
      yield serializers.serialize(
        object.dateOfBirth,
        specifiedType: const FullType(Date),
      );
    }
    if (object.address != null) {
      yield r'address';
      yield serializers.serialize(
        object.address,
        specifiedType: const FullType(String),
      );
    }
  }

  @override
  Object serialize(
    Serializers serializers,
    MyKadVerifyRequest object, {
    FullType specifiedType = FullType.unspecified,
  }) {
    return _serializeProperties(serializers, object, specifiedType: specifiedType).toList();
  }

  void _deserializeProperties(
    Serializers serializers,
    Object serialized, {
    FullType specifiedType = FullType.unspecified,
    required List<Object?> serializedList,
    required MyKadVerifyRequestBuilder result,
    required List<Object?> unhandled,
  }) {
    for (var i = 0; i < serializedList.length; i += 2) {
      final key = serializedList[i] as String;
      final value = serializedList[i + 1];
      switch (key) {
        case r'mykadNumber':
          final valueDes = serializers.deserialize(
            value,
            specifiedType: const FullType(String),
          ) as String;
          result.mykadNumber = valueDes;
          break;
        case r'name':
          final valueDes = serializers.deserialize(
            value,
            specifiedType: const FullType(String),
          ) as String;
          result.name = valueDes;
          break;
        case r'dateOfBirth':
          final valueDes = serializers.deserialize(
            value,
            specifiedType: const FullType(Date),
          ) as Date;
          result.dateOfBirth = valueDes;
          break;
        case r'address':
          final valueDes = serializers.deserialize(
            value,
            specifiedType: const FullType(String),
          ) as String;
          result.address = valueDes;
          break;
        default:
          unhandled.add(key);
          unhandled.add(value);
          break;
      }
    }
  }

  @override
  MyKadVerifyRequest deserialize(
    Serializers serializers,
    Object serialized, {
    FullType specifiedType = FullType.unspecified,
  }) {
    final result = MyKadVerifyRequestBuilder();
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

