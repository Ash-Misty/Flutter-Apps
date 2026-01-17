import 'dart:ui';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:google_sign_in/google_sign_in.dart';
import 'home_screen.dart';
import 'register_screen.dart';

class LoginScreen extends StatefulWidget {
  const LoginScreen({super.key});

  @override
  State<LoginScreen> createState() => _LoginScreenState();
}

class _LoginScreenState extends State<LoginScreen> {
  final _formKey = GlobalKey<FormState>();
  bool obscurePassword = true;
  String? activeField;

  bool hoverLogin = false;
  bool hoverGoogle = false;

  final TextEditingController _userController = TextEditingController();
  final TextEditingController _passController = TextEditingController();

  final FirebaseAuth _auth = FirebaseAuth.instance;
  final GoogleSignIn _googleSignIn = GoogleSignIn();

  ///  EMAIL/PASSWORD LOGIN
  Future<void> _handleLogin() async {
    if (!_formKey.currentState!.validate()) return;

    try {
      final userCredential = await _auth.signInWithEmailAndPassword(
        email: _userController.text.trim(),
        password: _passController.text.trim(),
      );

      if (userCredential.user != null && mounted) {
        Navigator.pushReplacement(
          context,
          MaterialPageRoute(builder: (_) => const HomeScreen()),
        );
      }
    } on FirebaseAuthException catch (e) {
      String msg = 'Login failed';
      if (e.code == 'user-not-found') msg = 'No user found for this email';
      if (e.code == 'wrong-password') msg = 'Incorrect password';

      ScaffoldMessenger.of(context).showSnackBar(SnackBar(content: Text(msg)));
    }
  }

  ///  GOOGLE SIGN-IN
  Future<void> _handleGoogleLogin() async {
    try {
      final googleUser = await _googleSignIn.signIn();
      if (googleUser == null) return; // User cancelled

      final googleAuth = await googleUser.authentication;
      final credential = GoogleAuthProvider.credential(
        accessToken: googleAuth.accessToken,
        idToken: googleAuth.idToken,
      );

      await _auth.signInWithCredential(credential);

      if (mounted) {
        Navigator.pushReplacement(
          context,
          MaterialPageRoute(builder: (_) => const HomeScreen()),
        );
      }
    } catch (e) {
      ScaffoldMessenger.of(
        context,
      ).showSnackBar(const SnackBar(content: Text('Google Sign-In failed')));
    }
  }

  @override
  Widget build(BuildContext context) {
    final size = MediaQuery.of(context).size;

    return Scaffold(
      resizeToAvoidBottomInset: false,
      body: Stack(
        children: [
          Positioned.fill(
            child: Image.asset("assets/images/login_bg.png", fit: BoxFit.cover),
          ),
          Container(
            decoration: const BoxDecoration(
              gradient: LinearGradient(
                begin: Alignment.topCenter,
                end: Alignment.bottomCenter,
                colors: [
                  Color(0x99050B1E),
                  Color(0x99081A36),
                  Color(0x99040A1A),
                ],
              ),
            ),
          ),
          SafeArea(
            child: SingleChildScrollView(
              physics: const BouncingScrollPhysics(),
              padding: EdgeInsets.only(
                bottom: MediaQuery.of(context).viewInsets.bottom,
              ),
              child: Column(
                children: [
                  const SizedBox(height: 18),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Image.asset("assets/images/skillgap_logo.png", width: 40),
                      const SizedBox(width: 2),
                      Text(
                        "SkillGap",
                        style: GoogleFonts.poppins(
                          fontSize: 28,
                          fontWeight: FontWeight.w600,
                          color: Colors.white,
                        ),
                      ),
                    ],
                  ),
                  const SizedBox(height: 16),
                  Text(
                    "Sign in to your account",
                    style: GoogleFonts.poppins(
                      fontSize: 20,
                      fontWeight: FontWeight.w600,
                      color: Colors.white,
                    ),
                  ),
                  const SizedBox(height: 6),
                  Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 40),
                    child: Text(
                      "Identify & close skill gaps for your desired job.",
                      textAlign: TextAlign.center,
                      style: GoogleFonts.poppins(
                        fontSize: 12,
                        color: Colors.white70,
                      ),
                    ),
                  ),
                  const SizedBox(height: 18),

                  // FORM
                  Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 22),
                    child: ClipRRect(
                      borderRadius: BorderRadius.circular(18),
                      child: BackdropFilter(
                        filter: ImageFilter.blur(sigmaX: 8, sigmaY: 8),
                        child: Container(
                          padding: const EdgeInsets.all(14),
                          decoration: BoxDecoration(
                            color: const Color(0xFF1A1F2E).withOpacity(0.5),
                            borderRadius: BorderRadius.circular(18),
                          ),
                          child: Form(
                            key: _formKey,
                            child: Column(
                              children: [
                                _inputField(
                                  id: "user",
                                  controller: _userController,
                                  icon: Icons.person_outline,
                                  hint: "email@example.com",
                                  validator: (v) =>
                                      v!.isEmpty ? "Enter email" : null,
                                ),
                                const SizedBox(height: 10),
                                _inputField(
                                  id: "pass",
                                  controller: _passController,
                                  icon: Icons.lock_outline,
                                  hint: "••••••••",
                                  isPassword: true,
                                  validator: (v) => v!.length < 6
                                      ? "Password too short"
                                      : null,
                                ),
                                const SizedBox(height: 14),

                                //LOGIN BUTTON
                                GestureDetector(
                                  onTap: _handleLogin,
                                  onTapDown: (_) =>
                                      setState(() => hoverLogin = true),
                                  onTapUp: (_) =>
                                      setState(() => hoverLogin = false),
                                  onTapCancel: () =>
                                      setState(() => hoverLogin = false),
                                  child: AnimatedScale(
                                    scale: hoverLogin ? 0.97 : 1,
                                    duration: const Duration(milliseconds: 150),
                                    child: Container(
                                      width: double.infinity,
                                      height: 46,
                                      decoration: BoxDecoration(
                                        borderRadius: BorderRadius.circular(30),
                                        gradient: const LinearGradient(
                                          colors: [
                                            Color(0xFF00FF9C),
                                            Color(0xFF00E5FF),
                                          ],
                                        ),
                                      ),
                                      child: Center(
                                        child: Text(
                                          "Log In",
                                          style: GoogleFonts.poppins(
                                            fontSize: 15,
                                            fontWeight: FontWeight.w600,
                                            color: Colors.black,
                                          ),
                                        ),
                                      ),
                                    ),
                                  ),
                                ),

                                const SizedBox(height: 14),

                                // GOOGLE LOGIN BUTTON
                                GestureDetector(
                                  onTap: _handleGoogleLogin,
                                  child: AnimatedScale(
                                    scale: hoverGoogle ? 0.97 : 1,
                                    duration: const Duration(milliseconds: 150),
                                    child: Container(
                                      width: double.infinity,
                                      padding: const EdgeInsets.symmetric(
                                        vertical: 12,
                                      ),
                                      decoration: BoxDecoration(
                                        color: Colors.white.withOpacity(0.15),
                                        borderRadius: BorderRadius.circular(30),
                                        border: Border.all(
                                          color: Colors.white24,
                                          width: 1,
                                        ),
                                      ),
                                      child: Row(
                                        mainAxisAlignment:
                                            MainAxisAlignment.center,
                                        children: [
                                          Image.asset(
                                            "assets/images/google_logo.png",
                                            height: 22,
                                          ),
                                          const SizedBox(width: 8),
                                          Text(
                                            "Continue with Google",
                                            style: GoogleFonts.poppins(
                                              fontSize: 14,
                                              fontWeight: FontWeight.w600,
                                              color: Colors.white,
                                            ),
                                          ),
                                        ],
                                      ),
                                    ),
                                  ),
                                ),

                                const SizedBox(height: 12),

                                // REGISTER LINK
                                GestureDetector(
                                  onTap: () {
                                    Navigator.push(
                                      context,
                                      MaterialPageRoute(
                                        builder: (_) => const RegisterScreen(),
                                      ),
                                    );
                                  },
                                  child: RichText(
                                    text: TextSpan(
                                      text: "Don't have an account? ",
                                      style: GoogleFonts.poppins(
                                        color: Colors.white70,
                                        fontSize: 12,
                                      ),
                                      children: [
                                        TextSpan(
                                          text: "Register",
                                          style: GoogleFonts.poppins(
                                            color: Colors.cyanAccent,
                                            fontWeight: FontWeight.bold,
                                          ),
                                        ),
                                      ],
                                    ),
                                  ),
                                ),
                              ],
                            ),
                          ),
                        ),
                      ),
                    ),
                  ),

                  const SizedBox(height: 20),
                  Image.asset(
                    "assets/images/login.png",
                    width: size.width * 0.7,
                  ),
                  const SizedBox(height: 20),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }

  Widget _inputField({
    required String id,
    required IconData icon,
    required String hint,
    required TextEditingController controller,
    String? Function(String?)? validator,
    bool isPassword = false,
  }) {
    bool isFocused = activeField == id;

    return AnimatedContainer(
      duration: const Duration(milliseconds: 300),
      padding: const EdgeInsets.symmetric(horizontal: 14),
      decoration: BoxDecoration(
        color: isFocused
            ? Colors.white.withOpacity(0.15)
            : Colors.white.withOpacity(0.09),
        borderRadius: BorderRadius.circular(14),
        border: Border.all(
          color: isFocused ? const Color(0xFF00FF9C) : Colors.transparent,
        ),
      ),
      child: Row(
        children: [
          Icon(
            icon,
            color: isFocused ? const Color(0xFF00FF9C) : Colors.white70,
            size: 18,
          ),
          const SizedBox(width: 10),
          Expanded(
            child: TextFormField(
              controller: controller,
              onTap: () => setState(() => activeField = id),
              obscureText: isPassword ? obscurePassword : false,
              validator: validator,
              style: GoogleFonts.poppins(color: Colors.white, fontSize: 13),
              decoration: InputDecoration(
                border: InputBorder.none,
                hintText: hint,
                hintStyle: GoogleFonts.poppins(
                  color: Colors.white38,
                  fontSize: 12,
                ),
              ),
            ),
          ),
          if (isPassword)
            IconButton(
              icon: Icon(
                obscurePassword ? Icons.visibility_off : Icons.visibility,
                color: Colors.white54,
                size: 18,
              ),
              onPressed: () =>
                  setState(() => obscurePassword = !obscurePassword),
            ),
        ],
      ),
    );
  }
}
