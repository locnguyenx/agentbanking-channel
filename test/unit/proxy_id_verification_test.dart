import 'package:flutter_test/flutter_test.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:decimal/decimal.dart';
import 'package:agentbanking_channel/features/transactions/providers/proxy_deposit_notifier.dart';
import 'package:agentbanking_channel/features/transactions/models/transaction_models.dart';
import 'package:agentbanking_channel/features/transactions/repositories/transaction_repository.dart';
import 'package:agentbanking_channel/features/hardware/hardware_interfaces.dart';
import 'package:geolocator/geolocator.dart';
import 'package:agentbanking_channel/features/hardware/hardware_providers.dart';
import 'package:agentbanking_channel/core/network/geolocator_provider.dart';

class FakeTransactionRepository extends Fake implements TransactionRepository {
  String? lastProxyId;
  String? lastProxyType;

  @override
  Future<String> performProxyEnquiry(String proxyId, String proxyType) async {
    lastProxyId = proxyId;
    lastProxyType = proxyType;
    return 'John Doe';
  }
}

class FakeMyKadScanner extends Fake implements IMyKadScanner {}
class FakeGeolocator extends Fake implements GeolocatorPlatform {
  @override
  Future<Position> getCurrentPosition({
    LocationSettings? locationSettings,
  }) async {
    return Position(
      longitude: 0,
      latitude: 0,
      timestamp: DateTime.now(),
      accuracy: 0,
      altitude: 0,
      heading: 0,
      speed: 0,
      speedAccuracy: 0,
      altitudeAccuracy: 0,
      headingAccuracy: 0,
    );
  }
}

void main() {
  late FakeTransactionRepository repository;
  late ProviderContainer container;

  setUp(() {
    repository = FakeTransactionRepository();
    container = ProviderContainer(
      overrides: [
        transactionRepositoryProvider.overrideWithValue(repository),
        myKadScannerProvider.overrideWithValue(FakeMyKadScanner()),
        geolocatorProvider.overrideWithValue(FakeGeolocator()),
      ],
    );
  });

  test('ProxyDepositNotifier uses MOBILE when MOBILE is specified in metadata', () async {
    final notifier = container.read(proxyDepositNotifierProvider.notifier);
    
    await notifier.executeProxyEnquiry(
      amount: Decimal.fromInt(100),
      merchantId: 'M123',
      fundingSource: FundingSource.CASH,
      metadata: {
        'destinationAccount': '0123456789',
        'proxyType': 'MOBILE',
      },
    );

    expect(repository.lastProxyId, '0123456789');
    expect(repository.lastProxyType, 'MOBILE');
  });

  test('ProxyDepositNotifier uses ACCOUNT when ACCOUNT is specified in metadata', () async {
    final notifier = container.read(proxyDepositNotifierProvider.notifier);
    
    await notifier.executeProxyEnquiry(
      amount: Decimal.fromInt(100),
      merchantId: 'M123',
      fundingSource: FundingSource.CASH,
      metadata: {
        'destinationAccount': '987654321',
        'proxyType': 'ACCOUNT',
      },
    );

    expect(repository.lastProxyId, '987654321');
    expect(repository.lastProxyType, 'ACCOUNT');
  });
}
