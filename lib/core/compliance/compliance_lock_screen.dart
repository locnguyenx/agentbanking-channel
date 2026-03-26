import 'package:flutter/material.dart';

class ComplianceLockScreen extends StatelessWidget {
  const ComplianceLockScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return WillPopScope(
      onWillPop: () async => false, // Prevent back button
      child: Scaffold(
        backgroundColor: Colors.red.shade900,
        body: Center(
          child: Padding(
            padding: const EdgeInsets.all(40.0),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                const Icon(Icons.lock_person, size: 100, color: Colors.white),
                const SizedBox(height: 30),
                const Text(
                  'TERMINAL LOCKED',
                  style: TextStyle(
                    color: Colors.white,
                    fontSize: 28,
                    fontWeight: FontWeight.bold,
                  ),
                ),
                const SizedBox(height: 20),
                const Text(
                  'This device has been restricted for compliance reasons. Please contact your Bank Manager for assistance.',
                  textAlign: TextAlign.center,
                  style: TextStyle(color: Colors.white70, fontSize: 16),
                ),
                const SizedBox(height: 50),
                const Text(
                  'Error Code: ERR_COMPLIANCE_FREEZE',
                  style: TextStyle(color: Colors.black26, fontSize: 12),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
