import 'dart:async';
import 'dart:math';
import 'package:flutter/material.dart';
import 'package:audioplayers/audioplayers.dart';
import 'package:flutter_tts/flutter_tts.dart';

class PomodoroScreen extends StatefulWidget {
  final int focusMinutes;

  const PomodoroScreen({super.key, required this.focusMinutes});

  @override
  State<PomodoroScreen> createState() => _PomodoroScreenState();
}

class _PomodoroScreenState extends State<PomodoroScreen> {
  late int focusTime;
  static const int breakTime = 5 * 60;

  late int remainingSeconds;
  bool isRunning = false;
  bool isFocusMode = true;
  bool isRinging = false;

  Timer? timer;

  final AudioPlayer _audioPlayer = AudioPlayer();
  final FlutterTts _flutterTts = FlutterTts();

  final focusQuotes = [
    "You can do this all day!",
    "Stay focused. Stay sharp.",
    "One task at a time.",
    "Deep focus brings big results.",
    "Your future self will thank you.",
  ];

  final breakQuotes = [
    "Relax. You earned it.",
    "Take a deep breath.",
    "Recharge your energy.",
    "Rest is part of success.",
    "Slow down and reset.",
  ];

  String currentQuote = "";

  @override
  void initState() {
    super.initState();

    focusTime = widget.focusMinutes * 60;
    remainingSeconds = focusTime;
    currentQuote = getRandomQuote();

    _initTts();
  }

  // --- INIT TTS ---
  void _initTts() async {
    await _flutterTts.setLanguage("en-US");
    await _flutterTts.setSpeechRate(0.5);
    await _flutterTts.setVolume(1.0);
    await _flutterTts.setPitch(1.0);
    await _flutterTts.awaitSpeakCompletion(true);
  }

  String getRandomQuote() {
    final list = isFocusMode ? focusQuotes : breakQuotes;
    return list[Random().nextInt(list.length)];
  }

  // --- TIMER LOGIC ---
  void startTimer() {
    if (timer != null) return;

    setState(() => isRunning = true);

    timer = Timer.periodic(const Duration(seconds: 1), (timer) {
      if (remainingSeconds > 0) {
        setState(() => remainingSeconds--);
      } else {
        _handleTimerComplete();
      }
    });
  }

  void pauseTimer() {
    timer?.cancel();
    timer = null;
    setState(() => isRunning = false);
  }

  void resetTimer() {
    pauseTimer();
    setState(() {
      remainingSeconds = isFocusMode ? focusTime : breakTime;
    });
  }

  // --- ALARM LOGIC ---
  void _handleTimerComplete() {
    pauseTimer();

    setState(() => isRinging = true);

    _playAlarmSequence();
  }

  Future<void> _playAlarmSequence() async {
    String message = isFocusMode ? "Focus time over" : "Break time over";

    try {
      await _flutterTts.speak(message);
    } catch (_) {}

    if (!isRinging) return;

    try {
      await _audioPlayer.stop();
      await _audioPlayer.setReleaseMode(ReleaseMode.loop);
      await _audioPlayer.play(AssetSource('sounds/alarm.mp3'), volume: 1.0);
    } catch (_) {}
  }

  Future<void> stopAlarm() async {
    try {
      await _audioPlayer.stop();
      await _flutterTts.stop();
    } catch (_) {}

    setState(() {
      isRinging = false;
      isFocusMode = !isFocusMode;
      remainingSeconds = isFocusMode ? focusTime : breakTime;
      currentQuote = getRandomQuote();
    });
  }

  // --- UI HELPERS ---
  String formatTime(int seconds) {
    final m = seconds ~/ 60;
    final s = seconds % 60;
    return '${m.toString().padLeft(2, '0')}:${s.toString().padLeft(2, '0')}';
  }

  @override
  void dispose() {
    timer?.cancel();
    _audioPlayer.dispose();
    _flutterTts.stop();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    List<Color> gradientColors;

    if (isRinging) {
      gradientColors = [const Color(0xFF2C3E50), const Color(0xFF4B134F)];
    } else if (isFocusMode) {
      gradientColors = [const Color(0xFFff6a6a), const Color(0xFFff8e53)];
    } else {
      gradientColors = [const Color(0xFF43CEA2), const Color(0xFF185A9D)];
    }

    return Scaffold(
      body: Container(
        decoration: BoxDecoration(
          gradient: LinearGradient(
            colors: gradientColors,
            begin: Alignment.topLeft,
            end: Alignment.bottomRight,
          ),
        ),
        child: SafeArea(
          child: isRinging ? _buildAlarmView() : _buildTimerView(),
        ),
      ),
    );
  }

  // --- TIMER VIEW ---
  Widget _buildTimerView() {
    return Column(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        const SizedBox(height: 30),
        Column(
          children: [
            Text(
              isFocusMode ? "FOCUS TIME" : "BREAK TIME",
              style: const TextStyle(
                color: Colors.white,
                fontSize: 26,
                fontWeight: FontWeight.bold,
              ),
            ),
            const SizedBox(height: 10),
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 20),
              child: Text(
                currentQuote,
                textAlign: TextAlign.center,
                style: const TextStyle(color: Colors.white70),
              ),
            ),
          ],
        ),
        Container(
          width: 260,
          height: 260,
          decoration: BoxDecoration(
            shape: BoxShape.circle,
            color: Colors.white.withOpacity(0.18),
            border: Border.all(color: Colors.white30, width: 4),
          ),
          child: Center(
            child: Text(
              formatTime(remainingSeconds),
              style: const TextStyle(
                fontSize: 60,
                fontWeight: FontWeight.bold,
                color: Colors.white,
              ),
            ),
          ),
        ),
        Padding(
          padding: const EdgeInsets.symmetric(horizontal: 32, vertical: 30),
          child: Row(
            children: [
              Expanded(
                child: ElevatedButton(
                  onPressed: isRunning ? pauseTimer : startTimer,
                  child: Text(isRunning ? "PAUSE" : "START"),
                ),
              ),
              const SizedBox(width: 16),
              IconButton(
                onPressed: resetTimer,
                icon: const Icon(Icons.restart_alt),
                color: Colors.white,
              ),
            ],
          ),
        ),
      ],
    );
  }

  // --- ALARM VIEW ---
  Widget _buildAlarmView() {
    return Center(
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          const Icon(
            Icons.notifications_active,
            size: 100,
            color: Colors.amber,
          ),
          const SizedBox(height: 30),
          Text(
            isFocusMode ? "FOCUS COMPLETE!" : "BREAK OVER!",
            style: const TextStyle(color: Colors.white, fontSize: 32),
          ),
          const SizedBox(height: 50),
          ElevatedButton(onPressed: stopAlarm, child: const Text("STOP ALARM")),
        ],
      ),
    );
  }
}
