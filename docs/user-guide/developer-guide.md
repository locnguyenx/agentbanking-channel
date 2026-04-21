# Agent Banking Channel - Developer & Deployment Guide

This guide covers the technical setup for developers to build, run, and test the Agent Banking Channel application.

## 🛠️ 1. Prerequisites
Ensure you have the following installed on your laptop:
- **Flutter SDK**: `v3.x` or later.
- **Android Studio** (or VS Code with Dart/Flutter extensions).
- **Git** for version control.
- **Java (JDK)**: Version 11 or 17 (Required for Android builds).

## 🚀 2. Local Development (Laptop)

### Step 1: Bootstrap the Project
Because this is a pure implementation codebase, you need to generate the native platform folders (Android/iOS) first:
```bash
flutter create .
```
This will add the necessary `android/`, `ios/`, and `web/` folders to the project without changing your code.

### Step 2: Install Dependencies
Run this in the project root to fetch all required packages:
```bash
flutter pub get
```

### Step 2: Set Up an Emulator or Simulator
- **Android**: Open Android Studio -> Device Manager -> Start an AVD (e.g., Pixel 5).
- **iOS (Mac only)**: Run `open -a Simulator`.

### Step 3: Run the App
Run the following command to launch the app on your selected device:
```bash
flutter run
# This is only for local development. Do not use this method for production deployments. For CORS issues in web browser:
flutter run -d chrome --web-browser-flag "--disable-web-security"

```

### Step 4: Run Automated Tests
Before deploying, ensure all tests pass:
```bash
flutter test
```

### Troubleshooting

To run the tests or the application while avoiding the codesign error (caused by the Miniconda conflict), use the following commands:

**Running Tests**
Execute the full test suite with the PATH override:

```bash
PATH="/usr/bin:/bin:/usr/sbin:/sbin:$PATH" flutter test
```
**Running the Application**
When running on a macOS desktop or a Simulator, the same PATH override is required for code signing:
```bash
PATH="/usr/bin:/bin:/usr/sbin:/sbin:$PATH" flutter run
```
**Pro-Tip: Permanent Fix**
To avoid typing the long prefix every time, add this alias to your shell configuration (e.g., ~/.zshrc):
  
Open your config: `nano ~/.zshrc`
Add this line:
```bash
alias flutter='PATH="/usr/bin:/bin:/usr/sbin:/sbin:$PATH" flutter'
```
Save and reload: `source ~/.zshrc`
Now you can just run flutter test or flutter run normally!

## 📏 3. Architectural Standards

### 3.1 Financial Precision (Decimal)
All monetary values **MUST** use the `Decimal` type from the `decimal` package. **NEVER** use `double` or `float` for currency as they suffer from binary floating-point inaccuracies.
- **Rounding**: Use `HALF_UP` to 2 decimal places when displaying to users.
- **Validation**: Use `Decimal.tryParse()` for user input.

### 3.2 Service Code Standardization
Service identifiers must be consistent across the Dashboard, Transaction Provider, and Backend.
- **Standard Code**: `BALANCE_INQUIRY`
- **Standard Code**: `CASH_WDL` (Withdrawal)
- **Standard Code**: `BILL_PAY` (Bill Payment)

## 🧪 4. Testing Strategy

### 4.1 Unit Testing with FakeDio
When testing repositories, avoid using real network calls or complex `mockito` setups for `Dio`. Instead, use a `Fake` or `Mock` implementation that mimics the `Dio` interface.
- **Pattern**: Create a `FakeDio` class that implements `Dio` but returns pre-defined response objects.
- **Location**: See `test/features/transactions/transaction_repository_test.dart` for examples.

### 4.2 Widget Testing (Provider Overrides)
Use `ProviderScope` overrides to isolate widgets from real business logic:
```dart
await tester.pumpWidget(
  ProviderScope(
    overrides: [
      transactionProvider.overrideWith((ref) => MockTransactionNotifier()),
    ],
    child: const MaterialApp(home: TransactionFlowScreen(...)),
  ),
);
```

### 4.3 End-to-End Integration Testing
The project includes a full lifecycle integration test suite located at `test/integration/app_test.dart`.
- **Note**: This test is sensitive to hardware simulation latencies. Use `tester.pump(Duration)` explicitly when waiting for hardware timers (e.g., MyKad 3s scan).

## 📱 5. Testing on a Physical Android Phone

### Step 1: Enable USB Debugging
1.  Go to your phone **Settings** -> **About Phone**.
2.  Tap **Build Number** 7 times to enable **Developer Options**.
3.  Go to **Developer Options** -> Enable **USB Debugging**.

### Step 2: Connect Phone to Laptop
1.  Connect your phone via USB and verify by running:
    ```bash
    flutter devices
    ```
    You should see your phone listed in the output.

### Step 3: Deployment (Debug Mode)
```bash
flutter run
```

### Step 4: Deployment (Release APK)
To build a standalone installable file:
1.  Generate the APK:
```bash
flutter build apk --release
```
2.  The file will be located at:
    `build/app/outputs/flutter-apk/app-release.apk`
3.  You can copy this file to your phone and install it manually.

## 🔌 6. Switching to Real APIs (Dio Integration)

To transition from mock implementations to real backend services:

### Step 1: Update Repository Logic
Replace the `Future.delayed` mocks in your repositories with `Dio` HTTP calls.

**Example: `AuthRepository` integration**
```dart
class AuthRepository {
  final Dio dio;
  AuthRepository(this.dio);

  Future<AuthUser> login(String agentId, String password) async {
    final response = await dio.post('/api/v1/auth/login', data: {'agentId': agentId, 'password': password});
    if (response.statusCode == 200) {
      return AuthUser(agentId: response.data['agentId'], name: response.data['name'], tier: response.data['tier']);
    } else {
      throw Exception('Login Failed');
    }
  }
}
```

### Step 2: Configure Base URL and Interceptors
In your `providers`, configure the `Dio` instance with the API Gateway's base URL and authentication interceptors (e.g., for `X-Idempotency-Key`).

## ⚠️ 7. Known Implementation Details
- **Hardware Simulation**: HAL mocks have latencies: MyKad Scan (3s), KYC Validation (1s), Transaction Execution (2s).
- **Backend Connection**: Defaults to **Mock Repositories** (Agent ID: `AGENT01`, Password: `123456`).
- **Database**: Uses SQLCipher for secure offline storage.

---
**Troubleshooting**: Run `flutter clean` then `flutter pub get`.

## 8. System Parameters
- The frequency for polling the transaction status (e.g., for DuitNow or Biller status checks) is primarily controlled in the `TransactionNotifier` located in `lib/features/transactions/providers/transaction_provider.dart`.
```dart
The default value is set to 2 seconds:
 // lib/features/transactions/providers/transaction_provider.dart

class TransactionNotifier extends StateNotifier<TransactionState> {
  // ...
  final Duration pollingInterval;

  TransactionNotifier({
    // ...
    this.pollingInterval = const Duration(seconds: 2), // Here
    this.cardTimerDelay = Duration.zero,
  }) : super(TransactionState(status: TransactionStatus.idle)) {
    // ...
    _duitNowFlowNotifier = DuitNowFlowNotifier(
      ref: ref,
      repository: repository,
      floatNotifier: floatNotifier,
      reversalService: reversalService,
      pollingInterval: pollingInterval, // Passed to sub-notifiers
    );
    // ...
  }
}
```



