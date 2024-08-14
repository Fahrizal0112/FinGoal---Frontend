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
  final TextEditingController _firstController = TextEditingController();
  final TextEditingController _secondController = TextEditingController();
  final TextEditingController _thirdController = TextEditingController();

  bool _isFirstFieldFilled = false;
  bool _isSecondFieldFilled = false;
  bool _isThirdFieldFilled = false;

  int _selectedDuration = 0;
  int _selectedFrequency = 0;

  @override
  void initState() {
    super.initState();
    _firstController.addListener(() {
      setState(() {
        _isFirstFieldFilled = _firstController.text.isNotEmpty;
      });
    });

    _secondController.addListener(() {
      setState(() {
        _isSecondFieldFilled = _secondController.text.isNotEmpty;
      });
    });

    _thirdController.addListener(() {
      setState(() {
        _isThirdFieldFilled = _thirdController.text.isNotEmpty;
      });
    });
  }

  @override
  void dispose() {
    _firstController.dispose();
    _secondController.dispose();
    _thirdController.dispose();
    super.dispose();
  }

  String getFrequencyText() {
    switch (_selectedFrequency) {
      case 0:
        return "Hari";
      case 1:
        return "Bulan";
      case 2:
        return "Tahun";
      default:
        return "Hari";
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
              controller: _firstController,
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
                controller: _secondController,
                decoration: InputDecoration(
                  hintText: 'Ammount',
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
                      controller: _thirdController,
                      decoration: InputDecoration(
                        hintText: 'Ammount',
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
                decoration: InputDecoration(
                  hintText: 'Jumlah Setoran',
                  hintStyle: GoogleFonts.poppins(color: Colors.white54),
                ),
                keyboardType: TextInputType.number,
                style: GoogleFonts.poppins(color: Colors.white),
                inputFormatters: [
                  CurrencyInputFormatter(), // Add the custom formatter here
                ],
              ),
            ],
            const SizedBox(height: 30),
            Center(
              child: TextButton(
                onPressed: () {},
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.end,
                  children: [
                    Text(
                      "Lihat Rekomendasi",
                      style: GoogleFonts.poppins(color: Colors.white),
                    ),
                    const SizedBox(width: 10),
                    const Icon(
                      Icons.arrow_forward_ios,
                      color: Colors.green,
                    ),
                  ],
                ),
              ),
            ),
            const SizedBox(height: 30),
          ],
        ),
      ),
    );
  }
}

class CurrencyInputFormatter extends TextInputFormatter {
  @override
  TextEditingValue formatEditUpdate(
    TextEditingValue oldValue,
    TextEditingValue newValue,
  ) {
    final text = newValue.text;
    final isEditing = oldValue.text != text;
    if (text.isEmpty) return newValue;

    final buffer = StringBuffer();
    final digits = text.replaceAll(RegExp(r'\D'), '');

    for (int i = 0; i < digits.length; i++) {
      if (i > 0 && (digits.length - i) % 3 == 0) buffer.write('.');
      buffer.write(digits[i]);
    }

    return newValue.copyWith(
      text: 'Rp. ${buffer.toString()}',
      selection: TextSelection.collapsed(offset: buffer.length + 4),
    );
  }
}
