import 'package:flutter/services.dart';
import 'package:flutter_test/flutter_test.dart';

/// Global setup to mock sqflite and other native plugins that fail in common tests.
void setupTestMocks() {
  TestWidgetsFlutterBinding.ensureInitialized();

  const MethodChannel sqfliteChannel = MethodChannel('com.davidmartos96.sqflite_sqlcipher');
  
  TestDefaultBinaryMessengerBinding.instance.defaultBinaryMessenger.setMockMethodCallHandler(
    sqfliteChannel,
    (MethodCall methodCall) async {
      if (methodCall.method == 'getDatabasesPath') {
        return '.'; // Return current directory for database path in tests
      }
      return null;
    },
  );
}
