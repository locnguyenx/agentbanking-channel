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

  @override
  void dispose() {
    _ssmController.dispose();
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
                child: Text('Your Agent ID has been activated. Float account RM 0.00 created.', textAlign: TextAlign.center),
              ),
              const SizedBox(height: 48),
              ElevatedButton(onPressed: () => notifier.reset(), child: const Text('Go to Login')),
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
                child: Text('Your application requires manual compliance review due to regional risk policy. We will notify you via SMS within 24 hours.', textAlign: TextAlign.center),
              ),
              const SizedBox(height: 48),
              ElevatedButton(onPressed: () => notifier.reset(), child: const Text('Finish')),
            ],
          ),
        ),
      );
    }

    return Scaffold(
      appBar: AppBar(title: const Text('Agent Self-Onboarding')),
      body: Padding(
        padding: const EdgeInsets.all(24.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            const Text('Step 1: Scan MyKad', style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold)),
            const SizedBox(height: 8),
            ListTile(
              leading: Icon(state.myKadNumber != null ? Icons.check_circle : Icons.badge, color: state.myKadNumber != null ? Colors.green : null),
              title: Text(state.myKadNumber ?? 'Scan Customer MyKad'),
              trailing: ElevatedButton(
                onPressed: state.status == AgentOnboardingStatus.idle ? () => notifier.scanMyKad() : null,
                child: const Text('Scan'),
              ),
            ),
            const Divider(height: 48),
            const Text('Step 2: Business Registration', style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold)),
            const SizedBox(height: 16),
            TextField(
              controller: _ssmController,
              decoration: const InputDecoration(
                labelText: 'SSM Registration Number',
                hintText: 'e.g. 202301012345',
                border: OutlineInputBorder(),
              ),
            ),
            const Spacer(),
            SizedBox(
              width: double.infinity,
              height: 55,
              child: ElevatedButton(
                style: ElevatedButton.styleFrom(backgroundColor: Colors.blue.shade900, foregroundColor: Colors.white),
                onPressed: (state.myKadNumber != null && state.status == AgentOnboardingStatus.idle)
                  ? () => notifier.submitOnboarding(_ssmController.text)
                  : null,
                child: state.status == AgentOnboardingStatus.submitting
                  ? const CircularProgressIndicator(color: Colors.white)
                  : const Text('Submit for Instant Activation'),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
