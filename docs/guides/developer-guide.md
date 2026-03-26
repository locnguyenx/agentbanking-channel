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
```

### Step 4: Run Automated Tests
Before deploying, ensure all tests pass:
```bash
flutter test
```

---

## 📱 3. Testing on a Physical Android Phone

### Step 1: Enable USB Debugging
1.  Go to your phone **Settings** -> **About Phone**.
2.  Tap **Build Number** 7 times to enable **Developer Options**.
3.  Go to **Developer Options** -> Enable **USB Debugging**.

### Step 2: Connect Phone to Laptop
1.  Connect your phone via USB.
2.  When the "Allow USB Debugging?" prompt appears on your phone, tap **Allow**.
3.  Verify the connection by running:
    ```bash
    flutter devices
    ```
    You should see your phone listed in the output.

### Step 3: Deployment (Debug Mode)
To test with hot reload and console logs:
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

## 🔌 4. Switching to Real APIs (Dio Integration)

To transition from the current mock implementations to real backend services, follow these steps:

### Step 1: Update Repository Logic
Replace the `Future.delayed` mocks in your repositories with `Dio` HTTP calls.

**Example: `AuthRepository` integration**
```dart
class AuthRepository {
  final Dio dio;
  AuthRepository(this.dio);

  Future<AuthUser> login(String agentId, String password) async {
    final response = await dio.post(
      '/api/v1/auth/login',
      data: {
        'agentId': agentId,
        'password': password,
      },
    );

    if (response.statusCode == 200) {
      return AuthUser(
        agentId: response.data['agentId'],
        name: response.data['name'],
        tier: response.data['tier'],
      );
    } else {
      throw Exception('Login Failed: ${response.data['message']}');
    }
  }
}
```

### Step 2: Configure Base URL and Interceptors
In your `providers`, configure the `Dio` instance with the API Gateway's base URL and authentication interceptors.

```dart
final dioProvider = Provider<Dio>((ref) {
  return Dio(BaseOptions(
    baseUrl: 'https://gateway.bank.my',
    connectTimeout: const Duration(seconds: 5),
  ))..interceptors.add(InterceptorsWrapper(
    onRequest: (options, handler) {
      // Add X-Idempotency-Key for all POST requests
      if (options.method == 'POST') {
        options.headers['X-Idempotency-Key'] = DateTime.now().millisecondsSinceEpoch.toString();
      }
      return handler.next(options);
    },
  ));
});
```

## ⚠️ Known Implementation Details
- **Hardware Simulation**: The app uses HAL mocks for card reading and MyKad scanning. No physical POS peripheral drivers are included in this codebase yet.
- **Backend Connection & Auth**: The app defaults to **Mock Repositories**. For testing, use **Agent ID**: `AGENT01` and **Password**: `123456`.
- **Database**: Uses SQLCipher for secure offline storage.

---
**Troubleshooting**: If you encounter dependency issues, run `flutter clean` then `flutter pub get`.
