import 'package:fingoal_frontend/Forecast/StockDetailScreen.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

class ForecastScreen extends StatefulWidget {
  const ForecastScreen({super.key});

  @override
  State<ForecastScreen> createState() => _ForecastScreenState();
}

class _ForecastScreenState extends State<ForecastScreen> {
  final List<Map<String, String>> indonesianStocks = [
    {'name': 'BBCA', 'icon': 'assets/images/BBCA.png'},
    {'name': 'ASII', 'icon': 'assets/images/ASII.png'},
    {'name': 'TLKM', 'icon': 'assets/images/TLKM.png'},
    {'name': 'GOTO', 'icon': 'assets/images/GOTO.png'},
  ];

  void _navigateToStockDetail(String stockName) {
    debugPrint('Navigating to $stockName detail page');
    Navigator.push(
      context,
      MaterialPageRoute(
        builder: (context) => StockDetailScreen(stockName: stockName),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color.fromARGB(255, 45, 45, 45),
      body: SingleChildScrollView(
        padding: const EdgeInsets.symmetric(horizontal: 20.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            SizedBox(height: MediaQuery.of(context).padding.top + 20),
            Row(
              children: [
                IconButton(
                  icon: const Icon(Icons.arrow_back, color: Colors.white),
                  onPressed: () => Navigator.of(context).pop(),
                ),
                const SizedBox(width: 10),
                Text(
                  "Forecast Stocks",
                  style: GoogleFonts.poppins(
                    color: Colors.white,
                    fontSize: 24,
                    fontWeight: FontWeight.bold,
                  ),
                ),
              ],
            ),
            const SizedBox(height: 20),
            Text(
              "Indonesian Stocks",
              style: GoogleFonts.poppins(
                color: Colors.white,
                fontSize: 18,
                fontWeight: FontWeight.w600,
              ),
            ),
            const SizedBox(height: 10),
            GridView.builder(
              shrinkWrap: true,
              physics: const NeverScrollableScrollPhysics(),
              gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                crossAxisCount: 3,
                crossAxisSpacing: 10,
                mainAxisSpacing: 10,
              ),
              itemCount: indonesianStocks.length,
              itemBuilder: (context, index) {
                final stock = indonesianStocks[index];
                return GestureDetector(
                  onTap: () => _navigateToStockDetail(stock['name']!),
                  child: Card(
                    color: Colors.white10,
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Image.asset(
                          stock['icon']!,
                          width: 50,
                          height: 50,
                        ),
                        const SizedBox(height: 8),
                        Text(
                          stock['name']!,
                          style: GoogleFonts.poppins(
                            color: Colors.white,
                            fontSize: 14,
                          ),
                        ),
                      ],
                    ),
                  ),
                );
              },
            ),
          ],
        ),
      ),
    );
  }
}
