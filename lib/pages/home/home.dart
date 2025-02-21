import 'dart:math';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:authentication/services/auth_services.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';

class Home extends StatefulWidget {
  const Home({super.key});

  @override
  State<Home> createState() => _HomeState();
}

class _HomeState extends State<Home> {
  final List<Map<String, String>> _tekaTeki = [
    {
      "question": "Apa yang selalu naik tapi tidak pernah turun?",
      "answer": "Usia"
    },
    {
      "question": "Saya punya kunci, tapi tidak bisa membuka pintu. Apa saya?",
      "answer": "Piano"
    },
    {
      "question": "Semakin banyak diambil, semakin besar saya. Apa saya?",
      "answer": "Lubang"
    },
    {
      "question":
          "Saya punya tangan tapi tidak bisa bertepuk tangan. Apa saya?",
      "answer": "Jam"
    },
    {
      "question":
          "Apa yang lebih ringan dari bulu tapi tidak bisa dipegang lama?",
      "answer": "Napas"
    },
  ];

  int _currentIndex = 0;
  bool _showAnswer = false;

  void _randomTekaTeki() {
    setState(() {
      _currentIndex = Random().nextInt(_tekaTeki.length);
      _showAnswer = false;
    });
  }

  void _showTekaTekiAnswer() {
    setState(() {
      _showAnswer = true;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        decoration: const BoxDecoration(
          gradient: LinearGradient(
            colors: [Color(0xFF6A11CB), Color(0xFF2575FC)],
            begin: Alignment.topLeft,
            end: Alignment.bottomRight,
          ),
        ),
        child: SafeArea(
          child: Padding(
            padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 16),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                // Selamat Datang
                Text(
                  'Selamat Datang 👋',
                  style: GoogleFonts.raleway(
                    textStyle: const TextStyle(
                        color: Colors.white,
                        fontWeight: FontWeight.bold,
                        fontSize: 24),
                  ),
                ),
                const SizedBox(height: 10),
                Text(
                  FirebaseAuth.instance.currentUser!.email!.toString(),
                  style: GoogleFonts.raleway(
                    textStyle: const TextStyle(
                        color: Colors.white70,
                        fontWeight: FontWeight.bold,
                        fontSize: 18),
                  ),
                ),
                const SizedBox(height: 30),

                // Card Teka-Teki
                Container(
                  padding: const EdgeInsets.all(20),
                  decoration: BoxDecoration(
                    color: Colors.white,
                    borderRadius: BorderRadius.circular(20),
                    boxShadow: [
                      BoxShadow(
                        color: Colors.black.withOpacity(0.2),
                        blurRadius: 10,
                        spreadRadius: 2,
                      )
                    ],
                  ),
                  child: Column(
                    children: [
                      Text(
                        _tekaTeki[_currentIndex]["question"]!,
                        textAlign: TextAlign.center,
                        style: GoogleFonts.raleway(
                          textStyle: const TextStyle(
                              color: Colors.black,
                              fontWeight: FontWeight.bold,
                              fontSize: 18),
                        ),
                      ),
                      const SizedBox(height: 10),

                      // Tampilkan Jawaban jika ditekan
                      if (_showAnswer)
                        Text(
                          _tekaTeki[_currentIndex]["answer"]!,
                          textAlign: TextAlign.center,
                          style: GoogleFonts.raleway(
                            textStyle: const TextStyle(
                                color: Colors.green,
                                fontWeight: FontWeight.bold,
                                fontSize: 22),
                          ),
                        ),
                    ],
                  ),
                ),
                const SizedBox(height: 20),

                // Tombol Teka-Teki
                _buildButton(
                  icon: FontAwesomeIcons.lightbulb,
                  text: "Tampilkan Teka-Teki",
                  color: Colors.orange,
                  onPressed: _randomTekaTeki,
                ),

                const SizedBox(height: 10),

                // Tombol Jawaban
                _buildButton(
                  icon: FontAwesomeIcons.eye,
                  text: "Lihat Jawaban",
                  color: Colors.green,
                  onPressed: _showTekaTekiAnswer,
                ),

                const SizedBox(height: 30),

                // Tombol Logout
                _logout(context),
              ],
            ),
          ),
        ),
      ),
    );
  }

  Widget _buildButton(
      {required IconData icon,
      required String text,
      required Color color,
      required VoidCallback onPressed}) {
    return ElevatedButton.icon(
      style: ElevatedButton.styleFrom(
        backgroundColor: color,
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(14),
        ),
        minimumSize: const Size(double.infinity, 60),
        elevation: 5,
      ),
      onPressed: onPressed,
      icon: Icon(icon, color: Colors.white),
      label: Text(
        text,
        style: const TextStyle(fontSize: 16, color: Colors.white),
      ),
    );
  }

  Widget _logout(BuildContext context) {
    return ElevatedButton.icon(
      style: ElevatedButton.styleFrom(
        backgroundColor: Colors.red,
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(14),
        ),
        minimumSize: const Size(double.infinity, 60),
        elevation: 5,
      ),
      onPressed: () async {
        await AuthService().signout(context: context);
      },
      icon: const Icon(FontAwesomeIcons.signOutAlt, color: Colors.white),
      label: const Text(
        "Logout",
        style: TextStyle(fontSize: 17, color: Colors.white),
      ),
    );
  }
}
