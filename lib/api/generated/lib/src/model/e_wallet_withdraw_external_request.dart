//
// AUTO-GENERATED FILE, DO NOT MODIFY!
//

// ignore_for_file: unused_element
import 'package:built_collection/built_collection.dart';
import 'package:built_value/built_value.dart';
import 'package:built_value/serializer.dart';

part 'e_wallet_withdraw_external_request.g.dart';

/// EWalletWithdrawExternalRequest
///
/// Properties:
/// * [walletProvider] - E-wallet provider
/// * [walletAccountId] - E-wallet account ID
/// * [amount] - Withdrawal amount in MYR
/// * [currency]
/// * [idempotencyKey]
/// * [customerCard] - Customer card for card-based withdrawal
/// * [customerPin]
@BuiltValue()
abstract class EWalletWithdrawExternalRequest
    implements
        Built<EWalletWithdrawExternalRequest,
            EWalletWithdrawExternalRequestBuilder> {
  /// E-wallet provider
  @BuiltValueField(wireName: r'walletProvider')
  EWalletWithdrawExternalRequestWalletProviderEnum get walletProvider;
  // enum walletProviderEnum {  SARAWAK_PAY,  SARAWAK_TOPUP,  };

  /// E-wallet account ID
  @BuiltValueField(wireName: r'walletAccountId')
  String get walletAccountId;

  /// Withdrawal amount in MYR
  @BuiltValueField(wireName: r'amount')
  num get amount;

  @BuiltValueField(wireName: r'currency')
  EWalletWithdrawExternalRequestCurrencyEnum get currency;
  // enum currencyEnum {  MYR,  };

  @BuiltValueField(wireName: r'idempotencyKey')
  String get idempotencyKey;

  /// Customer card for card-based withdrawal
  @BuiltValueField(wireName: r'customerCard')
  String? get customerCard;

  @BuiltValueField(wireName: r'customerPin')
  String? get customerPin;

  EWalletWithdrawExternalRequest._();

  factory EWalletWithdrawExternalRequest(
          [void updates(EWalletWithdrawExternalRequestBuilder b)]) =
      _$EWalletWithdrawExternalRequest;

  @BuiltValueHook(initializeBuilder: true)
  static void _defaults(EWalletWithdrawExternalRequestBuilder b) =>
      b..currency = EWalletWithdrawExternalRequestCurrencyEnum.valueOf('MYR');

  @BuiltValueSerializer(custom: true)
  static Serializer<EWalletWithdrawExternalRequest> get serializer =>
      _$EWalletWithdrawExternalRequestSerializer();
}

class _$EWalletWithdrawExternalRequestSerializer
    implements PrimitiveSerializer<EWalletWithdrawExternalRequest> {
  @override
  final Iterable<Type> types = const [
    EWalletWithdrawExternalRequest,
    _$EWalletWithdrawExternalRequest
  ];

  @override
  final String wireName = r'EWalletWithdrawExternalRequest';

  Iterable<Object?> _serializeProperties(
    Serializers serializers,
    EWalletWithdrawExternalRequest object, {
    FullType specifiedType = FullType.unspecified,
  }) sync* {
    yield r'walletProvider';
    yield serializers.serialize(
      object.walletProvider,
      specifiedType:
          const FullType(EWalletWithdrawExternalRequestWalletProviderEnum),
    );
    yield r'walletAccountId';
    yield serializers.serialize(
      object.walletAccountId,
      specifiedType: const FullType(String),
    );
    yield r'amount';
    yield serializers.serialize(
      object.amount,
      specifiedType: const FullType(num),
    );
    yield r'currency';
    yield serializers.serialize(
      object.currency,
      specifiedType: const FullType(EWalletWithdrawExternalRequestCurrencyEnum),
    );
    yield r'idempotencyKey';
    yield serializers.serialize(
      object.idempotencyKey,
      specifiedType: const FullType(String),
    );
    if (object.customerCard != null) {
      yield r'customerCard';
      yield serializers.serialize(
        object.customerCard,
        specifiedType: const FullType(String),
      );
    }
    if (object.customerPin != null) {
      yield r'customerPin';
      yield serializers.serialize(
        object.customerPin,
        specifiedType: const FullType(String),
      );
    }
  }

  @override
  Object serialize(
    Serializers serializers,
    EWalletWithdrawExternalRequest object, {
    FullType specifiedType = FullType.unspecified,
  }) {
    return _serializeProperties(serializers, object,
            specifiedType: specifiedType)
        .toList();
  }

  void _deserializeProperties(
    Serializers serializers,
    Object serialized, {
    FullType specifiedType = FullType.unspecified,
    required List<Object?> serializedList,
    required EWalletWithdrawExternalRequestBuilder result,
    required List<Object?> unhandled,
  }) {
    for (var i = 0; i < serializedList.length; i += 2) {
      final key = serializedList[i] as String;
      final value = serializedList[i + 1];
      switch (key) {
        case r'walletProvider':
          final valueDes = serializers.deserialize(
            value,
            specifiedType: const FullType(
                EWalletWithdrawExternalRequestWalletProviderEnum),
          ) as EWalletWithdrawExternalRequestWalletProviderEnum;
          result.walletProvider = valueDes;
          break;
        case r'walletAccountId':
          final valueDes = serializers.deserialize(
            value,
            specifiedType: const FullType(String),
          ) as String;
          result.walletAccountId = valueDes;
          break;
        case r'amount':
          final valueDes = serializers.deserialize(
            value,
            specifiedType: const FullType(num),
          ) as num;
          result.amount = valueDes;
          break;
        case r'currency':
          final valueDes = serializers.deserialize(
            value,
            specifiedType:
                const FullType(EWalletWithdrawExternalRequestCurrencyEnum),
          ) as EWalletWithdrawExternalRequestCurrencyEnum;
          result.currency = valueDes;
          break;
        case r'idempotencyKey':
          final valueDes = serializers.deserialize(
            value,
            specifiedType: const FullType(String),
          ) as String;
          result.idempotencyKey = valueDes;
          break;
        case r'customerCard':
          final valueDes = serializers.deserialize(
            value,
            specifiedType: const FullType(String),
          ) as String;
          result.customerCard = valueDes;
          break;
        case r'customerPin':
          final valueDes = serializers.deserialize(
            value,
            specifiedType: const FullType(String),
          ) as String;
          result.customerPin = valueDes;
          break;
        default:
          unhandled.add(key);
          unhandled.add(value);
          break;
      }
    }
  }

  @override
  EWalletWithdrawExternalRequest deserialize(
    Serializers serializers,
    Object serialized, {
    FullType specifiedType = FullType.unspecified,
  }) {
    final result = EWalletWithdrawExternalRequestBuilder();
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

class EWalletWithdrawExternalRequestWalletProviderEnum extends EnumClass {
  /// E-wallet provider
  @BuiltValueEnumConst(wireName: r'SARAWAK_PAY')
  static const EWalletWithdrawExternalRequestWalletProviderEnum SARAWAK_PAY =
      _$eWalletWithdrawExternalRequestWalletProviderEnum_SARAWAK_PAY;

  /// E-wallet provider
  @BuiltValueEnumConst(wireName: r'SARAWAK_TOPUP')
  static const EWalletWithdrawExternalRequestWalletProviderEnum SARAWAK_TOPUP =
      _$eWalletWithdrawExternalRequestWalletProviderEnum_SARAWAK_TOPUP;

  static Serializer<EWalletWithdrawExternalRequestWalletProviderEnum>
      get serializer =>
          _$eWalletWithdrawExternalRequestWalletProviderEnumSerializer;

  const EWalletWithdrawExternalRequestWalletProviderEnum._(String name)
      : super(name);

  static BuiltSet<EWalletWithdrawExternalRequestWalletProviderEnum>
      get values => _$eWalletWithdrawExternalRequestWalletProviderEnumValues;
  static EWalletWithdrawExternalRequestWalletProviderEnum valueOf(
          String name) =>
      _$eWalletWithdrawExternalRequestWalletProviderEnumValueOf(name);
}

class EWalletWithdrawExternalRequestCurrencyEnum extends EnumClass {
  @BuiltValueEnumConst(wireName: r'MYR')
  static const EWalletWithdrawExternalRequestCurrencyEnum MYR =
      _$eWalletWithdrawExternalRequestCurrencyEnum_MYR;

  static Serializer<EWalletWithdrawExternalRequestCurrencyEnum>
      get serializer => _$eWalletWithdrawExternalRequestCurrencyEnumSerializer;

  const EWalletWithdrawExternalRequestCurrencyEnum._(String name) : super(name);

  static BuiltSet<EWalletWithdrawExternalRequestCurrencyEnum> get values =>
      _$eWalletWithdrawExternalRequestCurrencyEnumValues;
  static EWalletWithdrawExternalRequestCurrencyEnum valueOf(String name) =>
      _$eWalletWithdrawExternalRequestCurrencyEnumValueOf(name);
}
