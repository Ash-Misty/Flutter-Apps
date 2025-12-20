import 'package:flutter/material.dart';
import './screens/splash_screen.dart';

void main() {
  runApp(const JarWise());
}

class JarWise extends StatelessWidget {
  const JarWise({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      theme: ThemeData(
        useMaterial3: true,
        colorScheme: ColorScheme.fromSeed(seedColor: const Color(0xFF94B7EB)),
      ),
      home: const SplashScreen(),
    );
  }
}
