import 'package:fingoal_frontend/Menu/saving.dart';
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
                        "Hi, Fahrizal",
                        style: GoogleFonts.poppins(
                            fontSize: 20,
                            fontWeight: FontWeight.bold,
                            color: Colors.white),
                      ),
                      Text(
                        "Good Morning",
                        style: GoogleFonts.poppins(
                            fontSize: 14, color: Colors.white),
                      ),
                    ],
                  ),
                  const Icon(
                    Icons.settings,
                    color: Colors.white,
                    size: 24.0,
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
                        "Profil Risk : Agresif",
                        style: GoogleFonts.poppins(
                            fontSize: 12,
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
                spacing: 20.0, // Space between items
                runSpacing: 20.0, // Space between rows
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
                      const Question();
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
                    onTap: () {},
                  ),
                  // Add more MenuItem widgets as needed
                ],
              ),
            ],
          ),
        ));
  }
}

class MenuItem extends StatelessWidget {
  final String title;
  final String image; // Changed from IconData to String
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
