import 'package:flutter/material.dart';
// ✅ Chemin relatif direct et infaillible depuis la racine de lib :
import 'features/onboarding/screens/onboarding_screen.dart'; 

void main() {
  runApp(const MonLegeApp());
}

class MonLegeApp extends StatelessWidget {
  const MonLegeApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'MonLege',
      debugShowCheckedModeBanner: false,
      theme: ThemeData(
        scaffoldBackgroundColor: const Color(0xFF0B0B0C),
        useMaterial3: true,
      ),
      home: const OnboardingScreen(),
    );
  }
}
