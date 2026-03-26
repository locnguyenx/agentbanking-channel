import 'dart:async';
import 'package:agentbanking_channel/core/security/secure_storage_service.dart';

class ComplianceService {
  final SecureStorageService secureStorage;
  static const String _lockKey = 'compliance_terminal_locked';
  
  final _lockController = StreamController<bool>.broadcast();
  Stream<bool> get lockStream => _lockController.stream;

  bool _isLocked = false;
  bool get isLocked => _isLocked;

  ComplianceService(this.secureStorage) {
    _init();
  }

  Future<void> _init() async {
    final locked = await secureStorage.read(_lockKey);
    _isLocked = locked == 'true';
    _lockController.add(_isLocked);
  }

  Future<void> lockTerminal() async {
    _isLocked = true;
    await secureStorage.write(_lockKey, 'true');
    _lockController.add(true);
  }

  Future<void> unlockTerminal(String supervisorToken) async {
    // In real implementation, validate supervisorToken with backend
    _isLocked = false;
    await secureStorage.delete(_lockKey);
    _lockController.add(false);
  }

  void handleApiResponse(int? statusCode, String? errorCode) {
    if (errorCode == 'ERR_COMPLIANCE_FREEZE') {
      lockTerminal();
    }
  }
}
