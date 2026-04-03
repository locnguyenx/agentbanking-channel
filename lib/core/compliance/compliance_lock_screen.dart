import 'package:flutter/material.dart';

class ComplianceLockScreen extends StatelessWidget {
  const ComplianceLockScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return WillPopScope(
      onWillPop: () async => false, // Prevent back button
      child: Container(
        color: Colors.red.shade900,
        child: Scaffold(
          backgroundColor: Colors.transparent,
          body: Center(
            child: Padding(
              padding: const EdgeInsets.all(40.0),
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  const Icon(Icons.lock_person, size: 100, color: Colors.white),
                  const SizedBox(height: 30),
                  const Text(
                    'COMPLIANCE REVIEW',
                    style: TextStyle(
                      color: Colors.white,
                      fontSize: 28,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                  const SizedBox(height: 10),
                  const Text(
                    'TERMINAL LOCKED',
                    style: TextStyle(
                      color: Colors.white70,
                      fontSize: 18,
                    ),
                  ),
                  const SizedBox(height: 20),
                  const Text(
                    'This device has been restricted for compliance reasons. Dial 1-800-XXX-XXXX for support.',
                    textAlign: TextAlign.center,
                    style: TextStyle(color: Colors.white70, fontSize: 16),
                  ),
                  const SizedBox(height: 50),
                  const Text(
                    'Error Code: ERR_BIZ_COMPLIANCE_FREEZE',
                    style: TextStyle(color: Colors.black26, fontSize: 12),
                  ),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }
}
