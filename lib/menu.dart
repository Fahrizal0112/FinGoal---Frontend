import 'package:fingoal_frontend/Forecast/forecaststocks.dart';
import 'package:fingoal_frontend/Menu/saving.dart';
import 'package:fingoal_frontend/Service/api_service.dart';
import 'package:fingoal_frontend/Sign/signin.dart';
import 'package:fingoal_frontend/question/question.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

class Menu extends StatefulWidget {
  const Menu({super.key});

  @override
  State<Menu> createState() {
    return _MenuState();
  }
}

class _MenuState extends State<Menu> {
  String? lastname;
  String? risk;
  String greeting = '';
  final ApiService _apiService = ApiService();

  @override
  void initState() {
    super.initState();
    fetchLastname();
    fetchRisk();
    setGreeting();
  }

  void fetchLastname() async {
    try {
      final data = await _apiService.getLastname();
      final fetchedLastname = data['lastname'];
      debugPrint('Lastname: $fetchedLastname');

      setState(() {
        lastname = fetchedLastname;
      });
    } catch (e) {
      debugPrint('Error fetching lastname: $e');
    }
  }

  void fetchRisk() async {
    try {
      final data = await _apiService.getRisk();
      final fetchedRisk = data['accountType'];
      debugPrint('Risk: $fetchedRisk');

      setState(() {
        risk = fetchedRisk;
      });
    } catch (e) {
      debugPrint('Error fetching risk: $e');
    }
  }

  void setGreeting() {
    final hour = DateTime.now().hour;

    if (hour < 12) {
      greeting = "Good Morning";
    } else if (hour < 17) {
      greeting = "Good Afternoon";
    } else {
      greeting = "Good Evening";
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        backgroundColor: const Color.fromARGB(255, 45, 45, 45),
        body: Padding(
          padding: const EdgeInsets.all(25.0),
          child: Column(
            children: [
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      const SizedBox(
                        height: 30,
                      ),
                      Text(
                        "Hi, $lastname",
                        style: GoogleFonts.poppins(
                            fontSize: 20,
                            fontWeight: FontWeight.bold,
                            color: Colors.white),
                      ),
                      Text(
                        greeting,
                        style: GoogleFonts.poppins(
                            fontSize: 14, color: Colors.white),
                      ),
                    ],
                  ),
                  PopupMenuButton<int>(
                    icon: const Icon(
                      Icons.settings,
                      color: Colors.white,
                      size: 24.0,
                    ),
                    onSelected: (value) {
                      if (value == 0) {
                        // Aksi untuk logout
                        Navigator.push(context,
                            MaterialPageRoute(builder: (context) => const SignInPage(),));
                      }
                    },
                    itemBuilder: (context) => [
                      const PopupMenuItem<int>(
                        value: 0,
                        child: Row(
                          children: [
                            Icon(Icons.logout, color: Colors.black),
                            SizedBox(width: 8),
                            Text("Logout"),
                          ],
                        ),
                      ),
                    ],
                  ),
                ],
              ),
              const SizedBox(
                height: 10,
              ),
              Card(
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(10.0),
                ),
                color: Colors.green,
                child: Padding(
                  padding: const EdgeInsets.only(
                      left: 80, right: 80, top: 30, bottom: 30),
                  child: Column(
                    children: [
                      Text(
                        risk != null ? "Profil Risk : $risk" : "Yu cek Profile risk dulu",
                        style: GoogleFonts.poppins(
                            fontSize: 10,
                            color: Colors.white,
                            fontWeight: FontWeight.bold),
                      ),
                    ],
                  ),
                ),
              ),
              const SizedBox(
                height: 20,
              ),
              Wrap(
                spacing: 20.0,
                runSpacing: 20.0,
                children: [
                  MenuItem(
                    title: "Check Profile Risk",
                    image: "assets/images/risk.png",
                    onTap: () {
                      Navigator.push(
                        context,
                        MaterialPageRoute(
                            builder: (context) => const Question()),
                      );
                    },
                  ),
                  MenuItem(
                    title: "Savings",
                    image: "assets/images/savings.png",
                    onTap: () {
                      Navigator.push(
                        context,
                        MaterialPageRoute(builder: (context) => const Saving()),
                      );
                    },
                  ),
                  MenuItem(
                    title: "Forecast Stocks",
                    image: "assets/images/Stocks.png",
                    onTap: () {
                      Navigator.push(context, MaterialPageRoute(builder: (context) => const ForecastScreen()));
                    },
                  ),
                ],
              ),
            ],
          ),
        ));
  }
}

class MenuItem extends StatelessWidget {
  final String title;
  final String image;
  final VoidCallback onTap;

  const MenuItem({
    required this.title,
    required this.image,
    required this.onTap,
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onTap,
      child: Column(
        children: [
          Card(
            color: Colors.transparent,
            margin: const EdgeInsets.all(10.0),
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(10.0),
            ),
            child: Container(
              width: 100,
              height: 100,
              alignment: Alignment.center,
              child: Image.asset(
                image,
                fit: BoxFit.cover,
              ),
            ),
          ),
          const SizedBox(height: 8.0),
          Text(
            title,
            style: GoogleFonts.poppins(
              fontSize: 14,
              color: Colors.white,
              fontWeight: FontWeight.bold,
            ),
          ),
        ],
      ),
    );
  }
}
