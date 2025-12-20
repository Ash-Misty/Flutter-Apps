import 'package:flutter/material.dart';
import 'landing_screen.dart'; // this gives access to HomePageScreen

class SplashScreen extends StatelessWidget {
  const SplashScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xFFF5F7FA),
      body: SafeArea(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            const Spacer(),

            // App Logo
            Image.asset('assets/logo.jpg', width: 150, height: 150),

            const SizedBox(height: 24),

            // Quote
            const Text(
              "Track. Save. Thrive.",
              style: TextStyle(
                fontSize: 22,
                fontWeight: FontWeight.bold,
                color: Color(0xFF2C3E50),
                letterSpacing: 1,
              ),
            ),

            const SizedBox(height: 12),

            const Text(
              "Build smarter money habits\none jar at a time",
              textAlign: TextAlign.center,
              style: TextStyle(fontSize: 14, color: Colors.black54),
            ),

            const Spacer(),

            // Button
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 24, vertical: 20),
              child: ElevatedButton(
                onPressed: () {
                  Navigator.pushReplacement(
                    context,
                    MaterialPageRoute(builder: (_) => const LandingScreen()),
                  );
                },
                style: ElevatedButton.styleFrom(
                  backgroundColor: const Color(0xFF94B7EB),
                  foregroundColor: Colors.black87,
                  minimumSize: const Size(double.infinity, 52),
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(14),
                  ),
                ),
                child: const Text(
                  "Start My Journey",
                  style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
