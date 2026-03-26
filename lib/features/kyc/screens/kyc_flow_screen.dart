import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:agentbanking_channel/features/kyc/providers/onboarding_provider.dart';
import 'package:agentbanking_channel/core/offline/widgets/offline_indicator.dart';

class KycFlowScreen extends ConsumerWidget {
  const KycFlowScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final state = ref.watch(onboardingProvider);

    return Scaffold(
      backgroundColor: const Color(0xFFF8F9FA),
      appBar: AppBar(
        title: const Text('Customer Onboarding', style: TextStyle(fontWeight: FontWeight.bold, fontSize: 18)),
        backgroundColor: Colors.white,
        elevation: 0,
        centerTitle: true,
        actions: const [OfflineIndicator()],
      ),
      body: Center(
        child: SingleChildScrollView(
          padding: const EdgeInsets.all(24.0),
          child: ConstrainedBox(
            constraints: const BoxConstraints(maxWidth: 500),
            child: Card(
              elevation: 0,
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(32),
                side: BorderSide(color: Colors.grey.shade200),
              ),
              child: Padding(
                padding: const EdgeInsets.all(32.0),
                child: _buildBody(context, ref, state),
              ),
            ),
          ),
        ),
      ),
    );
  }

  Widget _buildBody(BuildContext context, WidgetRef ref, OnboardingState state) {
    switch (state.status) {
      case OnboardingStatus.idle:
        return Column(
          children: [
            Container(
              padding: const EdgeInsets.all(20),
              decoration: BoxDecoration(
                color: Theme.of(context).colorScheme.primary.withOpacity(0.1),
                shape: BoxShape.circle,
              ),
              child: Icon(Icons.person_add_outlined, size: 40, color: Theme.of(context).colorScheme.primary),
            ),
            const SizedBox(height: 24),
            const Text('New Account Opening', style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold)),
            const SizedBox(height: 12),
            const Text(
              'Follow the e-KYC process to register a new customer securely.',
              textAlign: TextAlign.center,
              style: TextStyle(color: Colors.grey, fontSize: 13),
            ),
            const SizedBox(height: 48),
            Container(
              padding: const EdgeInsets.all(16),
              decoration: BoxDecoration(color: Colors.amber.shade50, borderRadius: BorderRadius.circular(16)),
              child: Row(
                children: [
                  Icon(Icons.info_outline, color: Colors.amber.shade800, size: 20),
                  const SizedBox(width: 12),
                  const Expanded(
                    child: Text(
                      'Please ensure the customer\'s MyKad is available for scanning.',
                      style: TextStyle(fontSize: 12, fontWeight: FontWeight.w500),
                    ),
                  ),
                ],
              ),
            ),
            const SizedBox(height: 48),
            SizedBox(
              width: double.infinity,
              height: 56,
              child: ElevatedButton(
                onPressed: () => ref.read(onboardingProvider.notifier).startOnboarding(),
                child: const Text('START MYKAD SCAN'),
              ),
            ),
          ],
        );
      case OnboardingStatus.scanningMyKad:
      case OnboardingStatus.validatingKyc:
      case OnboardingStatus.provisioning:
        String message = 'Processing...';
        String detail = 'Please wait';
        if (state.status == OnboardingStatus.scanningMyKad) {
          message = 'READING MYKAD...';
          detail = 'Do not remove card from reader';
        } else if (state.status == OnboardingStatus.validatingKyc) {
          message = 'VALIDATING IDENTITY...';
          detail = 'AML & Sanction check in progress';
        } else if (state.status == OnboardingStatus.provisioning) {
          message = 'OPENING ACCOUNT...';
          detail = 'Provisioning Core Banking details';
        }
        return Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            const CircularProgressIndicator(),
            const SizedBox(height: 32),
            Text(message, style: const TextStyle(fontWeight: FontWeight.bold, fontSize: 16)),
            const SizedBox(height: 8),
            Text(detail, style: const TextStyle(color: Colors.grey, fontSize: 13)),
          ],
        );
      case OnboardingStatus.selectingProduct:
        return Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            const Row(
              children: [
                Icon(Icons.check_circle, color: Colors.green, size: 24),
                SizedBox(width: 12),
                Text('KYC VERIFIED', style: TextStyle(fontWeight: FontWeight.bold, color: Colors.green)),
              ],
            ),
            const SizedBox(height: 24),
            Text(state.myKadData?.fullName ?? 'N/A', style: const TextStyle(fontSize: 18, fontWeight: FontWeight.bold)),
            Text('IC: ${state.myKadData?.icNumber}', style: const TextStyle(color: Colors.grey, fontSize: 13)),
            const SizedBox(height: 48),
            const Text('SELECT ACCOUNT PRODUCT', style: TextStyle(fontSize: 12, fontWeight: FontWeight.bold, color: Colors.grey, letterSpacing: 1.2)),
            const SizedBox(height: 16),
            _buildProductCard(
              context,
              ref,
              'Savings Account-i',
              'Basic savings with profit sharing',
              'SAVINGS_001',
            ),
            const SizedBox(height: 12),
            _buildProductCard(
              context,
              ref,
              'Current Account-i',
              'For daily high-volume transactions',
              'CURRENT_001',
            ),
          ],
        );
      case OnboardingStatus.success:
        return Column(
          children: [
            const Icon(Icons.stars_rounded, color: Colors.orange, size: 80),
            const SizedBox(height: 24),
            const Text('Welcome Aboard!', style: TextStyle(fontSize: 24, fontWeight: FontWeight.bold)),
            const SizedBox(height: 8),
            const Text('Account opened successfully', style: TextStyle(color: Colors.grey)),
            const SizedBox(height: 48),
            SizedBox(
              width: double.infinity,
              height: 56,
              child: ElevatedButton(
                onPressed: () {
                  ref.read(onboardingProvider.notifier).reset();
                  Navigator.pop(context);
                },
                child: const Text('BACK TO DASHBOARD'),
              ),
            ),
          ],
        );
      case OnboardingStatus.failed:
        return Column(
          children: [
            const Icon(Icons.error_outline, color: Colors.red, size: 80),
            const SizedBox(height: 24),
            const Text('Onboarding Failed', style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold)),
            const SizedBox(height: 12),
            Text(state.error ?? 'Connection lost during scan', textAlign: TextAlign.center, style: const TextStyle(color: Colors.grey)),
            const SizedBox(height: 48),
            SizedBox(
              width: double.infinity,
              height: 56,
              child: ElevatedButton(
                onPressed: () => ref.read(onboardingProvider.notifier).reset(),
                child: const Text('TRY AGAIN'),
              ),
            ),
          ],
        );
    }
  }

  Widget _buildProductCard(BuildContext context, WidgetRef ref, String title, String subtitle, String code) {
    return Card(
      elevation: 0,
      margin: EdgeInsets.zero,
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(20),
        side: BorderSide(color: Colors.grey.shade200),
      ),
      child: ListTile(
        contentPadding: const EdgeInsets.symmetric(horizontal: 20, vertical: 12),
        title: Text(title, style: const TextStyle(fontWeight: FontWeight.bold, fontSize: 14)),
        subtitle: Text(subtitle, style: const TextStyle(fontSize: 11)),
        trailing: const Icon(Icons.chevron_right, size: 20),
        onTap: () => ref.read(onboardingProvider.notifier).selectProduct(code),
      ),
    );
  }
}
