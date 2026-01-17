import 'package:flutter/material.dart';
import 'package:firebase_auth/firebase_auth.dart';
import './screens/login_screen.dart';
import './screens/register_screen.dart';
import './screens/home_screen.dart';

class AuthGate extends StatelessWidget {
  const AuthGate({super.key});

  @override
  Widget build(BuildContext context) {
    return StreamBuilder<User?>(
      stream: FirebaseAuth.instance.authStateChanges(),
      builder: (context, snapshot) {
        // 🔄 Loading
        if (snapshot.connectionState == ConnectionState.waiting) {
          return const Scaffold(
            body: Center(child: CircularProgressIndicator()),
          );
        }

        // ✅ Logged in
        if (snapshot.hasData) {
          return const HomeScreen();
        }

        // ❌ Not logged in
        return const LoginScreen();
      },
    );
  }
}
