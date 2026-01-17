import 'dart:math';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'login_screen.dart'; 

class SplashScreen extends StatefulWidget {
  const SplashScreen({super.key});

  @override
  State<SplashScreen> createState() => _SplashScreenState();
}

class _SplashScreenState extends State<SplashScreen>
    with SingleTickerProviderStateMixin {
  late AnimationController _controller;

  @override
  void initState() {
    super.initState();

    _controller = AnimationController(
      vsync: this,
      duration: const Duration(seconds: 3),
    )..repeat();

  
    Future.delayed(const Duration(seconds: 4), () {
      if (!mounted) return;

      Navigator.of(context).pushReplacement(
        PageRouteBuilder(
          transitionDuration: const Duration(milliseconds: 900),
          pageBuilder: (_, __, ___) => const LoginScreen(),
          transitionsBuilder: (_, animation, __, child) {
            return FadeTransition(
              opacity: CurvedAnimation(
                parent: animation,
                curve: Curves.easeInOut,
              ),
              child: child,
            );
          },
        ),
      );
    });
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  //BLINKING MAGIC PARTICLE
  Widget magicParticle(double top, double left, double size, double phase) {
    return AnimatedBuilder(
      animation: _controller,
      builder: (_, __) {
        final opacity =
            0.35 + (sin((_controller.value * pi * 2) + phase) * 0.65);

        return Positioned(
          top: top,
          left: left,
          child: Opacity(
            opacity: opacity.clamp(0.3, 1.0),
            child: Container(
              height: size,
              width: size,
              decoration: BoxDecoration(
                shape: BoxShape.circle,
                color: Colors.cyanAccent,
                boxShadow: [
                  BoxShadow(
                    color: Colors.cyanAccent.withOpacity(0.9),
                    blurRadius: 22,
                    spreadRadius: 4,
                  ),
                ],
              ),
            ),
          ),
        );
      },
    );
  }

  // FLOATING JOB ICON
  Widget floatingIcon(
      IconData icon, double top, double left, double size, double phase) {
    return AnimatedBuilder(
      animation: _controller,
      builder: (_, __) {
        final offset = sin((_controller.value * pi * 2) + phase) * 10;

        return Positioned(
          top: top + offset,
          left: left,
          child: Opacity(
            opacity: 0.6,
            child: Icon(
              icon,
              size: size,
              color: Colors.cyanAccent,
            ),
          ),
        );
      },
    );
  }

  @override
  Widget build(BuildContext context) {
    final h = MediaQuery.of(context).size.height;
    final w = MediaQuery.of(context).size.width;

    return Scaffold(
      body: Container(
        decoration: const BoxDecoration(
          gradient: RadialGradient(
            center: Alignment.topCenter,
            radius: 1.4,
            colors: [Color(0xFF0E2A47), Color(0xFF050B1E)],
          ),
        ),
        child: Stack(
          children: [
            //TOP PARTICLES
            magicParticle(h * 0.01, w * 0.02, 8, 11),
            magicParticle(h * 0.02, w * 0.05, 10, 12),
            magicParticle(h * 0.03, w * 0.12, 9, 12.5),
            magicParticle(h * 0.03, w * 0.20, 12, 13),
            magicParticle(h * 0.04, w * 0.30, 7, 13.5),
            magicParticle(h * 0.04, w * 0.40, 8, 14),
            magicParticle(h * 0.05, w * 0.50, 10, 14.5),
            magicParticle(h * 0.05, w * 0.60, 11, 15),
            magicParticle(h * 0.06, w * 0.70, 9, 15.5),
            magicParticle(h * 0.06, w * 0.75, 9, 16),
            magicParticle(h * 0.07, w * 0.85, 8, 16.5),
            magicParticle(h * 0.07, w * 0.90, 10, 17),

            // MID PARTICLES
            magicParticle(h * 0.30, w * 0.15, 12, 5),
            magicParticle(h * 0.34, w * 0.78, 14, 6),

            // BOTTOM PARTICLES
            magicParticle(h * 0.90, w * 0.03, 8, 18.2),
            magicParticle(h * 0.92, w * 0.10, 9, 18.5),
            magicParticle(h * 0.93, w * 0.05, 10, 18),
            magicParticle(h * 0.94, w * 0.15, 11, 18.8),
            magicParticle(h * 0.95, w * 0.05, 10, 18),
            magicParticle(h * 0.96, w * 0.20, 12, 19),
            magicParticle(h * 0.97, w * 0.40, 8, 20),
            magicParticle(h * 0.98, w * 0.60, 11, 21),
            magicParticle(h * 0.99, w * 0.75, 9, 22),
            magicParticle(h * 0.985, w * 0.90, 7, 22.5),

            // FLOATING ICONS AROUND ILLUSTRATION
            floatingIcon(Icons.work_outline, h * 0.22, w * 0.08, 34, 1),
            floatingIcon(Icons.school_outlined, h * 0.24, w * 0.78, 36, 2),
            floatingIcon(Icons.code, h * 0.28, w * 0.14, 32, 3),
            floatingIcon(Icons.trending_up, h * 0.38, w * 0.80, 32, 6),

            //  FLOATING ICONS AROUND SPLASH ILLUSTRATION
            floatingIcon(Icons.lightbulb_outline, h * 0.15, w * 0.30, 28, 7),
            floatingIcon(Icons.star_outline, h * 0.18, w * 0.60, 26, 8),
            floatingIcon(Icons.analytics_outlined, h * 0.25, w * 0.25, 30, 9),
            floatingIcon(Icons.auto_graph_outlined, h * 0.28, w * 0.65, 24, 10),
            floatingIcon(Icons.workspace_premium_outlined, h * 0.20, w * 0.50, 22, 11),
            floatingIcon(Icons.bar_chart_outlined, h * 0.32, w * 0.40, 28, 12),
            floatingIcon(Icons.trending_flat, h * 0.26, w * 0.70, 24, 13),

            // CENTER CONTENT
            Center(
              child: Column(
                mainAxisSize: MainAxisSize.min,
                children: [
                  Transform.translate(
                    offset: const Offset(0, -20),
                    child: Image.asset(
                      'assets/images/splash_illustration.png',
                      height: 280,
                    ),
                  ),
                  const SizedBox(height: 50),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Image.asset(
                        'assets/images/skillgap_logo.png',
                        height: 60,
                      ),
                      const SizedBox(width: 6),
                      Text(
                        'SkillGap',
                        style: GoogleFonts.poppins(
                          fontSize: 30,
                          fontWeight: FontWeight.w800,
                          color: Colors.white,
                        ),
                      ),
                    ],
                  ),
                  const SizedBox(height: 8),
                  Text(
                    'Job Skill Gap Analyzer',
                    style: GoogleFonts.poppins(
                      fontSize: 18,
                      color: Colors.white70,
                    ),
                  ),
                ],
              ),
            ),

            // LOADING
            Positioned(
              bottom: 50,
              left: 0,
              right: 0,
              child: Column(
                children: [
                  const SizedBox(
                    height: 22,
                    width: 22,
                    child: CircularProgressIndicator(
                      strokeWidth: 2.4,
                      valueColor:
                          AlwaysStoppedAnimation(Color(0xFF3AF7A0)),
                    ),
                  ),
                  const SizedBox(height: 12),
                  Text(
                    'Please wait...',
                    style: GoogleFonts.poppins(
                      fontSize: 14,
                      color: Colors.white54,
                    ),
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}