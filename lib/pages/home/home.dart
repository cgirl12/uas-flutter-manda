import 'dart:math';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:authentication/services/auth_services.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

class Home extends StatefulWidget {
  const Home({super.key});

  @override
  State<Home> createState() => _HomeState();
}

class _HomeState extends State<Home> {
  final List<String> _faktaUnik = [
    "Jantung paus biru sebesar mobil kecil dan bisa didengar dari 3 km jauhnya.",
    "Ada lebih banyak bintang di alam semesta daripada butiran pasir di semua pantai di Bumi.",
    "Air panas membeku lebih cepat daripada air dingin, fenomena ini disebut efek Mpemba.",
    "Gajah adalah satu-satunya hewan yang tidak bisa melompat.",
    "Madu tidak pernah basi, bahkan madu dari 3000 tahun lalu masih bisa dimakan.",
    "Cumi-cumi raksasa memiliki mata sebesar bola basket.",
    "Buaya tidak bisa menjulurkan lidahnya.",
    "Gunung Everest tumbuh sekitar 4 mm setiap tahun.",
    "Di Venus, satu hari lebih panjang dari satu tahun.",
  ];

  int _currentIndex = 0;

  void _randomFaktaUnik() {
    setState(() {
      _currentIndex = Random().nextInt(_faktaUnik.length);
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.grey[200],
      body: SafeArea(
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 16),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              Text(
                'Hello 👋',
                style: GoogleFonts.poppins(
                  textStyle: const TextStyle(
                    color: Colors.black,
                    fontWeight: FontWeight.bold,
                    fontSize: 22,
                  ),
                ),
              ),
              const SizedBox(height: 8),
              Text(
                FirebaseAuth.instance.currentUser?.email ?? "User",
                style: GoogleFonts.poppins(
                  textStyle: TextStyle(
                    color: Colors.grey[700],
                    fontSize: 18,
                  ),
                ),
              ),
              const SizedBox(height: 30),

              // Fakta Unik dalam Card
              Card(
                elevation: 5,
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(16),
                ),
                child: Padding(
                  padding: const EdgeInsets.all(16.0),
                  child: Column(
                    children: [
                      Text(
                        "Fakta Unik 🔍",
                        style: GoogleFonts.poppins(
                          textStyle: const TextStyle(
                            color: Colors.black,
                            fontWeight: FontWeight.bold,
                            fontSize: 20,
                          ),
                        ),
                      ),
                      const SizedBox(height: 10),
                      AnimatedSwitcher(
                        duration: const Duration(milliseconds: 500),
                        child: Text(
                          _faktaUnik[_currentIndex],
                          key: ValueKey<int>(_currentIndex),
                          textAlign: TextAlign.center,
                          style: GoogleFonts.poppins(
                            textStyle: TextStyle(
                              color: Colors.grey[800],
                              fontSize: 16,
                            ),
                          ),
                        ),
                      ),
                    ],
                  ),
                ),
              ),
              const SizedBox(height: 20),

              // Tombol Fakta Unik
              ElevatedButton(
                style: ElevatedButton.styleFrom(
                  backgroundColor: Colors.orangeAccent,
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(14),
                  ),
                  minimumSize: const Size(double.infinity, 50),
                ),
                onPressed: _randomFaktaUnik,
                child: const Text(
                  "Tampilkan Fakta Unik 🌍",
                  style: TextStyle(fontSize: 16, color: Colors.white),
                ),
              ),
              const SizedBox(height: 30),

              // Tombol Logout
              _logout(context),
            ],
          ),
        ),
      ),
    );
  }

  Widget _logout(BuildContext context) {
    return ElevatedButton(
      style: ElevatedButton.styleFrom(
        backgroundColor: Colors.redAccent,
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(14),
        ),
        minimumSize: const Size(double.infinity, 50),
      ),
      onPressed: () async {
        await AuthService().signout(context: context);
      },
      child: const Text(
        "Logout",
        style: TextStyle(fontSize: 17, color: Colors.white),
      ),
    );
  }
}
