import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:fl_chart/fl_chart.dart';
import 'package:yahoo_finance_data_reader/yahoo_finance_data_reader.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';

class StockDetailScreen extends StatefulWidget {
  final String stockName;

  const StockDetailScreen({super.key, required this.stockName});

  @override
  State<StockDetailScreen> createState() => _StockDetailScreenState();
}

class _StockDetailScreenState extends State<StockDetailScreen> {
  List<FlSpot> actualSpots = [];
  List<FlSpot> forecastSpots = [];
  bool isLoading = true;
  String selectedTimeline = 'Daily';

  @override
  void initState() {
    super.initState();
    fetchStockData();
  }

  Future<void> fetchStockData() async {
    try {
      const yahooFinanceReader = YahooFinanceDailyReader();
      final startDate = DateTime(DateTime.now().year, 1, 1);

      final stockData = await yahooFinanceReader.getDailyDTOs(
        widget.stockName,
        startDate: startDate,
      );

      final forecastData = await fetchForecastData();

      setState(() {
        actualSpots = stockData.candlesData.map((data) {
          return FlSpot(
            data.date.millisecondsSinceEpoch.toDouble(),
            data.close,
          );
        }).toList();

        if (selectedTimeline == 'Monthly') {
          actualSpots = _aggregateMonthlyData(actualSpots);
        }

        forecastSpots =
            List.generate(forecastData['future_dates'].length, (index) {
          final date = DateTime.parse(forecastData['future_dates'][index]);
          final price = forecastData['predicted_prices'][index];
          return FlSpot(date.millisecondsSinceEpoch.toDouble(), price);
        });

        isLoading = false;
      });
    } catch (e) {
      debugPrint('Error fetching data: $e');
      setState(() {
        isLoading = false;
      });
    }
  }

  Future<Map<String, dynamic>> fetchForecastData() async {
    final response = await http.post(
      Uri.parse('https://fingoal-432510.et.r.appspot.com/forecast'),
      headers: {'Content-Type': 'application/json'},
      body: jsonEncode({"ticker": widget.stockName, "num_future_steps": 4}),
    );

    if (response.statusCode == 200) {
      return jsonDecode(response.body);
    } else {
      throw Exception('Failed to load forecast data');
    }
  }

  List<FlSpot> _aggregateMonthlyData(List<FlSpot> dailyData) {
    Map<int, List<FlSpot>> monthlyGroups = {};

    for (var spot in dailyData) {
      DateTime date = DateTime.fromMillisecondsSinceEpoch(spot.x.toInt());
      int monthKey = DateTime(date.year, date.month).millisecondsSinceEpoch;

      if (!monthlyGroups.containsKey(monthKey)) {
        monthlyGroups[monthKey] = [];
      }
      monthlyGroups[monthKey]!.add(spot);
    }

    return monthlyGroups.entries.map((entry) {
      List<FlSpot> monthSpots = entry.value;
      double avgPrice = monthSpots.map((s) => s.y).reduce((a, b) => a + b) /
          monthSpots.length;
      return FlSpot(entry.key.toDouble(), avgPrice);
    }).toList()
      ..sort((a, b) => a.x.compareTo(b.x));
  }

  String _formatDate(DateTime date) {
    return "${date.day}/${date.month}/${date.year}";
  }

  void _showDetailDialog(BuildContext context, DateTime date, double price) {
    showDialog(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          title: Text("Stock Details", style: GoogleFonts.poppins()),
          content: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            mainAxisSize: MainAxisSize.min,
            children: [
              Text("Date: ${_formatDate(date)}", style: GoogleFonts.poppins()),
              Text("Year: ${date.year}", style: GoogleFonts.poppins()),
              Text("Price: \$${price.toStringAsFixed(2)}",
                  style: GoogleFonts.poppins()),
            ],
          ),
          actions: [
            TextButton(
              child: Text("Close", style: GoogleFonts.poppins()),
              onPressed: () => Navigator.of(context).pop(),
            ),
          ],
        );
      },
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color.fromARGB(255, 45, 45, 45),
      appBar: AppBar(
        backgroundColor: Colors.transparent,
        elevation: 0,
        leading: IconButton(
          icon: const Icon(Icons.arrow_back, color: Colors.white),
          onPressed: () => Navigator.of(context).pop(),
        ),
        title: Text(
          "Stocks Perfomance",
          style: GoogleFonts.poppins(
            color: Colors.white,
            fontSize: 20,
            fontWeight: FontWeight.bold,
          ),
        ),
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: isLoading
            ? const Center(child: CircularProgressIndicator())
            : Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Row(
                    children: [
                      Image.asset(
                        'assets/images/${widget.stockName}.png', 
                        width: 28,
                        height: 28,
                      ),
                      const SizedBox(
                        width: 20,
                      ),
                      Text(
                        widget.stockName,
                        style: GoogleFonts.poppins(
                          color: Colors.white,
                          fontSize: 24,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                    ],
                  ),
                  const SizedBox(height: 10),
                  DropdownButton<String>(
                    value: selectedTimeline,
                    items: ['Daily', 'Monthly'].map((String value) {
                      return DropdownMenuItem<String>(
                        value: value,
                        child: Text(value,
                            style: GoogleFonts.poppins(color: Colors.white)),
                      );
                    }).toList(),
                    onChanged: (String? newValue) {
                      setState(() {
                        selectedTimeline = newValue!;
                        fetchStockData();
                      });
                    },
                    dropdownColor: Colors.grey[800],
                  ),
                  const SizedBox(height: 20),
                  Container(
                    height: 250,
                    decoration: BoxDecoration(
                      color: Colors.white10,
                      borderRadius: BorderRadius.circular(12),
                    ),
                    child: Padding(
                      padding: const EdgeInsets.all(16.0),
                      child: LineChart(
                        LineChartData(
                          gridData: const FlGridData(show: false),
                          titlesData: const FlTitlesData(show: false),
                          borderData: FlBorderData(show: false),
                          lineBarsData: [
                            LineChartBarData(
                              spots: actualSpots,
                              isCurved: false,
                              color: Colors.green,
                              barWidth: 3,
                              isStrokeCapRound: true,
                              dotData: const FlDotData(show: false),
                              belowBarData: BarAreaData(show: false),
                            ),
                            LineChartBarData(
                              spots: forecastSpots,
                              isCurved: false,
                              color: Colors.blue,
                              barWidth: 3,
                              isStrokeCapRound: true,
                              dotData: const FlDotData(show: false),
                              belowBarData: BarAreaData(show: false),
                            ),
                          ],
                          lineTouchData: LineTouchData(
                            touchTooltipData: LineTouchTooltipData(
                              getTooltipItems:
                                  (List<LineBarSpot> touchedBarSpots) {
                                return touchedBarSpots.map((barSpot) {
                                 barSpot.spotIndex;
                                  final date =
                                      DateTime.fromMillisecondsSinceEpoch(
                                          barSpot.x.toInt());
                                  return LineTooltipItem(
                                    "${_formatDate(date)}\n${barSpot.y.toStringAsFixed(2)}",
                                    GoogleFonts.poppins(color: Colors.white),
                                  );
                                }).toList();
                              },
                            ),
                            handleBuiltInTouches: true,
                            touchCallback: (FlTouchEvent event,
                                LineTouchResponse? touchResponse) {
                              if (event is FlTapUpEvent &&
                                  touchResponse?.lineBarSpots != null) {
                                final spotIndex =
                                    touchResponse!.lineBarSpots![0].spotIndex;
                                final date =
                                    DateTime.fromMillisecondsSinceEpoch(
                                        actualSpots[spotIndex].x.toInt());
                                final price = actualSpots[spotIndex].y;
                                _showDetailDialog(context, date, price);
                              }
                            },
                          ),
                        ),
                      ),
                    ),
                  ),
                  const SizedBox(height: 20),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      _buildLegendItem("Actual", Colors.green),
                      const SizedBox(width: 20),
                      _buildLegendItem("Forecast", Colors.blue),
                    ],
                  ),
                  const SizedBox(
                    height: 20,
                  ),
                  Text(
                    "Harga Sekarang: ${actualSpots.isNotEmpty ? 'Rp.${actualSpots.last.y.toStringAsFixed(2)}' : 'N/A'}",
                    style: GoogleFonts.poppins(
                      color: Colors.white,
                      fontSize: 18,
                      fontWeight: FontWeight.w600,
                    ),
                  ),
                  Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        "Forecast for next 4 Days:",
                        style: GoogleFonts.poppins(
                          color: Colors.white,
                          fontSize: 18,
                          fontWeight: FontWeight.w600,
                        ),
                      ),
                      ...List.generate(forecastSpots.length, (index) {
                        DateTime.fromMillisecondsSinceEpoch(
                            forecastSpots[index].x.toInt());
                        final price = forecastSpots[index].y;
                        return Text(
                          "- Rp.${price.toStringAsFixed(2)}",
                          style: GoogleFonts.poppins(
                            color: Colors.white,
                            fontSize: 14,
                          ),
                        );
                      },),
                    ],
                  ),
                ],
              ),
      ),
    );
  }

  Widget _buildLegendItem(String label, Color color) {
    return Row(
      children: [
        Container(
          width: 16,
          height: 16,
          color: color,
        ),
        const SizedBox(width: 8),
        Text(
          label,
          style: GoogleFonts.poppins(
            color: Colors.white,
            fontSize: 14,
          ),
        ),
      ],
    );
  }
}
