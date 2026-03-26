import 'package:flutter_test/flutter_test.dart';
import '../../lib/core/security/secure_storage_service.dart';

void main() {
  test('SecureStorageService saves and clears token successfully', () async {
    final service = SecureStorageService();
    await service.saveToken('jwt-12345');
    expect(await service.getToken(), 'jwt-12345');
    await service.clearAll();
    expect(await service.getToken(), null);
  });
}
