import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import '../providers/onboarding_provider.dart';

class KycFlowScreen extends ConsumerWidget {
  const KycFlowScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final state = ref.watch(onboardingProvider);

    return Scaffold(
      appBar: AppBar(title: const Text('New Customer Onboarding')),
      body: Center(
        child: Padding(
          padding: const EdgeInsets.all(24.0),
          child: _buildBody(context, ref, state),
        ),
      ),
    );
  }

  Widget _buildBody(BuildContext context, WidgetRef ref, OnboardingState state) {
    switch (state.status) {
      case OnboardingStatus.idle:
        return Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            const Icon(Icons.person_add, size: 80, color: Colors.blue),
            const SizedBox(height: 20),
            const Text('New Account Opening', style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold)),
            const SizedBox(height: 10),
            const Text('Please have the Customer\'s MyKad ready.'),
            const SizedBox(height: 30),
            ElevatedButton(
              onPressed: () => ref.read(onboardingProvider.notifier).startOnboarding(),
              child: const Text('Start MyKad Scan'),
            ),
          ],
        );
      case OnboardingStatus.scanningMyKad:
        return const Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            CircularProgressIndicator(),
            SizedBox(height: 20),
            Text('READING MYKAD CHIP...'),
            Text('DO NOT REMOVE CARD'),
          ],
        );
      case OnboardingStatus.validatingKyc:
        return const Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            CircularProgressIndicator(),
            SizedBox(height: 20),
            Text('VALIDATING IDENTITY...'),
            Text('AML & SANCTION CHECK IN PROGRESS'),
          ],
        );
      case OnboardingStatus.selectingProduct:
        return Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            const Icon(Icons.check_circle, color: Colors.green, size: 48),
            const Text('KYC VERIFIED SUCCESSFULLY', style: TextStyle(fontWeight: FontWeight.bold)),
            const Divider(height: 40),
            Text('Name: ${state.myKadData?.fullName}'),
            Text('ID: ${state.myKadData?.icNumber}'),
            const SizedBox(height: 30),
            const Text('Select Account Type:'),
            const SizedBox(height: 10),
            ListTile(
              title: const Text('Savings Account-i'),
              subtitle: const Text('Basic savings with profit sharing'),
              trailing: const Icon(Icons.arrow_forward_ios),
              onTap: () => ref.read(onboardingProvider.notifier).selectProduct('SAVINGS_001'),
            ),
            ListTile(
              title: const Text('Current Account-i'),
              subtitle: const Text('For daily transactions'),
              trailing: const Icon(Icons.arrow_forward_ios),
              onTap: () => ref.read(onboardingProvider.notifier).selectProduct('CURRENT_001'),
            ),
          ],
        );
      case OnboardingStatus.provisioning:
        return const Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            CircularProgressIndicator(),
            SizedBox(height: 20),
            Text('OPENING ACCOUNT...'),
            Text('PROVISIONING CORE BANKING SEED'),
          ],
        );
      case OnboardingStatus.success:
        return Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            const Icon(Icons.celebration, color: Colors.orange, size: 80),
            const SizedBox(height: 20),
            const Text('ACCOUNT OPENED SUCCESSFULLY', style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold)),
            const SizedBox(height: 30),
            ElevatedButton(
              onPressed: () => ref.read(onboardingProvider.notifier).reset(),
              child: const Text('Return to Home'),
            ),
          ],
        );
      case OnboardingStatus.failed:
        return Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            const Icon(Icons.error, color: Colors.red, size: 80),
            const SizedBox(height: 20),
            Text('ONBOARDING FAILED', style: const TextStyle(fontWeight: FontWeight.bold)),
            Text(state.error ?? 'Unknown error'),
            const SizedBox(height: 30),
            ElevatedButton(
              onPressed: () => ref.read(onboardingProvider.notifier).reset(),
              child: const Text('Dismiss'),
            ),
          ],
        );
    }
  }
}

final onboardingProvider = StateNotifierProvider<OnboardingNotifier, OnboardingState>((ref) {
  throw UnimplementedError('Initialize with correct dependencies in main.dart');
});
