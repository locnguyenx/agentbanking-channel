import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:agentbanking_channel/features/agent_onboarding/providers/agent_onboarding_provider.dart';

class AgentOnboardingScreen extends ConsumerStatefulWidget {
  const AgentOnboardingScreen({super.key});

  @override
  ConsumerState<AgentOnboardingScreen> createState() => _AgentOnboardingScreenState();
}

class _AgentOnboardingScreenState extends ConsumerState<AgentOnboardingScreen> {
  final _ssmController = TextEditingController();
  final _phoneController = TextEditingController();
  final _otpController = TextEditingController();

  @override
  void dispose() {
    _ssmController.dispose();
    _phoneController.dispose();
    _otpController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final state = ref.watch(agentOnboardingProvider);
    final notifier = ref.read(agentOnboardingProvider.notifier);

    if (state.status == AgentOnboardingStatus.activated) {
      return Scaffold(
        appBar: AppBar(title: const Text('Account Activated')),
        body: Center(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              const Icon(Icons.verified_user, color: Colors.green, size: 80),
              const Text('Instant Activation Successful!', style: TextStyle(fontSize: 22, fontWeight: FontWeight.bold)),
              const SizedBox(height: 16),
              const Padding(
                padding: EdgeInsets.symmetric(horizontal: 40),
                child: Text('KYC VERIFIED', textAlign: TextAlign.center),
              ),
              const SizedBox(height: 48),
              ElevatedButton(
                key: const Key('btn_finish'),
                onPressed: () {
                  notifier.reset();
                  if (Navigator.of(context).canPop()) {
                    Navigator.of(context).pop();
                  }
                }, 
                child: const Text('Go to Login'),
              ),
            ],
          ),
        ),
      );
    }

    if (state.status == AgentOnboardingStatus.livenessCheck) {
      return Scaffold(
        appBar: AppBar(title: const Text('Face AI Liveness')),
        body: Center(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Container(
                width: 240,
                height: 240,
                decoration: BoxDecoration(
                  color: Colors.black,
                  shape: BoxShape.circle,
                  border: Border.all(color: Colors.blue, width: 4),
                ),
                child: const Icon(Icons.face, size: 100, color: Colors.white),
              ),
              const SizedBox(height: 32),
              const Text('Please BLINK TWICE', style: TextStyle(fontSize: 24, fontWeight: FontWeight.bold, color: Colors.blue)),
              const SizedBox(height: 16),
              const Text('Front camera is active for liveness detection.', style: TextStyle(color: Colors.grey)),
              const SizedBox(height: 48),
              const CircularProgressIndicator(),
            ],
          ),
        ),
      );
    }

    if (state.status == AgentOnboardingStatus.manualReview) {
      return Scaffold(
        appBar: AppBar(title: const Text('Pending Review')),
        body: Center(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              const Icon(Icons.timer, color: Colors.orange, size: 80),
              const Text('Registration Queued', style: TextStyle(fontSize: 22, fontWeight: FontWeight.bold)),
              const SizedBox(height: 16),
              const Padding(
                padding: EdgeInsets.symmetric(horizontal: 40),
                child: Text('Bank Officer will contact you', textAlign: TextAlign.center),
              ),
              const SizedBox(height: 48),
              ElevatedButton(
                key: const Key('btn_finish'),
                onPressed: () {
                  notifier.reset();
                  if (Navigator.of(context).canPop()) {
                    Navigator.of(context).pop();
                  }
                },
                child: const Text('Finish'),
              ),
            ],
          ),
        ),
      );
    }

    return Scaffold(
      appBar: AppBar(title: const Text('Agent Self-Onboarding')),
      body: SingleChildScrollView(
        padding: const EdgeInsets.all(24.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            // STEP 1: MYKAD
            const Text('Step 1: Scan MyKad', style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold)),
            const SizedBox(height: 8),
            ListTile(
              leading: Icon(state.myKadNumber != null ? Icons.check_circle : Icons.badge, color: state.myKadNumber != null ? Colors.green : null),
              title: Text(state.myKadNumber ?? 'Scan Customer MyKad'),
              trailing: ElevatedButton(
                key: const Key('btn_scan_mykad'),
                onPressed: state.status == AgentOnboardingStatus.idle ? () => notifier.scanMyKad() : null,
                child: const Text('Scan'),
              ),
            ),
            const Divider(height: 32),

            // STEP 2: PHONE & OTP
            const Text('Step 2: Phone Verification', style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold)),
            const SizedBox(height: 16),
            if (!state.otpVerified) ...[
              TextField(
                key: const Key('field_phone'),
                controller: _phoneController,
                keyboardType: TextInputType.phone,
                enabled: state.myKadNumber != null && state.status == AgentOnboardingStatus.idle,
                decoration: InputDecoration(
                  labelText: 'Mobile Number',
                  prefixIcon: const Icon(Icons.phone_android),
                  suffixIcon: IconButton(
                    icon: state.status == AgentOnboardingStatus.requestingOtp 
                      ? const SizedBox(width: 20, height: 20, child: CircularProgressIndicator(strokeWidth: 2))
                      : const Icon(Icons.send),
                    onPressed: (state.myKadNumber != null && state.status == AgentOnboardingStatus.idle)
                      ? () => notifier.requestOtp(_phoneController.text)
                      : null,
                  ),
                ),
              ),
              if (state.status == AgentOnboardingStatus.waitingOtp || state.status == AgentOnboardingStatus.verifyingOtp) ...[
                const SizedBox(height: 16),
                TextField(
                  key: const Key('field_otp'),
                  controller: _otpController,
                  keyboardType: TextInputType.number,
                  maxLength: 6,
                  decoration: InputDecoration(
                    labelText: 'Enter 6-digit OTP',
                    suffixIcon: TextButton(
                      onPressed: state.status == AgentOnboardingStatus.waitingOtp
                        ? () => notifier.verifyOtp(_otpController.text)
                        : null,
                      child: state.status == AgentOnboardingStatus.verifyingOtp
                        ? const SizedBox(width: 20, height: 20, child: CircularProgressIndicator(strokeWidth: 2))
                        : const Text('Verify'),
                    ),
                  ),
                ),
              ],
            ] else ...[
              ListTile(
                leading: const Icon(Icons.check_circle, color: Colors.green),
                title: Text('Phone Verified: ${state.phoneNumber}'),
              ),
            ],
            const Divider(height: 32),

            // STEP 3: BUSINESS REGISTRATION
            const Text('Step 3: Business Registration', style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold)),
            const SizedBox(height: 16),
            TextField(
              key: const Key('field_ssm'),
              controller: _ssmController,
              enabled: state.otpVerified && state.status == AgentOnboardingStatus.idle,
              decoration: const InputDecoration(
                labelText: 'SSM Registration Number',
                hintText: 'e.g. 202301012345',
                border: OutlineInputBorder(),
              ),
            ),
            const SizedBox(height: 48),
            SizedBox(
              width: double.infinity,
              height: 55,
              child: ElevatedButton(
                style: ElevatedButton.styleFrom(backgroundColor: Colors.blue.shade900, foregroundColor: Colors.white),
                onPressed: (state.otpVerified && state.status == AgentOnboardingStatus.idle)
                  ? () => notifier.submitOnboarding(_ssmController.text)
                  : null,
                child: state.status == AgentOnboardingStatus.submitting
                  ? const CircularProgressIndicator(color: Colors.white)
                  : const Text('Submit for Instant Activation'),
              ),
            ),
            if (state.errorMessage != null) ...[
              const SizedBox(height: 16),
              Text(state.errorMessage!, style: const TextStyle(color: Colors.red)),
            ],
          ],
        ),
      ),
    );
  }
}
