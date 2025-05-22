import 'package:flutter/material.dart';
import 'student_detail_3.dart';

class StudentDetail2 extends StatelessWidget {
  const StudentDetail2({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xFFE0F2F1), 
      appBar: AppBar(
        title: const Text('CSE-A'),
        backgroundColor: Colors.indigo[600], 
        titleTextStyle: const TextStyle(
          color: Colors.white,
          fontSize: 20,
          fontWeight: FontWeight.bold,
        ),
        centerTitle: true,
        elevation: 2.0,
      ),
      floatingActionButton: TextButton.icon(
        onPressed: () {
          Navigator.push(context, MaterialPageRoute(builder: (_) => const StudentDetail3()));
        },
        icon: const Icon(Icons.arrow_forward, color: Colors.white),
        label: const Text(
          'Next',
          style: TextStyle(fontSize: 16.0, color: Colors.white),
        ),
        style: TextButton.styleFrom(
          backgroundColor: Colors.teal[700],
          padding: const EdgeInsets.symmetric(horizontal: 20.0, vertical: 10.0),
          shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(10.0)),
        ),
      ),
      body: Padding(
        padding: const EdgeInsets.fromLTRB(30.0, 40.0, 30.0, 0.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            const Text(
              'STUDENT INFORMATION',
              style: TextStyle(
                color: Colors.teal,
                letterSpacing: 2.0,
                fontSize: 16.0,
                fontWeight: FontWeight.bold,
              ),
            ),
            const SizedBox(height: 15.0),
            Center(
              child: ClipOval(
                child: Image.asset(
                  'assets/saran.jpeg',
                  width: 90,
                  height: 90,
                  fit: BoxFit.cover,
                ),
              ),
            ),
            const Divider(height: 60.0, color: Colors.teal),
            Row(
              children: const [
                Icon(Icons.person, color: Colors.indigo),
                SizedBox(width: 10),
                Text(
                  'Name',
                  style: TextStyle(
                    color: Colors.indigo,
                    letterSpacing: 1.5,
                    fontSize: 16,
                    fontWeight: FontWeight.w600,
                  ),
                ),
              ],
            ),
            const SizedBox(height: 8.0),
            const Padding(
              padding: EdgeInsets.only(left: 35.0),
              child: Text(
                'Saran',
                style: TextStyle(
                  color: Colors.teal,
                  letterSpacing: 1.5,
                  fontSize: 22.0,
                  fontWeight: FontWeight.bold,
                ),
              ),
            ),
            const SizedBox(height: 15.0),
            Row(
              children: const [
                Icon(Icons.badge, color: Colors.indigo),
                SizedBox(width: 10),
                Text(
                  'Register Number',
                  style: TextStyle(
                    color: Colors.indigo,
                    letterSpacing: 1.5,
                    fontSize: 16,
                    fontWeight: FontWeight.w600,
                  ),
                ),
              ],
            ),
            const SizedBox(height: 8.0),
            const Padding(
              padding: EdgeInsets.only(left: 35.0),
              child: Text(
                '810023104003',
                style: TextStyle(
                  color: Colors.teal,
                  letterSpacing: 1.5,
                  fontSize: 22.0,
                  fontWeight: FontWeight.bold,
                ),
              ),
            ),
            const SizedBox(height: 15.0),
            Row(
              children: [
                const Icon(Icons.email, color: Colors.indigo),
                const SizedBox(width: 10),
                Text(
                  'saran@gmail.com',
                  style: TextStyle(
                    color: Colors.teal[700],
                    letterSpacing: 1.5,
                    fontSize: 20,
                    fontWeight: FontWeight.bold,
                  ),
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }
}
