import 'package:flutter/material.dart';

void main() => runApp(const ClearPathApp());

class ClearPathApp extends StatelessWidget {
  const ClearPathApp({super.key});

  @override
  Widget build(BuildContext context) {
    const ink = Color(0xFF132B2F);
    const mint = Color(0xFF7FC6B5);
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'ClearPath',
      theme: ThemeData(
        useMaterial3: true,
        colorScheme: ColorScheme.fromSeed(
          seedColor: mint,
          primary: ink,
          surface: const Color(0xFFF8F7F2),
        ),
        scaffoldBackgroundColor: const Color(0xFFF8F7F2),
        navigationBarTheme: const NavigationBarThemeData(
          backgroundColor: Colors.white,
          indicatorColor: Color(0xFFDDF2EB),
        ),
        cardTheme: CardThemeData(
          elevation: 0,
          color: Colors.white,
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(24),
          ),
        ),
        inputDecorationTheme: InputDecorationTheme(
          filled: true,
          fillColor: const Color(0xFFF1F0EA),
          border: OutlineInputBorder(
            borderSide: BorderSide.none,
            borderRadius: BorderRadius.circular(16),
          ),
        ),
      ),
      home: const MoneyHome(),
    );
  }
}

class MoneyHome extends StatefulWidget {
  const MoneyHome({super.key});
  @override
  State<MoneyHome> createState() => _MoneyHomeState();
}

class _MoneyHomeState extends State<MoneyHome> {
  int _tab = 0;
  final List<Bill> _bills = [
    Bill('Rent', 1450, 1, Icons.home_rounded, const Color(0xFFE7E0F8)),
    Bill('Amex', 286.42, 8, Icons.credit_card_rounded, const Color(0xFFFFE2D3)),
    Bill('Internet', 65, 12, Icons.wifi_rounded, const Color(0xFFDCEEF8)),
    Bill(
      'Car insurance',
      134,
      18,
      Icons.directions_car_rounded,
      const Color(0xFFE3F2DB),
    ),
  ];

  @override
  Widget build(BuildContext context) {
    final pages = [
      Dashboard(onPurchaseCheck: _showPurchaseCheck, onConnect: _showConnect),
      PlanPage(onPurchaseCheck: _showPurchaseCheck),
      BillsPage(bills: _bills, onAdd: _showAddBill),
      const ProfilePage(),
    ];
    return Scaffold(
      body: SafeArea(
        child: IndexedStack(index: _tab, children: pages),
      ),
      bottomNavigationBar: NavigationBar(
        selectedIndex: _tab,
        onDestinationSelected: (value) => setState(() => _tab = value),
        destinations: const [
          NavigationDestination(
            icon: Icon(Icons.home_outlined),
            selectedIcon: Icon(Icons.home_rounded),
            label: 'Today',
          ),
          NavigationDestination(
            icon: Icon(Icons.donut_large_outlined),
            selectedIcon: Icon(Icons.donut_large_rounded),
            label: 'Plan',
          ),
          NavigationDestination(
            icon: Icon(Icons.receipt_long_outlined),
            selectedIcon: Icon(Icons.receipt_long_rounded),
            label: 'Bills',
          ),
          NavigationDestination(
            icon: Icon(Icons.person_outline_rounded),
            selectedIcon: Icon(Icons.person_rounded),
            label: 'You',
          ),
        ],
      ),
    );
  }

  void _showPurchaseCheck() => showModalBottomSheet<void>(
    context: context,
    isScrollControlled: true,
    backgroundColor: Colors.transparent,
    builder: (_) => const PurchaseCheckSheet(),
  );
  void _showConnect() => showModalBottomSheet<void>(
    context: context,
    backgroundColor: Colors.transparent,
    builder: (_) => const ConnectSheet(),
  );
  void _showAddBill() async {
    final result = await showModalBottomSheet<Bill>(
      context: context,
      isScrollControlled: true,
      backgroundColor: Colors.transparent,
      builder: (_) => const AddBillSheet(),
    );
    if (result != null) setState(() => _bills.add(result));
  }
}

class PageShell extends StatelessWidget {
  const PageShell({super.key, required this.child});
  final Widget child;
  @override
  Widget build(BuildContext context) => SingleChildScrollView(
    padding: const EdgeInsets.fromLTRB(20, 16, 20, 30),
    child: child,
  );
}

class Dashboard extends StatelessWidget {
  const Dashboard({
    super.key,
    required this.onPurchaseCheck,
    required this.onConnect,
  });
  final VoidCallback onPurchaseCheck;
  final VoidCallback onConnect;

  @override
  Widget build(BuildContext context) => PageShell(
    child: Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Row(
          children: [
            Container(
              width: 42,
              height: 42,
              decoration: BoxDecoration(
                color: const Color(0xFF132B2F),
                borderRadius: BorderRadius.circular(14),
              ),
              child: const Icon(Icons.route_rounded, color: Color(0xFFB9E4D7)),
            ),
            const SizedBox(width: 12),
            const Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    'Good morning, Amir',
                    style: TextStyle(fontWeight: FontWeight.w700, fontSize: 19),
                  ),
                  Text(
                    'Your money is looking steady.',
                    style: TextStyle(color: Color(0xFF657477), fontSize: 13),
                  ),
                ],
              ),
            ),
            IconButton(
              onPressed: () {},
              icon: const Icon(Icons.notifications_none_rounded),
            ),
          ],
        ),
        const SizedBox(height: 24),
        Container(
          padding: const EdgeInsets.all(24),
          decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(28),
            gradient: const LinearGradient(
              colors: [Color(0xFF173E41), Color(0xFF10292D)],
              begin: Alignment.topLeft,
              end: Alignment.bottomRight,
            ),
          ),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              const Row(
                children: [
                  Text(
                    'SAFE TO SPEND',
                    style: TextStyle(
                      color: Color(0xFF9FC4BC),
                      fontWeight: FontWeight.w700,
                      fontSize: 12,
                      letterSpacing: 1.2,
                    ),
                  ),
                  Spacer(),
                  Icon(
                    Icons.shield_outlined,
                    color: Color(0xFF9FC4BC),
                    size: 20,
                  ),
                ],
              ),
              const SizedBox(height: 8),
              const Text(
                '\$642',
                style: TextStyle(
                  color: Colors.white,
                  fontWeight: FontWeight.w800,
                  fontSize: 46,
                  letterSpacing: -1.5,
                ),
              ),
              const Text(
                'until Friday, Oct 30',
                style: TextStyle(color: Color(0xFFBDD1CC)),
              ),
              const SizedBox(height: 22),
              ClipRRect(
                borderRadius: BorderRadius.circular(20),
                child: const LinearProgressIndicator(
                  value: .58,
                  minHeight: 8,
                  backgroundColor: Color(0xFF315356),
                  valueColor: AlwaysStoppedAnimation(Color(0xFF8BD3C0)),
                ),
              ),
              const SizedBox(height: 10),
              const Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Text(
                    '\$358 spent',
                    style: TextStyle(color: Color(0xFFBDD1CC), fontSize: 12),
                  ),
                  Text(
                    '\$1,000 weekly plan',
                    style: TextStyle(color: Color(0xFFBDD1CC), fontSize: 12),
                  ),
                ],
              ),
            ],
          ),
        ),
        const SizedBox(height: 14),
        SizedBox(
          width: double.infinity,
          child: FilledButton.icon(
            onPressed: onPurchaseCheck,
            style: FilledButton.styleFrom(
              backgroundColor: const Color(0xFFEBA16B),
              foregroundColor: const Color(0xFF2E1D13),
              padding: const EdgeInsets.all(17),
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(18),
              ),
            ),
            icon: const Icon(Icons.auto_awesome_rounded),
            label: const Text(
              'Can I afford something?',
              style: TextStyle(fontWeight: FontWeight.w800),
            ),
          ),
        ),
        const SizedBox(height: 24),
        const SectionTitle('ClearPath insight', action: 'Based on your plan'),
        const SizedBox(height: 10),
        const InsightCard(),
        const SizedBox(height: 24),
        const SectionTitle('Your accounts', action: '\$8,941 total'),
        const SizedBox(height: 10),
        const AccountTile(
          icon: Icons.account_balance_rounded,
          name: 'Everyday checking',
          subtitle: '•• 2048',
          amount: '\$3,842.16',
          color: Color(0xFFDDF2EB),
        ),
        const SizedBox(height: 9),
        const AccountTile(
          icon: Icons.credit_card_rounded,
          name: 'Amex Blue Cash',
          subtitle: '\$2,713 available',
          amount: '-\$286.42',
          color: Color(0xFFFFE5D5),
        ),
        const SizedBox(height: 9),
        OutlinedButton.icon(
          onPressed: onConnect,
          style: OutlinedButton.styleFrom(
            minimumSize: const Size(double.infinity, 54),
            side: const BorderSide(color: Color(0xFFD6DAD5)),
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(18),
            ),
          ),
          icon: const Icon(Icons.add_rounded),
          label: const Text('Connect another account'),
        ),
        const SizedBox(height: 24),
        const SectionTitle('Coming up', action: 'See all'),
        const SizedBox(height: 10),
        const MiniBill(
          name: 'Amex payment',
          date: 'Oct 28',
          amount: '\$286.42',
          icon: Icons.credit_card_rounded,
        ),
        const MiniBill(
          name: 'Rent',
          date: 'Nov 1',
          amount: '\$1,450.00',
          icon: Icons.home_rounded,
        ),
      ],
    ),
  );
}

class PlanPage extends StatelessWidget {
  const PlanPage({super.key, required this.onPurchaseCheck});
  final VoidCallback onPurchaseCheck;
  @override
  Widget build(BuildContext context) => PageShell(
    child: Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        const Text(
          'Your plan',
          style: TextStyle(
            fontSize: 30,
            fontWeight: FontWeight.w800,
            letterSpacing: -1,
          ),
        ),
        const SizedBox(height: 4),
        const Text(
          'October 23 – November 22',
          style: TextStyle(color: Color(0xFF687577)),
        ),
        const SizedBox(height: 22),
        Card(
          child: Padding(
            padding: const EdgeInsets.all(22),
            child: Column(
              children: [
                const Row(
                  children: [
                    Expanded(
                      child: Metric(
                        label: 'Income',
                        value: '\$5,400',
                        color: Color(0xFF2A7E6A),
                      ),
                    ),
                    SizedBox(height: 46, child: VerticalDivider()),
                    Expanded(
                      child: Metric(
                        label: 'Committed',
                        value: '\$3,248',
                        color: Color(0xFFBA6443),
                      ),
                    ),
                  ],
                ),
                const Divider(height: 32),
                Row(
                  children: [
                    const Expanded(
                      child: Metric(
                        label: 'Left to plan',
                        value: '\$2,152',
                        color: Color(0xFF132B2F),
                      ),
                    ),
                    FilledButton(
                      onPressed: onPurchaseCheck,
                      child: const Text('Check item'),
                    ),
                  ],
                ),
              ],
            ),
          ),
        ),
        const SizedBox(height: 24),
        const SectionTitle('Spending plan', action: '58% used'),
        const SizedBox(height: 12),
        const BudgetRow(
          'Food & dining',
          420,
          650,
          Icons.restaurant_rounded,
          Color(0xFFFFDCCB),
        ),
        const BudgetRow(
          'Shopping',
          188,
          300,
          Icons.shopping_bag_rounded,
          Color(0xFFE7E0F8),
        ),
        const BudgetRow(
          'Transport',
          96,
          240,
          Icons.directions_car_rounded,
          Color(0xFFDDECF5),
        ),
        const BudgetRow('Fun', 72, 200, Icons.movie_rounded, Color(0xFFE1F0DA)),
        const SizedBox(height: 10),
        const Card(
          color: Color(0xFFFFF0E3),
          child: Padding(
            padding: EdgeInsets.all(18),
            child: Row(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Icon(Icons.lightbulb_outline_rounded, color: Color(0xFF9F542F)),
                SizedBox(width: 12),
                Expanded(
                  child: Text(
                    'Dining is moving faster than usual. Cooking twice this week keeps an extra \$84 in your cushion.',
                    style: TextStyle(height: 1.4),
                  ),
                ),
              ],
            ),
          ),
        ),
      ],
    ),
  );
}

class BillsPage extends StatelessWidget {
  const BillsPage({super.key, required this.bills, required this.onAdd});
  final List<Bill> bills;
  final VoidCallback onAdd;
  @override
  Widget build(BuildContext context) => PageShell(
    child: Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Row(
          children: [
            const Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    'Bills',
                    style: TextStyle(
                      fontSize: 30,
                      fontWeight: FontWeight.w800,
                      letterSpacing: -1,
                    ),
                  ),
                  Text(
                    'Nothing sneaks up on you.',
                    style: TextStyle(color: Color(0xFF687577)),
                  ),
                ],
              ),
            ),
            FilledButton.icon(
              onPressed: onAdd,
              icon: const Icon(Icons.add_rounded),
              label: const Text('Add'),
            ),
          ],
        ),
        const SizedBox(height: 22),
        Container(
          padding: const EdgeInsets.all(20),
          decoration: BoxDecoration(
            color: const Color(0xFFDDF2EB),
            borderRadius: BorderRadius.circular(22),
          ),
          child: const Row(
            children: [
              Icon(
                Icons.event_available_rounded,
                color: Color(0xFF216D5B),
                size: 34,
              ),
              SizedBox(width: 14),
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      '\$1,936.42 due next',
                      style: TextStyle(
                        fontWeight: FontWeight.w800,
                        fontSize: 19,
                      ),
                    ),
                    Text(
                      'You’re covered with \$417 left over.',
                      style: TextStyle(color: Color(0xFF3C655D)),
                    ),
                  ],
                ),
              ),
            ],
          ),
        ),
        const SizedBox(height: 24),
        SectionTitle('Upcoming', action: '${bills.length} bills'),
        const SizedBox(height: 10),
        ...bills.map(
          (bill) => Padding(
            padding: const EdgeInsets.only(bottom: 9),
            child: Card(
              child: ListTile(
                contentPadding: const EdgeInsets.symmetric(
                  horizontal: 16,
                  vertical: 7,
                ),
                leading: RoundedIcon(icon: bill.icon, color: bill.color),
                title: Text(
                  bill.name,
                  style: const TextStyle(fontWeight: FontWeight.w700),
                ),
                subtitle: Text(
                  'Due ${bill.day == 1 ? 'Nov' : 'Oct'} ${bill.day} • Auto-detected',
                ),
                trailing: Text(
                  '\$${bill.amount.toStringAsFixed(2)}',
                  style: const TextStyle(fontWeight: FontWeight.w800),
                ),
              ),
            ),
          ),
        ),
        const SizedBox(height: 10),
        OutlinedButton.icon(
          onPressed: onAdd,
          style: OutlinedButton.styleFrom(
            minimumSize: const Size(double.infinity, 56),
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(18),
            ),
          ),
          icon: const Icon(Icons.document_scanner_outlined),
          label: const Text('Upload or scan a bill'),
        ),
      ],
    ),
  );
}

class ProfilePage extends StatelessWidget {
  const ProfilePage({super.key});
  @override
  Widget build(BuildContext context) => PageShell(
    child: Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        const Text(
          'You',
          style: TextStyle(fontSize: 30, fontWeight: FontWeight.w800),
        ),
        const SizedBox(height: 18),
        const Card(
          child: ListTile(
            contentPadding: EdgeInsets.all(18),
            leading: CircleAvatar(
              radius: 27,
              backgroundColor: Color(0xFF132B2F),
              child: Text(
                'AK',
                style: TextStyle(
                  color: Colors.white,
                  fontWeight: FontWeight.w800,
                ),
              ),
            ),
            title: Text(
              'Amir K.',
              style: TextStyle(fontWeight: FontWeight.w800),
            ),
            subtitle: Text('Building a stronger cushion'),
          ),
        ),
        const SizedBox(height: 18),
        const SectionTitle('Settings', action: ''),
        const SizedBox(height: 8),
        Card(
          child: Column(
            children: const [
              SettingsTile(
                Icons.account_balance_outlined,
                'Connected accounts',
                '2 active',
              ),
              Divider(height: 1, indent: 64),
              SettingsTile(
                Icons.flag_outlined,
                'Goals & priorities',
                'Emergency fund first',
              ),
              Divider(height: 1, indent: 64),
              SettingsTile(Icons.notifications_outlined, 'Smart alerts', 'On'),
              Divider(height: 1, indent: 64),
              SettingsTile(
                Icons.lock_outline_rounded,
                'Privacy & security',
                'Review controls',
              ),
            ],
          ),
        ),
        const SizedBox(height: 18),
        const Card(
          color: Color(0xFFF0EFE9),
          child: Padding(
            padding: EdgeInsets.all(18),
            child: Text(
              'ClearPath provides educational guidance, not financial advice. Your bank credentials should only be handled by a regulated connection provider—never stored in this app.',
              style: TextStyle(
                color: Color(0xFF5F6969),
                height: 1.4,
                fontSize: 12,
              ),
            ),
          ),
        ),
      ],
    ),
  );
}

class PurchaseCheckSheet extends StatefulWidget {
  const PurchaseCheckSheet({super.key});
  @override
  State<PurchaseCheckSheet> createState() => _PurchaseCheckSheetState();
}

class _PurchaseCheckSheetState extends State<PurchaseCheckSheet> {
  final amount = TextEditingController();
  final item = TextEditingController();
  double? checkedAmount;
  @override
  void dispose() {
    amount.dispose();
    item.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final safe = checkedAmount != null && checkedAmount! <= 180;
    final cautious =
        checkedAmount != null && checkedAmount! > 180 && checkedAmount! <= 642;
    return SheetFrame(
      child: Padding(
        padding: EdgeInsets.only(
          bottom: MediaQuery.viewInsetsOf(context).bottom,
        ),
        child: Column(
          mainAxisSize: MainAxisSize.min,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            const Text(
              'Can I afford it?',
              style: TextStyle(fontWeight: FontWeight.w800, fontSize: 26),
            ),
            const SizedBox(height: 4),
            const Text(
              'Check a purchase against your bills, goals, and cash flow.',
              style: TextStyle(color: Color(0xFF687577)),
            ),
            const SizedBox(height: 18),
            TextField(
              controller: item,
              decoration: const InputDecoration(
                labelText: 'What is it?',
                hintText: 'e.g. New headphones',
              ),
            ),
            const SizedBox(height: 10),
            TextField(
              controller: amount,
              keyboardType: const TextInputType.numberWithOptions(
                decimal: true,
              ),
              decoration: const InputDecoration(
                labelText: 'Price',
                prefixText: '\$ ',
              ),
            ),
            const SizedBox(height: 14),
            FilledButton(
              onPressed: () =>
                  setState(() => checkedAmount = double.tryParse(amount.text)),
              style: FilledButton.styleFrom(
                minimumSize: const Size(double.infinity, 54),
              ),
              child: const Text('Check my plan'),
            ),
            if (checkedAmount != null) ...[
              const SizedBox(height: 16),
              Container(
                padding: const EdgeInsets.all(18),
                decoration: BoxDecoration(
                  color: safe
                      ? const Color(0xFFDDF2EB)
                      : cautious
                      ? const Color(0xFFFFF0D5)
                      : const Color(0xFFFFE1DA),
                  borderRadius: BorderRadius.circular(20),
                ),
                child: Row(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Icon(
                      safe
                          ? Icons.check_circle_rounded
                          : cautious
                          ? Icons.pause_circle_rounded
                          : Icons.warning_rounded,
                      color: safe
                          ? const Color(0xFF24735F)
                          : cautious
                          ? const Color(0xFF9A6A18)
                          : const Color(0xFFA64035),
                    ),
                    const SizedBox(width: 12),
                    Expanded(
                      child: Text(
                        safe
                            ? 'Looks comfortable. You can buy this and keep your planned cushion intact.'
                            : cautious
                            ? 'You can cover it, but waiting until Friday would protect your cushion and give you more flexibility.'
                            : 'This would exceed your current safe-to-spend amount. Consider saving for it over the next few pay cycles.',
                        style: const TextStyle(
                          fontWeight: FontWeight.w700,
                          height: 1.35,
                        ),
                      ),
                    ),
                  ],
                ),
              ),
            ],
            const SizedBox(height: 12),
          ],
        ),
      ),
    );
  }
}

class ConnectSheet extends StatelessWidget {
  const ConnectSheet({super.key});
  @override
  Widget build(BuildContext context) => SheetFrame(
    child: Column(
      mainAxisSize: MainAxisSize.min,
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        const Text(
          'Connect securely',
          style: TextStyle(fontWeight: FontWeight.w800, fontSize: 26),
        ),
        const SizedBox(height: 6),
        const Text(
          'Checking, savings, and credit cards can be linked through a secure provider.',
          style: TextStyle(color: Color(0xFF687577), height: 1.4),
        ),
        const SizedBox(height: 18),
        const SecurityPoint(
          Icons.lock_outline_rounded,
          'Your login is never visible to ClearPath',
        ),
        const SecurityPoint(
          Icons.sync_rounded,
          'Balances and transactions stay up to date',
        ),
        const SecurityPoint(
          Icons.tune_rounded,
          'Disconnect or delete data any time',
        ),
        const SizedBox(height: 12),
        FilledButton(
          onPressed: () {
            Navigator.pop(context);
            ScaffoldMessenger.of(context).showSnackBar(
              const SnackBar(
                content: Text(
                  'Demo mode: add your bank-link provider keys to enable connections.',
                ),
              ),
            );
          },
          style: FilledButton.styleFrom(
            minimumSize: const Size(double.infinity, 54),
          ),
          child: const Text('Continue to bank connection'),
        ),
        const SizedBox(height: 10),
      ],
    ),
  );
}

class AddBillSheet extends StatefulWidget {
  const AddBillSheet({super.key});
  @override
  State<AddBillSheet> createState() => _AddBillSheetState();
}

class _AddBillSheetState extends State<AddBillSheet> {
  final name = TextEditingController();
  final amount = TextEditingController();
  final day = TextEditingController();
  @override
  void dispose() {
    name.dispose();
    amount.dispose();
    day.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) => SheetFrame(
    child: Padding(
      padding: EdgeInsets.only(bottom: MediaQuery.viewInsetsOf(context).bottom),
      child: Column(
        mainAxisSize: MainAxisSize.min,
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          const Text(
            'Add a bill',
            style: TextStyle(fontWeight: FontWeight.w800, fontSize: 26),
          ),
          const SizedBox(height: 14),
          OutlinedButton.icon(
            onPressed: () {
              name.text = 'Electric bill';
              amount.text = '118.50';
              day.text = '22';
              ScaffoldMessenger.of(context).showSnackBar(
                const SnackBar(
                  content: Text(
                    'Demo scan complete — please review the details.',
                  ),
                ),
              );
            },
            style: OutlinedButton.styleFrom(
              minimumSize: const Size(double.infinity, 52),
            ),
            icon: const Icon(Icons.document_scanner_outlined),
            label: const Text('Scan or choose a statement'),
          ),
          const Padding(
            padding: EdgeInsets.symmetric(vertical: 12),
            child: Row(
              children: [
                Expanded(child: Divider()),
                Padding(
                  padding: EdgeInsets.symmetric(horizontal: 10),
                  child: Text('or enter it'),
                ),
                Expanded(child: Divider()),
              ],
            ),
          ),
          TextField(
            controller: name,
            decoration: const InputDecoration(labelText: 'Bill name'),
          ),
          const SizedBox(height: 9),
          Row(
            children: [
              Expanded(
                child: TextField(
                  controller: amount,
                  keyboardType: TextInputType.number,
                  decoration: const InputDecoration(
                    labelText: 'Amount',
                    prefixText: '\$ ',
                  ),
                ),
              ),
              const SizedBox(width: 9),
              Expanded(
                child: TextField(
                  controller: day,
                  keyboardType: TextInputType.number,
                  decoration: const InputDecoration(labelText: 'Day due'),
                ),
              ),
            ],
          ),
          const SizedBox(height: 14),
          FilledButton(
            onPressed: () {
              final parsedAmount = double.tryParse(amount.text);
              final parsedDay = int.tryParse(day.text);
              if (name.text.trim().isNotEmpty &&
                  parsedAmount != null &&
                  parsedDay != null &&
                  parsedDay >= 1 &&
                  parsedDay <= 31) {
                Navigator.pop(
                  context,
                  Bill(
                    name.text.trim(),
                    parsedAmount,
                    parsedDay,
                    Icons.receipt_rounded,
                    const Color(0xFFE8E6F4),
                  ),
                );
              }
            },
            style: FilledButton.styleFrom(
              minimumSize: const Size(double.infinity, 54),
            ),
            child: const Text('Save bill'),
          ),
          const SizedBox(height: 10),
        ],
      ),
    ),
  );
}

class SheetFrame extends StatelessWidget {
  const SheetFrame({super.key, required this.child});
  final Widget child;
  @override
  Widget build(BuildContext context) => Container(
    padding: const EdgeInsets.fromLTRB(22, 12, 22, 22),
    decoration: const BoxDecoration(
      color: Color(0xFFF8F7F2),
      borderRadius: BorderRadius.vertical(top: Radius.circular(30)),
    ),
    child: SafeArea(
      top: false,
      child: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          Container(
            width: 42,
            height: 5,
            margin: const EdgeInsets.only(bottom: 20),
            decoration: BoxDecoration(
              color: const Color(0xFFC8CBC6),
              borderRadius: BorderRadius.circular(10),
            ),
          ),
          child,
        ],
      ),
    ),
  );
}

class InsightCard extends StatelessWidget {
  const InsightCard({super.key});
  @override
  Widget build(BuildContext context) => Card(
    color: const Color(0xFFDDF2EB),
    child: Padding(
      padding: const EdgeInsets.all(20),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Container(
            padding: const EdgeInsets.all(9),
            decoration: BoxDecoration(
              color: Colors.white.withValues(alpha: .7),
              borderRadius: BorderRadius.circular(12),
            ),
            child: const Icon(
              Icons.auto_awesome_rounded,
              color: Color(0xFF246B5A),
            ),
          ),
          const SizedBox(width: 13),
          const Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  'You’re ahead by \$126',
                  style: TextStyle(fontWeight: FontWeight.w800, fontSize: 17),
                ),
                SizedBox(height: 5),
                Text(
                  'Your spending is lower than usual this week. Moving \$75 to your emergency fund keeps your weekend flexible.',
                  style: TextStyle(height: 1.4, color: Color(0xFF385D55)),
                ),
              ],
            ),
          ),
        ],
      ),
    ),
  );
}

class SectionTitle extends StatelessWidget {
  const SectionTitle(this.title, {super.key, required this.action});
  final String title, action;
  @override
  Widget build(BuildContext context) => Row(
    children: [
      Expanded(
        child: Text(
          title,
          style: const TextStyle(fontWeight: FontWeight.w800, fontSize: 19),
        ),
      ),
      if (action.isNotEmpty)
        Text(
          action,
          style: const TextStyle(color: Color(0xFF647371), fontSize: 12),
        ),
    ],
  );
}

class AccountTile extends StatelessWidget {
  const AccountTile({
    super.key,
    required this.icon,
    required this.name,
    required this.subtitle,
    required this.amount,
    required this.color,
  });
  final IconData icon;
  final String name, subtitle, amount;
  final Color color;
  @override
  Widget build(BuildContext context) => Card(
    child: ListTile(
      contentPadding: const EdgeInsets.symmetric(horizontal: 14, vertical: 6),
      leading: RoundedIcon(icon: icon, color: color),
      title: Text(name, style: const TextStyle(fontWeight: FontWeight.w700)),
      subtitle: Text(subtitle),
      trailing: Text(
        amount,
        style: const TextStyle(fontWeight: FontWeight.w800),
      ),
    ),
  );
}

class RoundedIcon extends StatelessWidget {
  const RoundedIcon({super.key, required this.icon, required this.color});
  final IconData icon;
  final Color color;
  @override
  Widget build(BuildContext context) => Container(
    width: 44,
    height: 44,
    decoration: BoxDecoration(
      color: color,
      borderRadius: BorderRadius.circular(14),
    ),
    child: Icon(icon, color: const Color(0xFF263B3E), size: 21),
  );
}

class MiniBill extends StatelessWidget {
  const MiniBill({
    super.key,
    required this.name,
    required this.date,
    required this.amount,
    required this.icon,
  });
  final String name, date, amount;
  final IconData icon;
  @override
  Widget build(BuildContext context) => ListTile(
    contentPadding: EdgeInsets.zero,
    leading: RoundedIcon(icon: icon, color: const Color(0xFFF0EFE9)),
    title: Text(name, style: const TextStyle(fontWeight: FontWeight.w700)),
    subtitle: Text(date),
    trailing: Text(amount, style: const TextStyle(fontWeight: FontWeight.w800)),
  );
}

class Metric extends StatelessWidget {
  const Metric({
    super.key,
    required this.label,
    required this.value,
    required this.color,
  });
  final String label, value;
  final Color color;
  @override
  Widget build(BuildContext context) => Column(
    crossAxisAlignment: CrossAxisAlignment.start,
    children: [
      Text(
        label,
        style: const TextStyle(color: Color(0xFF6B7778), fontSize: 12),
      ),
      const SizedBox(height: 4),
      Text(
        value,
        style: TextStyle(
          fontWeight: FontWeight.w800,
          fontSize: 22,
          color: color,
        ),
      ),
    ],
  );
}

class BudgetRow extends StatelessWidget {
  const BudgetRow(
    this.name,
    this.spent,
    this.total,
    this.icon,
    this.color, {
    super.key,
  });
  final String name;
  final double spent, total;
  final IconData icon;
  final Color color;
  @override
  Widget build(BuildContext context) => Card(
    child: Padding(
      padding: const EdgeInsets.all(16),
      child: Row(
        children: [
          RoundedIcon(icon: icon, color: color),
          const SizedBox(width: 13),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Row(
                  children: [
                    Expanded(
                      child: Text(
                        name,
                        style: const TextStyle(fontWeight: FontWeight.w700),
                      ),
                    ),
                    Text(
                      '\$${spent.toInt()} / \$${total.toInt()}',
                      style: const TextStyle(fontSize: 12),
                    ),
                  ],
                ),
                const SizedBox(height: 8),
                ClipRRect(
                  borderRadius: BorderRadius.circular(8),
                  child: LinearProgressIndicator(
                    value: spent / total,
                    minHeight: 7,
                    backgroundColor: const Color(0xFFE9E9E4),
                    color: const Color(0xFF68B5A2),
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    ),
  );
}

class SettingsTile extends StatelessWidget {
  const SettingsTile(this.icon, this.title, this.value, {super.key});
  final IconData icon;
  final String title, value;
  @override
  Widget build(BuildContext context) => ListTile(
    leading: Icon(icon),
    title: Text(title, style: const TextStyle(fontWeight: FontWeight.w700)),
    subtitle: Text(value),
    trailing: const Icon(Icons.chevron_right_rounded),
  );
}

class SecurityPoint extends StatelessWidget {
  const SecurityPoint(this.icon, this.text, {super.key});
  final IconData icon;
  final String text;
  @override
  Widget build(BuildContext context) => Padding(
    padding: const EdgeInsets.only(bottom: 13),
    child: Row(
      children: [
        RoundedIcon(icon: icon, color: const Color(0xFFDDF2EB)),
        const SizedBox(width: 12),
        Expanded(
          child: Text(
            text,
            style: const TextStyle(fontWeight: FontWeight.w600),
          ),
        ),
      ],
    ),
  );
}

class Bill {
  Bill(this.name, this.amount, this.day, this.icon, this.color);
  final String name;
  final double amount;
  final int day;
  final IconData icon;
  final Color color;
}
