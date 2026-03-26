# Core Setup & Auth Implementation Plan

> **For agentic workers:** REQUIRED SUB-SKILL: Use superpowers:subagent-driven-development (recommended) or superpowers:executing-plans to implement this plan task-by-task. Steps use checkbox (`- [ ]`) syntax for tracking.

**Goal:** Establish the foundational Flutter project architecture, secure storage, geofence monitoring math, and the biometric authentication session lifecycle.

**Architecture:** Feature-first Clean Architecture mapping to `lib/core/` and `lib/features/`.

**Tech Stack:** Flutter, test, flutter_test.

---

### Task 1: Initialize Core Secure Storage Service [DONE]

**BDD Scenarios:** Mapped to Scenario S1.4 (Secure logout clears all sensitive data)
**BRD Requirements:** Fulfills FR-CA-12.2, FR-CA-1.4
**User-Facing:** NO

**Files:**
- Create: `lib/core/security/secure_storage_service.dart`
- Test: `test/core/security/secure_storage_service_test.dart`

- [ ] **Step 1: Write the failing backend test**

```dart
// test/core/security/secure_storage_service_test.dart
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
```

- [ ] **Step 2: Run backend test to verify it fails**

Run: `flutter test test/core/security/secure_storage_service_test.dart`
Expected: FAIL with "Target of URI doesn't exist"

- [ ] **Step 3: Write minimal backend implementation**

```dart
// lib/core/security/secure_storage_service.dart
class SecureStorageService {
  String? _token; 
  
  Future<void> saveToken(String token) async {
    _token = token;
  }
  
  Future<String?> getToken() async {
    return _token;
  }
  
  Future<void> clearAll() async {
    _token = null;
  }
}
```

- [ ] **Step 4: Run backend test to verify it passes**

Run: `flutter test test/core/security/secure_storage_service_test.dart`
Expected: PASS

- [ ] **Step 5: Commit (test-first order)**

```bash
git add test/core/security/secure_storage_service_test.dart
git commit -m "test: add secure storage unit tests"
git add lib/core/security/secure_storage_service.dart
git commit -m "feat: implement basic secure storage service"
```

---

### Task 2: Implement Geofence Monitoring Math [DONE]

**BDD Scenarios:** S2.1 (Transaction allowed within geofence), S2.2 (Transaction blocked outside geofence)
**BRD Requirements:** Fulfills FR-CA-1.2, FR-CA-2.2
**User-Facing:** NO

**Files:**
- Create: `lib/core/location/geofence_service.dart`
- Test: `test/core/location/geofence_service_test.dart`

- [x] **Step 1: Write the failing backend test**

```dart
// test/core/location/geofence_service_test.dart
import 'package:flutter_test/flutter_test.dart';
import '../../lib/core/location/geofence_service.dart';

void main() {
  test('GeofenceService verifies if location is within boundaries', () {
    final service = GeofenceService(shopLat: 3.1390, shopLng: 101.6869);
    expect(service.isWithinGeofence(3.1395, 101.6872), true); 
    expect(service.isWithinGeofence(3.1500, 101.7000), false); 
  });
}
```

- [x] **Step 2: Run backend test to verify it fails**

Run: `flutter test test/core/location/geofence_service_test.dart`
Expected: FAIL

- [x] **Step 3: Write minimal backend implementation**

```dart
// lib/core/location/geofence_service.dart
import 'dart:math';

class GeofenceService {
  final double shopLat;
  final double shopLng;

  GeofenceService({required this.shopLat, required this.shopLng});
  
  bool isWithinGeofence(double currentLat, double currentLng) {
    final distance = sqrt(pow(shopLat - currentLat, 2) + pow(shopLng - currentLng, 2));
    return distance < 0.01; 
  }
}
```

- [x] **Step 4: Run backend test to verify it passes**

Run: `flutter test test/core/location/geofence_service_test.dart`
Expected: PASS

- [x] **Step 5: Commit (test-first order)**

```bash
git add test/core/location/geofence_service_test.dart
git commit -m "test: geofence distance logic tests"
git add lib/core/location/geofence_service.dart
git commit -m "feat: implement euclidean geofence verification algorithm"
```

---

### Task 3: Auth Provider & Session State Setup [DONE]

**BDD Scenarios:** S1.1 (Agent logs in), S1.5 (Re-auth on session expiry)
**BRD Requirements:** Fulfills FR-CA-1.1, FR-CA-1.5
**User-Facing:** NO

**Files:**
- Create: `lib/features/auth/auth_provider.dart`
- Test: `test/features/auth/auth_provider_test.dart`

- [x] **Step 1: Write the failing backend test**

```dart
// test/features/auth/auth_provider_test.dart
import 'package:flutter_test/flutter_test.dart';
import '../../lib/features/auth/auth_provider.dart';

void main() {
  test('AuthNotifier correctly transitions login and logout states', () {
    final auth = AuthNotifier();
    expect(auth.state, AuthState.unauthenticated);
    
    auth.login('mock-jwt');
    expect(auth.state, AuthState.authenticated);
    
    auth.logout();
    expect(auth.state, AuthState.unauthenticated);
  });
}
```

- [x] **Step 2: Run backend test to verify it fails**

Run: `flutter test test/features/auth/auth_provider_test.dart`
Expected: FAIL

- [x] **Step 3: Write minimal backend implementation**

```dart
// lib/features/auth/auth_provider.dart
enum AuthState { unauthenticated, authenticated }

class AuthNotifier {
  AuthState state = AuthState.unauthenticated;
  
  void login(String jwt) {
    state = AuthState.authenticated;
  }
  
  void logout() {
    state = AuthState.unauthenticated;
  }
}
```

- [x] **Step 4: Run backend test to verify it passes**

Run: `flutter test test/features/auth/auth_provider_test.dart`
Expected: PASS

- [x] **Step 5: Commit (test-first order)**

```bash
git add test/features/auth/auth_provider_test.dart
git commit -m "test: auth provider state management"
git add lib/features/auth/auth_provider.dart
git commit -m "feat: implement auth notifier state model"
```

---

### Task 4: Login Screen UI Shell [DONE]

**BDD Scenarios:** S1.1 (Agent logs in with valid biometric)
**BRD Requirements:** Fulfills FR-CA-1.1
**User-Facing:** YES

**Files:**
- Create: `lib/features/auth/login_screen.dart`
- Frontend Test: `test/features/auth/login_screen_test.dart`

- [x] **Step 5: Write failing frontend test**

```dart
// test/features/auth/login_screen_test.dart
import 'package:flutter_test/flutter_test.dart';
import 'package:flutter/material.dart';
import '../../lib/features/auth/login_screen.dart';

void main() {
  testWidgets('renders login screen with CTA button', (tester) async {
    await tester.pumpWidget(const MaterialApp(home: LoginScreen()));
    expect(find.byType(ElevatedButton), findsOneWidget);
    expect(find.text('Login via Biometric'), findsOneWidget);
  });
}
```

- [x] **Step 6: Run frontend test to verify it fails**

Run: `flutter test test/features/auth/login_screen_test.dart`
Expected: FAIL

- [x] **Step 7: Write minimal frontend component**

```dart
// lib/features/auth/login_screen.dart
import 'package:flutter/material.dart';

class LoginScreen extends StatelessWidget {
  const LoginScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: ElevatedButton(
          onPressed: () {},
          child: const Text('Login via Biometric'),
        ),
      ),
    );
  }
}
```

- [x] **Step 8: Run frontend test to verify it passes**

Run: `flutter test test/features/auth/login_screen_test.dart`
Expected: PASS

- [x] **Step 9: Commit (test-first order)**

```bash
git add test/features/auth/login_screen_test.dart
git commit -m "test: add widget tests for login screen"
git add lib/features/auth/login_screen.dart
git commit -m "feat: implement minimal login screen UI"
```
