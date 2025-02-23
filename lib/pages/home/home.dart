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
  final List<String> _tasks = [];
  final TextEditingController _taskController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.grey[200],
      appBar: AppBar(
        title: Text(
          'To-Do List 📝',
          style: GoogleFonts.poppins(
            textStyle: const TextStyle(
              fontWeight: FontWeight.bold,
              fontSize: 24,
            ),
          ),
        ),
        backgroundColor: Colors.indigo,
        foregroundColor: Colors.white,
      ),
      body: Padding(
        padding: const EdgeInsets.all(20),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
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
            const SizedBox(height: 20),
            TextField(
              controller: _taskController,
              decoration: InputDecoration(
                labelText: 'Tambah Tugas',
                border: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(12),
                ),
              ),
              onSubmitted: (value) => _addTask(),
            ),
            const SizedBox(height: 20),
            Expanded(
              child: ListView.builder(
                itemCount: _tasks.length,
                itemBuilder: (context, index) => Card(
                  margin: const EdgeInsets.symmetric(vertical: 8),
                  child: ListTile(
                    title: Text(
                      _tasks[index],
                      style: GoogleFonts.poppins(),
                    ),
                    trailing: IconButton(
                      icon: const Icon(Icons.delete, color: Colors.redAccent),
                      onPressed: () => _deleteTask(index),
                    ),
                  ),
                ),
              ),
            ),
            const SizedBox(height: 20),
            _logout(context),
          ],
        ),
      ),
    );
  }

  void _addTask() {
    if (_taskController.text.isNotEmpty) {
      setState(() {
        _tasks.add(_taskController.text);
        _taskController.clear();
      });
    }
  }

  void _deleteTask(int index) {
    setState(() {
      _tasks.removeAt(index);
    });
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
