import 'package:flutter/material.dart';

class LandingScreen extends StatefulWidget {
  const LandingScreen({super.key});

  @override
  State<LandingScreen> createState() => _LandingScreenState();
}

class _LandingScreenState extends State<LandingScreen> {
  final TextEditingController _incomeController = TextEditingController();
  double _currentIncome = 0;

  String? _incomeError;
  String? _percentError;
  //List
  final List<Map<String, dynamic>> jarData = [
    {
      "title": "NEEDS",
      "percent": 50,
      "icon": Icons.home,
      "gradient": [const Color(0xFF6FCF97), const Color(0xFF27AE60)],
    },
    {
      "title": "FFA",
      "percent": 15,
      "icon": Icons.work,
      "gradient": [const Color(0xFFF2994A), const Color(0xFFF2C94C)],
    },
    {
      "title": "EDU",
      "percent": 10,
      "icon": Icons.menu_book,
      "gradient": [const Color(0xFF56CCF2), const Color(0xFF2D9CDB)],
    },
    {
      "title": "PLAY",
      "percent": 10,
      "icon": Icons.celebration,
      "gradient": [const Color(0xFFBB6BD9), const Color(0xFF9B51E0)],
    },
    {
      "title": "LTSS",
      "percent": 10,
      "icon": Icons.account_balance,
      "gradient": [const Color(0xFF2F80ED), const Color(0xFF56CCF2)],
    },
    {
      "title": "GIVE",
      "percent": 5,
      "icon": Icons.favorite,
      "gradient": [const Color(0xFF6FCF97), const Color(0xFF219653)],
    },
  ];

  @override
  void initState() {
    super.initState();
    for (var jar in jarData) {
      jar['controller'] = TextEditingController(
        text: jar['percent'].toString(),
      );
      jar['hasError'] = false;
    }
  }

  @override
  void dispose() {
    _incomeController.dispose();
    for (var jar in jarData) {
      jar['controller'].dispose();
    }
    super.dispose();
  }

  int _calculateTotal() {
    int total = 0;
    for (var jar in jarData) {
      total += int.tryParse(jar['controller'].text) ?? 0;
    }
    return total;
  }

  void _recalculate() {
    setState(() {
      _incomeError = null;
      _percentError = null;
      int currentTotal = _calculateTotal();

      final incomeValue = double.tryParse(_incomeController.text);
      if (_incomeController.text.isEmpty || incomeValue == null) {
        _incomeError = "Invalid income";
        _currentIncome = 0;
      } else {
        _currentIncome = incomeValue;
      }

      if (currentTotal != 100) {
        _percentError = "Total is $currentTotal%. Must be 100%";
      }

      for (var jar in jarData) {
        final val = int.tryParse(jar['controller'].text);
        if (val == null) {
          jar['hasError'] = true;
          jar['percent'] = 0;
        } else {
          jar['percent'] = val;
          jar['hasError'] = (currentTotal != 100);
        }
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () {
        FocusScope.of(context).unfocus();
      },
      child: Scaffold(
        backgroundColor: const Color(0xFFF5F7FA),
        appBar: AppBar(
          backgroundColor: const Color(0xFF94B7EB),
          centerTitle: true,
          title: const Row(
            mainAxisSize: MainAxisSize.min,
            children: [
              Icon(Icons.savings_outlined, color: Color(0xFF2C3E50)),
              SizedBox(width: 8),
              Text(
                "JarWise",
                style: TextStyle(
                  fontWeight: FontWeight.bold,
                  color: Color(0xFF2C3E50),
                ),
              ),
            ],
          ),
          elevation: 0,
        ),
        drawer: Drawer(
          child: ListView(
            padding: EdgeInsets.zero,
            children: [
              const DrawerHeader(
                decoration: BoxDecoration(color: Color(0xFF94B7EB)),
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    CircleAvatar(
                      radius: 30,
                      backgroundColor: Colors.white,
                      child: Icon(
                        Icons.person,
                        size: 40,
                        color: Color(0xFF94B7EB),
                      ),
                    ),
                    SizedBox(height: 10),
                    Text(
                      "Welcome to JarWise",
                      style: TextStyle(
                        color: Colors.white,
                        fontSize: 18,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                  ],
                ),
              ),
              ListTile(
                leading: const Icon(Icons.account_balance_wallet),
                title: const Text('My Budget'),
                onTap: () => Navigator.pop(context),
              ),
              ListTile(
                leading: const Icon(Icons.settings),
                title: const Text('Settings'),
                onTap: () => Navigator.pop(context),
              ),
              const Divider(),
              ListTile(
                leading: const Icon(Icons.info_outline),
                title: const Text('About Jars System'),
                onTap: () => Navigator.pop(context),
              ),
            ],
          ),
        ),
        body: ListView(
          padding: const EdgeInsets.all(16),
          children: [
            Card(
              elevation: 2,
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(12),
              ),
              child: Padding(
                padding: const EdgeInsets.all(16),
                child: TextFormField(
                  controller: _incomeController,
                  keyboardType: TextInputType.number,
                  decoration: InputDecoration(
                    labelText: "Monthly Income",
                    prefixIcon: const Icon(Icons.currency_rupee),
                    border: const OutlineInputBorder(),
                    errorText: _incomeError,
                  ),
                ),
              ),
            ),
            const SizedBox(height: 20),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                const Text(
                  "The Six Jars",
                  style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
                ),
                if (_percentError != null)
                  Text(
                    _percentError!,
                    style: const TextStyle(
                      color: Colors.red,
                      fontWeight: FontWeight.bold,
                      fontSize: 12,
                    ),
                  ),
              ],
            ),
            const SizedBox(height: 10),
            ...jarData.map((jar) {
              final List<Color> colors = jar["gradient"];
              final double amount = (_currentIncome * jar['percent']) / 100;
              final bool hasError = jar['hasError'] ?? false;

              return Container(
                margin: const EdgeInsets.symmetric(vertical: 6),
                padding: const EdgeInsets.symmetric(
                  horizontal: 16,
                  vertical: 12,
                ),
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(16),
                  gradient: LinearGradient(colors: colors),
                  boxShadow: [
                    BoxShadow(
                      color: Colors.black.withOpacity(0.1),
                      blurRadius: 4,
                      offset: const Offset(0, 2),
                    ),
                  ],
                ),
                child: Row(
                  children: [
                    Icon(jar["icon"], color: Colors.white, size: 28),
                    const SizedBox(width: 12),
                    Expanded(
                      child: Text(
                        jar["title"],
                        style: const TextStyle(
                          color: Colors.white,
                          fontSize: 16,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                    ),
                    Container(
                      width: 75,
                      height: 40,
                      alignment: Alignment.center,
                      decoration: BoxDecoration(
                        color: Colors.white,
                        borderRadius: BorderRadius.circular(8),
                        border: Border.all(
                          color: hasError
                              ? Colors.red.shade900
                              : Colors.transparent,
                          width: 2,
                        ),
                      ),
                      child: TextFormField(
                        controller: jar['controller'],
                        keyboardType: TextInputType.number,
                        textAlign: TextAlign.center,
                        style: TextStyle(
                          fontSize: 14,
                          fontWeight: FontWeight.bold,
                          color: hasError ? Colors.red : Colors.black,
                        ),
                        decoration: const InputDecoration(
                          isDense: true,
                          suffixText: "%",
                          suffixStyle: TextStyle(
                            fontSize: 12,
                            color: Colors.black54,
                          ),
                          border: InputBorder.none,
                          contentPadding: EdgeInsets.symmetric(horizontal: 4),
                        ),
                      ),
                    ),
                    const SizedBox(width: 12),
                    SizedBox(
                      width: 85,
                      child: Text(
                        "₹${amount.toStringAsFixed(0)}",
                        textAlign: TextAlign.right,
                        style: const TextStyle(
                          color: Colors.white,
                          fontSize: 16,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                    ),
                  ],
                ),
              );
            }),
            const SizedBox(height: 20),
            ElevatedButton.icon(
              onPressed: _recalculate,
              icon: const Icon(Icons.calculate),
              label: const Text("Recalculate"),
              style: ElevatedButton.styleFrom(
                backgroundColor: const Color(0xFF94B7EB),
                foregroundColor: Colors.black87,
                minimumSize: const Size(double.infinity, 50),
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(12),
                ),
              ),
            ),
            const SizedBox(height: 40),
          ],
        ),
      ),
    );
  }
}
