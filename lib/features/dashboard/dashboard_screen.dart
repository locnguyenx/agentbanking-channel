import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:agentbanking_channel/features/auth/login_screen.dart';
import 'package:agentbanking_channel/features/auth/providers/auth_provider.dart';
import 'package:agentbanking_channel/features/transactions/screens/transaction_flow_screen.dart';
import 'package:agentbanking_channel/features/kyc/screens/kyc_flow_screen.dart';
import 'package:agentbanking_channel/core/offline/widgets/offline_indicator.dart';
import 'package:agentbanking_channel/features/settlement/providers/float_provider.dart';
import 'package:intl/intl.dart';
import 'package:agentbanking_channel/features/transactions/screens/bill_payment_form.dart';
import 'package:agentbanking_channel/features/transactions/screens/topup_form.dart';
import 'package:agentbanking_channel/features/transactions/providers/transaction_provider.dart';

class DashboardScreen extends ConsumerWidget {
  const DashboardScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final authState = ref.watch(authProvider);
    final floatState = ref.watch(floatProvider);
    final agentName = authState.user?.name ?? 'Agent';
    final agentTier = authState.user?.tier ?? 'Silver';
    
    final currencyFormat = NumberFormat.currency(symbol: 'RM ', decimalDigits: 2);
    final balanceStr = currencyFormat.format(floatState.currentBalance.toDouble());
    
    final bool isTablet = MediaQuery.of(context).size.width >= 600;
    final double horizontalPadding = isTablet ? 40.0 : 24.0;

    return Scaffold(
      backgroundColor: const Color(0xFFF8F9FA),
      appBar: AppBar(
        title: const Text('Agent Dashboard', style: TextStyle(fontWeight: FontWeight.bold, fontSize: 18)),
        backgroundColor: Colors.white,
        elevation: 0,
        centerTitle: false,
        actions: [
          IconButton(
            icon: const Icon(Icons.logout, size: 20),
            onPressed: () {
              ref.read(authProvider.notifier).logout();
              Navigator.of(context).pushReplacement(
                MaterialPageRoute(builder: (_) => const LoginScreen()),
              );
            },
          ),
          const Padding(
            padding: EdgeInsets.only(right: 8.0),
            child: OfflineIndicator(),
          ),
        ],
      ),
      body: SingleChildScrollView(
        padding: EdgeInsets.all(horizontalPadding),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            _buildAgentHeader(context, ref, agentName, agentTier, balanceStr, isTablet),
            SizedBox(height: isTablet ? 48 : 32),
            Text('QUICK ACTIONS', style: TextStyle(fontSize: isTablet ? 14 : 12, fontWeight: FontWeight.bold, color: Colors.grey, letterSpacing: 1.2)),
            const SizedBox(height: 16),
            _buildQuickActionsGrid(context, ref, isTablet),
            SizedBox(height: isTablet ? 48 : 32),
            Text('SERVICES', style: TextStyle(fontSize: isTablet ? 14 : 12, fontWeight: FontWeight.bold, color: Colors.grey, letterSpacing: 1.2)),
            const SizedBox(height: 16),
            _buildServicesRow(context, ref, isTablet),
            SizedBox(height: isTablet ? 48 : 32),
            _buildRecentActivity(context, ref, isTablet),
          ],
        ),
      ),
    );
  }

  Widget _buildAgentHeader(BuildContext context, WidgetRef ref, String name, String tier, String balance, bool isTablet) {
    return Container(
      width: double.infinity,
      padding: EdgeInsets.all(isTablet ? 40 : 24),
      decoration: BoxDecoration(
        gradient: const LinearGradient(
          colors: [Color(0xFF1A237E), Color(0xFF3949AB)],
          begin: Alignment.topLeft,
          end: Alignment.bottomRight,
        ),
        borderRadius: BorderRadius.circular(isTablet ? 40 : 32),
        boxShadow: [
          BoxShadow(
            color: const Color(0xFF1A237E).withOpacity(0.3),
            blurRadius: 20,
            offset: const Offset(0, 10),
          ),
        ],
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text('Welcome back,', style: TextStyle(color: Colors.white.withOpacity(0.8), fontSize: isTablet ? 16 : 14)),
                  const SizedBox(height: 4),
                  Text(name, style: TextStyle(color: Colors.white, fontSize: isTablet ? 32 : 24, fontWeight: FontWeight.bold)),
                ],
              ),
              Container(
                padding: EdgeInsets.symmetric(horizontal: isTablet ? 16 : 12, vertical: isTablet ? 8 : 6),
                decoration: BoxDecoration(
                  color: Colors.white.withOpacity(0.2),
                  borderRadius: BorderRadius.circular(20),
                ),
                child: Text(tier, style: TextStyle(color: Colors.white, fontWeight: FontWeight.bold, fontSize: isTablet ? 14 : 12)),
              ),
            ],
          ),
          SizedBox(height: isTablet ? 48 : 32),
          Wrap(
            spacing: isTablet ? 40 : 24,
            runSpacing: 16,
            children: [
              _buildStatItem('Current Float', balance, isTablet),
              _buildStatItem('Commission', 'RM 450.25', isTablet),
            ],
          ),
        ],
      ),
    );
  }

  Widget _buildStatItem(String label, String value, bool isTablet) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(label, style: TextStyle(color: Colors.white.withOpacity(0.7), fontSize: isTablet ? 14 : 12)),
        const SizedBox(height: 4),
        Text(value, style: TextStyle(color: Colors.white, fontSize: isTablet ? 24 : 18, fontWeight: FontWeight.bold)),
      ],
    );
  }

  Widget _buildQuickActionsGrid(BuildContext context, WidgetRef ref, bool isTablet) {
    return GridView.count(
      shrinkWrap: true,
      physics: const NeverScrollableScrollPhysics(),
      crossAxisCount: isTablet ? 2 : 2,
      childAspectRatio: isTablet ? 3.5 : 2.5,
      crossAxisSpacing: 16,
      mainAxisSpacing: 16,
      children: [
        _buildActionCard(context, ref, 'Withdrawal', Icons.outbox, Colors.blue, 'CASH_WITHDRAWAL', isTablet),
        _buildActionCard(context, ref, 'Deposit', Icons.move_to_inbox, Colors.green, 'CASH_DEPOSIT', isTablet),
      ],
    );
  }

  Widget _buildActionCard(BuildContext context, WidgetRef ref, String title, IconData icon, Color color, String serviceCode, bool isTablet) {
    return InkWell(
      onTap: () {
        ref.read(transactionProvider.notifier).reset();
        Navigator.push(context, MaterialPageRoute(builder: (_) => TransactionFlowScreen(title: title, serviceCode: serviceCode)));
      },
      child: Container(
        padding: EdgeInsets.all(isTablet ? 20 : 16),
        decoration: BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.circular(isTablet ? 28 : 24),
          border: Border.all(color: Colors.grey.shade200),
        ),
        child: Row(
          children: [
            Container(
              padding: EdgeInsets.all(isTablet ? 12 : 8),
              decoration: BoxDecoration(color: color.withOpacity(0.1), borderRadius: BorderRadius.circular(12)),
              child: Icon(icon, color: color, size: isTablet ? 28 : 20),
            ),
            SizedBox(width: isTablet ? 16 : 12),
            Text(title, style: TextStyle(fontWeight: FontWeight.bold, fontSize: isTablet ? 18 : 14)),
          ],
        ),
      ),
    );
  }

  Widget _buildServicesRow(BuildContext context, WidgetRef ref, bool isTablet) {
    return Center(
      child: ConstrainedBox(
        constraints: BoxConstraints(maxWidth: isTablet ? 900 : 600),
        child: GridView.count(
          shrinkWrap: true,
          physics: const NeverScrollableScrollPhysics(),
          crossAxisCount: isTablet ? 4 : 4,
          mainAxisSpacing: isTablet ? 32 : 24,
          crossAxisSpacing: 16,
          childAspectRatio: isTablet ? 0.85 : 0.60,
          children: [
            _buildCircularService(
              context,
              'Inquiry',
              Icons.search,
              Colors.blue,
              () {
                ref.read(transactionProvider.notifier).reset();
                Navigator.push(context, MaterialPageRoute(builder: (_) => const TransactionFlowScreen(title: 'Balance Inquiry', serviceCode: 'BALANCE_INQUIRY')));
              },
              isTablet,
            ),
            _buildCircularService(
              context,
              'Onboard',
              Icons.person_add,
              Colors.orange,
              () => Navigator.push(context, MaterialPageRoute(builder: (_) => const KycFlowScreen())),
              isTablet,
              key: const Key('btn_onboard'),
            ),
            _buildCircularService(
              context,
              'Top-up',
              Icons.phone_android,
              Colors.red,
              () {
                ref.read(transactionProvider.notifier).reset();
                Navigator.push(context, MaterialPageRoute(builder: (_) => const TransactionFlowScreen(title: 'Prepaid Topup', serviceCode: 'TOP_UP')));
              },
              isTablet,
            ),
            _buildCircularService(
              context,
              'Bills',
              Icons.receipt_long,
              Colors.purple,
              () {
                ref.read(transactionProvider.notifier).reset();
                Navigator.push(context, MaterialPageRoute(builder: (_) => const TransactionFlowScreen(title: 'Bill Payment', serviceCode: 'BILL_PAY')));
              },
              isTablet,
              key: const Key('btn_bills'),
            ),
            _buildCircularService(
              context,
              'E-Wallet',
              Icons.account_balance_wallet,
              Colors.teal,
              () {
                ref.read(transactionProvider.notifier).reset();
                Navigator.push(context, MaterialPageRoute(builder: (_) => const TransactionFlowScreen(title: 'Sarawak Pay', serviceCode: 'SARAWAK_PAY')));
              },
              isTablet,
              key: const Key('btn_sarawak'),
            ),
            _buildCircularService(
              context,
              'Cashless',
              Icons.qr_code_scanner,
              Colors.deepPurple,
              () {
                ref.read(transactionProvider.notifier).reset();
                Navigator.push(context, MaterialPageRoute(builder: (_) => const TransactionFlowScreen(title: 'Cashless Payment', serviceCode: 'CASHLESS_PAY')));
              },
              isTablet,
              key: const Key('btn_cashless'),
            ),
            _buildCircularService(
              context,
              'eSSP',
              Icons.card_membership,
              Colors.amber,
              () {
                ref.read(transactionProvider.notifier).reset();
                Navigator.push(context, MaterialPageRoute(builder: (_) => const TransactionFlowScreen(title: 'eSSP Purchase', serviceCode: 'ESSP_PURCHASE')));
              },
              isTablet,
              key: const Key('btn_essp'),
            ),
            _buildCircularService(
              context,
              'JomPAY',
              Icons.payments,
              Colors.redAccent,
              () {
                ref.read(transactionProvider.notifier).reset();
                Navigator.push(context, MaterialPageRoute(builder: (_) => const TransactionFlowScreen(title: 'JomPAY', serviceCode: 'JOMPAY')));
              },
              isTablet,
              key: const Key('btn_jompay'),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildCircularService(BuildContext context, String title, IconData icon, Color color, VoidCallback onTap, bool isTablet, {Key? key}) {
    final double size = isTablet ? 84 : 60;
    return Column(
      crossAxisAlignment: CrossAxisAlignment.center,
      children: [
        InkWell(
          key: key,
          onTap: onTap,
          borderRadius: BorderRadius.circular(size / 2),
          child: Container(
            width: size,
            height: size,
            decoration: BoxDecoration(
              color: color.withOpacity(0.1),
              shape: BoxShape.circle,
            ),
            child: Icon(icon, color: color, size: isTablet ? 40 : 28),
          ),
        ),
        const SizedBox(height: 8),
        Text(
          title, 
          textAlign: TextAlign.center,
          maxLines: 1,
          overflow: TextOverflow.ellipsis,
          style: TextStyle(fontSize: isTablet ? 16 : 12, fontWeight: FontWeight.w500),
        ),
      ],
    );
  }

  Widget _buildRecentActivity(BuildContext context, WidgetRef ref, bool isTablet) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Text('RECENT ACTIVITY', style: TextStyle(fontSize: isTablet ? 14 : 12, fontWeight: FontWeight.bold, color: Colors.grey, letterSpacing: 1.2)),
            TextButton(onPressed: () {}, child: Text('See All', style: TextStyle(fontSize: isTablet ? 14 : 12))),
          ],
        ),
        const SizedBox(height: 8),
        _buildActivityItem('Cash Withdrawal', 'RM 200.00', 'Success', '2 mins ago', Icons.outbox, Colors.blue, isTablet),
        _buildActivityItem('Cash Deposit', 'RM 1,500.00', 'Success', '15 mins ago', Icons.move_to_inbox, Colors.green, isTablet),
        _buildActivityItem('Balance Inquiry', '---', 'Success', '1 hour ago', Icons.search, Colors.blue, isTablet),
      ],
    );
  }

  Widget _buildActivityItem(String title, String amount, String status, String time, IconData icon, Color color, bool isTablet) {
    return Container(
      margin: const EdgeInsets.only(bottom: 12),
      padding: EdgeInsets.all(isTablet ? 20 : 16),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(isTablet ? 24 : 20),
        border: Border.all(color: Colors.grey.shade100),
      ),
      child: Row(
        children: [
          Container(
            padding: EdgeInsets.all(isTablet ? 14 : 10),
            decoration: BoxDecoration(color: color.withOpacity(0.1), shape: BoxShape.circle),
            child: Icon(icon, color: color, size: isTablet ? 28 : 20),
          ),
          SizedBox(width: isTablet ? 20 : 16),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(title, style: TextStyle(fontWeight: FontWeight.bold, fontSize: isTablet ? 18 : 14)),
                Text(time, style: TextStyle(color: Colors.grey, fontSize: isTablet ? 14 : 12)),
              ],
            ),
          ),
          Column(
            crossAxisAlignment: CrossAxisAlignment.end,
            children: [
              Text(amount, style: TextStyle(fontWeight: FontWeight.bold, fontSize: isTablet ? 18 : 14)),
              Text(status, style: TextStyle(color: status == 'Success' ? Colors.green : Colors.red, fontSize: isTablet ? 14 : 12, fontWeight: FontWeight.w500)),
            ],
          ),
        ],
      ),
    );
  }
}
