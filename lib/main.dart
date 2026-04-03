import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:agentbanking_channel/features/merchant/providers/merchant_provider.dart';
import 'package:agentbanking_channel/features/merchant/models/merchant_models.dart';
import 'package:agentbanking_channel/features/merchant/screens/retail_sale_screen.dart';
import 'package:agentbanking_channel/features/merchant/screens/cashback_screen.dart';
import 'package:agentbanking_channel/features/merchant/screens/pin_purchase_screen.dart';
import 'package:agentbanking_channel/features/kyc/providers/onboarding_provider.dart';
import 'package:agentbanking_channel/features/kyc/models/kyc_models.dart';
import 'package:agentbanking_channel/features/kyc/screens/kyc_flow_screen.dart';
import 'package:agentbanking_channel/features/auth/login_screen.dart';
import 'package:agentbanking_channel/features/auth/providers/auth_provider.dart';
import 'package:agentbanking_channel/features/auth/models/auth_models.dart';
import 'package:agentbanking_channel/features/dashboard/dashboard_screen.dart';
import 'package:agentbanking_channel/features/compliance/providers/compliance_provider.dart';
import 'package:agentbanking_channel/core/compliance/compliance_lock_screen.dart';

void main() {
  runApp(
    const ProviderScope(
      child: AgentBankingApp(),
    ),
  );
}

final GlobalKey<NavigatorState> navigatorKey = GlobalKey<NavigatorState>();

class AgentBankingApp extends ConsumerWidget {
  const AgentBankingApp({super.key});

  void _showSessionExpiredDialog() {
    debugPrint('BDD_DEBUG: Showing Session Expired Dialog');
    final context = navigatorKey.currentContext;
    if (context != null) {
      showDialog(
        context: context,
        barrierDismissible: false,
        builder: (context) => AlertDialog(
          title: const Text('Session expired'),
          content: const Text('Your session has timed out. Please re-authenticate.'),
          actions: [
            Consumer(
              builder: (context, ref, _) => TextButton(
                onPressed: () {
                  ref.read(authProvider.notifier).logout();
                  Navigator.pop(context);
                },
                child: const Text('RE-AUTHENTICATE'),
              ),
            ),
          ],
        ),
      );
    }
  }

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    // Global listener for session expiration
    ref.listen<AuthState>(authProvider, (previous, next) {
      if (next.status == AuthStatus.expired && previous?.status != AuthStatus.expired) {
        _showSessionExpiredDialog();
      }
    });

    return MaterialApp(
      navigatorKey: navigatorKey,
      title: 'Agent Banking Channel',
      debugShowMaterialGrid: false,
      debugShowCheckedModeBanner: false,
      theme: ThemeData(
        useMaterial3: true,
        brightness: Brightness.light,
        colorScheme: ColorScheme.fromSeed(
          seedColor: const Color(0xFF1A237E), // Deep Indigo
          primary: const Color(0xFF1A237E),
          surface: Colors.white,
          background: const Color(0xFFF8F9FA),
          secondary: const Color(0xFF00897B), // Teal
        ),
        scaffoldBackgroundColor: const Color(0xFFF8F9FA),
        cardTheme: CardThemeData(
          elevation: 2,
          shadowColor: Colors.black12,
          shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(24)),
          color: Colors.white,
        ),
        elevatedButtonTheme: ElevatedButtonThemeData(
          style: ElevatedButton.styleFrom(
            elevation: 0,
            padding: const EdgeInsets.symmetric(vertical: 16),
            shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(16)),
            backgroundColor: const Color(0xFF1A237E),
            foregroundColor: Colors.white,
          ),
        ),
        outlinedButtonTheme: OutlinedButtonThemeData(
          style: OutlinedButton.styleFrom(
            padding: const EdgeInsets.symmetric(vertical: 16),
            shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(16)),
            side: const BorderSide(color: Color(0xFF1A237E)),
          ),
        ),
        inputDecorationTheme: InputDecorationTheme(
          filled: true,
          fillColor: Colors.white,
          border: OutlineInputBorder(
            borderRadius: BorderRadius.circular(16),
            borderSide: BorderSide.none,
          ),
          enabledBorder: OutlineInputBorder(
            borderRadius: BorderRadius.circular(16),
            borderSide: BorderSide.none,
          ),
          focusedBorder: OutlineInputBorder(
            borderRadius: BorderRadius.circular(16),
            borderSide: const BorderSide(color: Color(0xFF1A237E), width: 1.5),
          ),
          contentPadding: const EdgeInsets.all(20),
        ),
      ),
      home: Consumer(
        builder: (context, ref, _) {
          final compliance = ref.watch(complianceProvider);
          if (compliance.isFrozen) {
            return const ComplianceLockScreen();
          }

          final authStatus = ref.watch(authProvider.select((s) => s.status));
          
          // Reactive Onboarding check (can happen during login or dashboard)
          final kycState = ref.watch(onboardingProvider);
          if (kycState.status != OnboardingStatus.idle) {
            return KycFlowScreen();
          }

          if (authStatus == AuthStatus.authenticated || authStatus == AuthStatus.expired) {
            final merchantState = ref.watch(merchantProvider);
            if (merchantState.status != MerchantStatus.idle) {
              if (merchantState.type == MerchantTransactionType.RETAIL_SALE) {
                return RetailSaleScreen();
              } else if (merchantState.type == MerchantTransactionType.CASHBACK_HYBRID) {
                return CashbackScreen();
              } else if (merchantState.type == MerchantTransactionType.PIN_PURCHASE) {
                return PinPurchaseScreen();
              }
            }
            return DashboardScreen();
          }
          return LoginScreen();
        },
      ),
    );
  }
}
