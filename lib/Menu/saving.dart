import 'package:fingoal_frontend/Forecast/forecaststocks.dart';
import 'package:fingoal_frontend/Service/api_service.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:google_fonts/google_fonts.dart';

class Saving extends StatefulWidget {
  const Saving({super.key});

  @override
  State<Saving> createState() {
    return _SavingState();
  }
}

class _SavingState extends State<Saving> {
  final TextEditingController _tujuanmenabung = TextEditingController();
  final TextEditingController _targetmenabung = TextEditingController();
  final TextEditingController _durasimenabung = TextEditingController();
  final TextEditingController _jumlahsetoran = TextEditingController();
  final ApiService _apiService = ApiService();

  bool _isFirstFieldFilled = false;
  bool _isSecondFieldFilled = false;
  bool _isThirdFieldFilled = false;

  int _selectedDuration = 0;
  int _selectedFrequency = 0;

  @override
  void initState() {
    super.initState();
    _tujuanmenabung.addListener(() {
      setState(() {
        _isFirstFieldFilled = _tujuanmenabung.text.isNotEmpty;
      });
    });

    _targetmenabung.addListener(() {
      setState(() {
        _isSecondFieldFilled = _targetmenabung.text.isNotEmpty;
      });
    });

    _durasimenabung.addListener(() {
      setState(() {
        _isThirdFieldFilled = _durasimenabung.text.isNotEmpty;
      });
    });
  }

  @override
  void dispose() {
    _tujuanmenabung.dispose();
    _targetmenabung.dispose();
    _durasimenabung.dispose();
    _jumlahsetoran.dispose();
    super.dispose();
  }

  String getFrequencyText() {
    switch (_selectedFrequency) {
      case 0:
        return "Harian";
      case 1:
        return "Bulanan";
      case 2:
        return "Tahunan";
      default:
        return "Harian";
    }
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
                  icon: const Icon(
                    Icons.arrow_back,
                    color: Colors.white,
                  ),
                  onPressed: () {
                    Navigator.of(context).pop();
                  },
                ),
                const SizedBox(width: 10),
                Text(
                  "Saving",
                  style: GoogleFonts.poppins(
                    color: Colors.white,
                    fontSize: 24,
                    fontWeight: FontWeight.bold,
                  ),
                ),
              ],
            ),
            const SizedBox(height: 20),
            Row(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Container(
                  margin: const EdgeInsets.only(right: 10),
                  width: 8,
                  height: 8,
                  decoration: const BoxDecoration(
                    color: Colors.green,
                    shape: BoxShape.circle,
                  ),
                ),
                Expanded(
                  child: Text(
                    "Apa Tujuan Menabung Mu?",
                    style: GoogleFonts.poppins(
                      color: Colors.white,
                      fontSize: 16,
                    ),
                  ),
                ),
              ],
            ),
            const SizedBox(height: 10),
            TextFormField(
              controller: _tujuanmenabung,
              decoration: InputDecoration(
                hintText: 'Tujuan Anda',
                hintStyle: GoogleFonts.poppins(color: Colors.white54),
              ),
              style: GoogleFonts.poppins(color: Colors.white),
            ),
            const SizedBox(height: 30),
            if (_isFirstFieldFilled) ...[
              Row(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Container(
                    margin: const EdgeInsets.only(right: 10),
                    width: 8,
                    height: 8,
                    decoration: const BoxDecoration(
                      color: Colors.green,
                      shape: BoxShape.circle,
                    ),
                  ),
                  Expanded(
                    child: Text(
                      "Target Menabung Mu",
                      style: GoogleFonts.poppins(
                        color: Colors.white,
                        fontSize: 16,
                      ),
                    ),
                  ),
                ],
              ),
              const SizedBox(height: 10),
              TextFormField(
                controller: _targetmenabung,
                decoration: InputDecoration(
                  prefixText: "Rp.",
                  hintText: 'Amount',
                  hintStyle: GoogleFonts.poppins(color: Colors.white54),
                ),
                keyboardType: TextInputType.number,
                style: GoogleFonts.poppins(color: Colors.white),
                inputFormatters: [CurrencyInputFormatter()],
              ),
            ],
            const SizedBox(height: 30),
            if (_isSecondFieldFilled) ...[
              Row(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Container(
                    margin: const EdgeInsets.only(right: 10),
                    width: 8,
                    height: 8,
                    decoration: const BoxDecoration(
                      color: Colors.green,
                      shape: BoxShape.circle,
                    ),
                  ),
                  Expanded(
                    child: Text(
                      "Durasi Menabung Mu",
                      style: GoogleFonts.poppins(
                        color: Colors.white,
                        fontSize: 16,
                      ),
                    ),
                  ),
                ],
              ),
              const SizedBox(height: 10),
              Row(
                children: [
                  Expanded(
                    child: TextFormField(
                      controller: _durasimenabung,
                      decoration: InputDecoration(
                        hintText: 'Amount',
                        hintStyle: GoogleFonts.poppins(color: Colors.white54),
                      ),
                      keyboardType: TextInputType.number,
                      style: GoogleFonts.poppins(color: Colors.white),
                    ),
                  ),
                  const SizedBox(width: 10),
                  ToggleButtons(
                    isSelected: [
                      _selectedDuration == 0,
                      _selectedDuration == 1
                    ],
                    color: Colors.white,
                    selectedColor: Colors.green,
                    fillColor: Colors.transparent,
                    borderColor: Colors.white,
                    selectedBorderColor: Colors.green,
                    borderRadius: BorderRadius.circular(8),
                    children: const [
                      Padding(
                        padding: EdgeInsets.symmetric(horizontal: 16.0),
                        child: Text('Bulan'),
                      ),
                      Padding(
                        padding: EdgeInsets.symmetric(horizontal: 16.0),
                        child: Text('Tahun'),
                      ),
                    ],
                    onPressed: (int index) {
                      setState(() {
                        _selectedDuration = index;
                      });
                    },
                  ),
                ],
              ),
            ],
            const SizedBox(height: 30),
            if (_isThirdFieldFilled) ...[
              Row(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Container(
                    margin: const EdgeInsets.only(right: 10),
                    width: 8,
                    height: 8,
                    decoration: const BoxDecoration(
                      color: Colors.green,
                      shape: BoxShape.circle,
                    ),
                  ),
                  Expanded(
                    child: Text(
                      "Frekuensi Menabung Mu",
                      style: GoogleFonts.poppins(
                        color: Colors.white,
                        fontSize: 16,
                      ),
                    ),
                  ),
                ],
              ),
              const SizedBox(height: 10),
              Row(
                children: [
                  Expanded(
                    child: ToggleButtons(
                      isSelected: [
                        _selectedFrequency == 0,
                        _selectedFrequency == 1,
                        _selectedFrequency == 2
                      ],
                      color: Colors.white,
                      selectedColor: Colors.green,
                      fillColor: Colors.transparent,
                      borderColor: Colors.white,
                      selectedBorderColor: Colors.green,
                      borderRadius: BorderRadius.circular(8),
                      children: const [
                        Padding(
                          padding: EdgeInsets.symmetric(horizontal: 16.0),
                          child: Text('Harian'),
                        ),
                        Padding(
                          padding: EdgeInsets.symmetric(horizontal: 16.0),
                          child: Text('Bulanan'),
                        ),
                        Padding(
                          padding: EdgeInsets.symmetric(horizontal: 16.0),
                          child: Text('Tahunan'),
                        ),
                      ],
                      onPressed: (int index) {
                        setState(() {
                          _selectedFrequency = index;
                        });
                      },
                    ),
                  ),
                ],
              ),
            ],
            const SizedBox(height: 30),
            if (_isThirdFieldFilled) ...[
              Row(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Container(
                    margin: const EdgeInsets.only(right: 10),
                    width: 8,
                    height: 8,
                    decoration: const BoxDecoration(
                      color: Colors.green,
                      shape: BoxShape.circle,
                    ),
                  ),
                  Expanded(
                    child: Text(
                      "Jumlah Setoran Yang akan Kamu Tabung Per ${getFrequencyText()}",
                      style: GoogleFonts.poppins(
                        color: Colors.white,
                        fontSize: 16,
                      ),
                    ),
                  ),
                ],
              ),
              const SizedBox(height: 10),
              TextFormField(
                controller: _jumlahsetoran,
                decoration: InputDecoration(
                  hintText: 'Jumlah Setoran',
                  prefixText: "Rp.",
                  hintStyle: GoogleFonts.poppins(color: Colors.white54),
                ),
                keyboardType: TextInputType.number,
                style: GoogleFonts.poppins(color: Colors.white),
                inputFormatters: [CurrencyInputFormatter()],
              ),
            ],
            const SizedBox(height: 40),
            Center(
              child: ElevatedButton(
                onPressed: () async {
                  final goal = _tujuanmenabung.text;
                  final moneygoal =
                      int.parse(_targetmenabung.text.replaceAll('.', ''));
                  final duration = int.parse(_durasimenabung.text);
                  final frequency = getFrequencyText();
                  final monthly =
                      int.parse(_jumlahsetoran.text.replaceAll('.', ''));

                  try {
                    final response = await _apiService.createSavings(
                        goal, moneygoal, duration, frequency, monthly);

                    final recommendation = response['recommendation'];

                    showDialog(
                      context: context,
                      builder: (BuildContext context) {
                        return AlertDialog(
                          backgroundColor:
                              const Color.fromARGB(255, 45, 45, 45),
                          title: Text(
                            'Hasil',
                            style: GoogleFonts.poppins(color: Colors.white),
                          ),
                          content: Text(
                            recommendation,
                            style: GoogleFonts.poppins(color: Colors.white),
                          ),
                          actions: [
                            TextButton(
                              onPressed: () {
                                Navigator.of(context).pop();
                                Navigator.push(
                                    context,
                                    MaterialPageRoute(
                                        builder: (context) => const ForecastScreen()));
                              },
                              child: Row(
                                children: [
                                  Text(
                                    'Cek Rekomendasi Saham',
                                    style: GoogleFonts.poppins(color: Colors.green),
                                  ),const Icon(Icons.arrow_forward_ios, color: Colors.green,)
                                ],
                              ),
                            ),
                          ],
                        );
                      },
                    );
                  } catch (e) {
                    // Handle error
                    ScaffoldMessenger.of(context).showSnackBar(
                      SnackBar(content: Text('Failed to create savings: $e')),
                    );
                  }
                },
                style: ElevatedButton.styleFrom(
                  padding: const EdgeInsets.symmetric(
                    horizontal: 50,
                    vertical: 20,
                  ),
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(15),
                  ),
                  backgroundColor: Colors.green,
                ),
                child: Text(
                  "Cek Rekomendasi",
                  style: GoogleFonts.poppins(
                    color: Colors.white,
                    fontSize: 18,
                  ),
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

class CurrencyInputFormatter extends TextInputFormatter {
  @override
  TextEditingValue formatEditUpdate(
      TextEditingValue oldValue, TextEditingValue newValue) {
    final intValue = int.tryParse(newValue.text.replaceAll('.', '')) ?? 0;
    final newText = intValue
        .toString()
        .replaceAllMapped(RegExp(r'\B(?=(\d{3})+(?!\d))'), (match) => '.');

    return newValue.copyWith(
      text: newText,
      selection: TextSelection.collapsed(offset: newText.length),
    );
  }
}
