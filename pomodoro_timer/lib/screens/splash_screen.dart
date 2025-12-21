import 'package:flutter/material.dart';
import 'pomodoro_screen.dart';

class SplashScreen extends StatelessWidget {
  const SplashScreen({super.key});

  void goToPomodoro(BuildContext context, int focusMinutes) {
    Navigator.pushReplacement(
      context,
      MaterialPageRoute(
        builder: (_) => PomodoroScreen(focusMinutes: focusMinutes),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SizedBox.expand(
        child: Container(
          decoration: const BoxDecoration(
            gradient: LinearGradient(
              colors: [Color(0xFFff6a6a), Color(0xFFff8e53)],
              begin: Alignment.topLeft,
              end: Alignment.bottomRight,
            ),
          ),
          child: SafeArea(
            child: Center(
              child: Column(
                mainAxisSize: MainAxisSize.min,
                children: [
                  // LOGO
                  Container(
                    padding: const EdgeInsets.all(16),
                    decoration: BoxDecoration(
                      shape: BoxShape.circle,
                      color: Colors.white.withOpacity(0.2),
                    ),
                    child: Image.asset('assets/logo.jpg', width: 120),
                  ),

                  const SizedBox(height: 30),

                  // TITLE
                  const Text(
                    "Pomodoro Timer",
                    style: TextStyle(
                      fontSize: 30,
                      fontWeight: FontWeight.bold,
                      color: Colors.white,
                      letterSpacing: 1.2,
                    ),
                  ),

                  const SizedBox(height: 8),

                  const Text(
                    "Focus • Break • Repeat",
                    style: TextStyle(color: Colors.white70, fontSize: 16),
                  ),

                  const SizedBox(height: 60),

                  _focusButton(
                    text: "20 MIN FOCUS",
                    onTap: () => goToPomodoro(context, 20),
                  ),

                  const SizedBox(height: 18),

                  _focusButton(
                    text: "25 MIN FOCUS",
                    onTap: () => goToPomodoro(context, 25),
                  ),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }

  Widget _focusButton({required String text, required VoidCallback onTap}) {
    return SizedBox(
      width: 240,
      child: ElevatedButton(
        onPressed: onTap,
        style: ElevatedButton.styleFrom(
          backgroundColor: Colors.white,
          foregroundColor: Colors.black,
          padding: const EdgeInsets.symmetric(vertical: 18),
          elevation: 6,
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(20),
          ),
        ),
        child: Text(
          text,
          style: const TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
        ),
      ),
    );
  }
}
