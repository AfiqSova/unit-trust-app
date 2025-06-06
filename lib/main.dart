import 'package:flutter/material.dart';
import 'package:url_launcher/url_launcher.dart';

void main() => runApp(UnitTrustCalculatorApp());

class UnitTrustCalculatorApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Unit Trust Calculator',
      theme: ThemeData(primarySwatch: Colors.green),
      home: HomePage(),
      routes: {
        '/about': (context) => AboutPage(),
      },
    );
  }
}

class HomePage extends StatefulWidget {
  @override
  _HomePageState createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  final amountController = TextEditingController();
  final rateController = TextEditingController();
  final monthsController = TextEditingController();

  double? monthlyDividend;
  double? totalDividend;

  void calculateDividend() {
    double amount = double.tryParse(amountController.text) ?? 0;
    double rate = double.tryParse(rateController.text) ?? 0;
    int months = int.tryParse(monthsController.text) ?? 0;

    if (months > 12) months = 12;

    double monthly = (rate / 100 / 12) * amount;
    double total = monthly * months;

    setState(() {
      monthlyDividend = monthly;
      totalDividend = total;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Dividend Calculator'),
      ),
      drawer: Drawer(
        child: ListView(
          padding: EdgeInsets.zero,
          children: [
            DrawerHeader(
              decoration: BoxDecoration(color: Theme.of(context).primaryColor),
              child: Text('Navigation', style: TextStyle(color: Colors.white, fontSize: 20)),
            ),
            ListTile(
              leading: Icon(Icons.home),
              title: Text('Home'),
              onTap: () => Navigator.pop(context),
            ),
            ListTile(
              leading: Icon(Icons.info),
              title: Text('About'),
              onTap: () => Navigator.pushNamed(context, '/about'),
            ),
          ],
        ),
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Card(
          elevation: 6,
          shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(16)),
          child: Padding(
            padding: const EdgeInsets.all(20),
            child: ListView(
              shrinkWrap: true,
              children: [
                Text(
                  'Calculate Your Investment Dividend',
                  style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
                  textAlign: TextAlign.center,
                ),
                const SizedBox(height: 20),
                TextField(
                  controller: amountController,
                  decoration: InputDecoration(
                    labelText: 'Invested Amount (RM)',
                    border: OutlineInputBorder(),
                    prefixIcon: Icon(Icons.attach_money),
                  ),
                  keyboardType: TextInputType.number,
                ),
                const SizedBox(height: 16),
                TextField(
                  controller: rateController,
                  decoration: InputDecoration(
                    labelText: 'Annual Dividend Rate (%)',
                    border: OutlineInputBorder(),
                    prefixIcon: Icon(Icons.percent),
                  ),
                  keyboardType: TextInputType.number,
                ),
                const SizedBox(height: 16),
                TextField(
                  controller: monthsController,
                  decoration: InputDecoration(
                    labelText: 'Number of Months (Max 12)',
                    border: OutlineInputBorder(),
                    prefixIcon: Icon(Icons.calendar_today),
                  ),
                  keyboardType: TextInputType.number,
                ),
                const SizedBox(height: 20),
                ElevatedButton.icon(
                  onPressed: calculateDividend,
                  icon: Icon(Icons.calculate),
                  label: Text('Calculate'),
                  style: ElevatedButton.styleFrom(
                    padding: EdgeInsets.symmetric(vertical: 14),
                    textStyle: TextStyle(fontSize: 16),
                  ),
                ),
                const SizedBox(height: 30),
                if (monthlyDividend != null && totalDividend != null)
                  Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        'Results:',
                        style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
                      ),
                      const SizedBox(height: 10),
                      Text(
                        'Monthly Dividend: RM ${monthlyDividend!.toStringAsFixed(2)}',
                        style: TextStyle(fontSize: 16),
                      ),
                      Text(
                        'Total Dividend: RM ${totalDividend!.toStringAsFixed(2)}',
                        style: TextStyle(fontSize: 16),
                      ),
                    ],
                  ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}


class AboutPage extends StatelessWidget {
  final String githubUrl = 'https://github.com/AfiqSova/unit-trust-app';

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('About')),
      body: Padding(
        padding: const EdgeInsets.all(24.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            // Centered icon with rounded border
            ClipRRect(
              borderRadius: BorderRadius.circular(16),
              child: Image.asset(
                'assets/app_icon.png',
                height: 100,
                width: 100,
                fit: BoxFit.cover,
              ),
            ),
            const SizedBox(height: 20),

            // Application Info
            const Text(
              'Unit Trust Investment Calculator',
              style: TextStyle(
                fontSize: 20,
                fontWeight: FontWeight.bold,
              ),
              textAlign: TextAlign.center,
            ),

            const SizedBox(height: 12),
            const Text(
              'Developed by:\nMuhammad Afiq Arif Bin Mohd Idris\nMatric No: 2023197509\nCourse: CS251 5A - Computer Science Netcentric',
              style: TextStyle(fontSize: 16),
              textAlign: TextAlign.center,
            ),

            const SizedBox(height: 12),
            const Divider(thickness: 1.0),
            const SizedBox(height: 12),

            const Text(
              '© 2025 Afiq Arif\nAll rights reserved.',
              style: TextStyle(fontSize: 14, color: Colors.grey),
              textAlign: TextAlign.center,
            ),

            const SizedBox(height: 20),

            // Clickable GitHub Link
            InkWell(
              child: const Text(
                'View on GitHub',
                style: TextStyle(
                  color: Colors.blue,
                  fontSize: 16,
                  decoration: TextDecoration.underline,
                ),
              ),
              onTap: () => launchUrl(Uri.parse(githubUrl)),
            ),
          ],
        ),
      ),
    );
  }
}

