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
                height: 50,
              ),
              Card(
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(10.0),
                ),
                color: Colors.green,
                child: Padding(
                  padding: const EdgeInsets.only(
                      left: 120, right: 120, top: 30, bottom: 30),
                  child: Column(
                    children: [
                      Text(
                        "Your Current Balance",
                        style: GoogleFonts.poppins(
                            fontSize: 16,
                            color: Colors.white,
                            fontWeight: FontWeight.bold),
                      ),
                      const SizedBox(height: 10,),
                      Text(
                        "Rp. 3.000.000",
                        style: GoogleFonts.poppins(
                            fontSize: 28,
                            color: Colors.white,
                            fontWeight: FontWeight.bold),
                      ),
                      const SizedBox(height: 10,),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Text(
                            "Latest Saving",
                            style: GoogleFonts.poppins(
                                fontSize: 12,
                                color: Colors.white,),
                          ),
                          const SizedBox(height: 10,),
                          Text(
                            "Rp. 56.000",
                            style: GoogleFonts.poppins(
                                fontSize: 12,
                                color: Colors.white,),
                          ),
                        ],
                      ),
                      const SizedBox(height: 10,),
                      const Divider(
                        color: Colors.white,
                        thickness: 3,
                      ),
                      const SizedBox(height: 10,),
                      Text(
                        "Investor Moderat",
                        style: GoogleFonts.poppins(
                            fontSize: 12,
                            color: Colors.white,
                            fontWeight: FontWeight.bold),
                      )
                    ],
                  ),
                ),
              )
            ],
          ),
        ));
  }
}
