import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:wasalny/Features/welcome/presentation/views/welcome.dart';
import 'Features/Onboarding/presentation/views/OnboardingScreen.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      theme: ThemeData(
        fontFamily: 'Cairo', // Set Cairo as the default font
      ),
      home: FutureBuilder<bool>(
        future: AppPreferences.isFirstLaunch(),
        builder: (context, snapshot) {
          if (snapshot.connectionState == ConnectionState.waiting) {
            // Show a loading indicator while checking
            return const Scaffold(
              body: Center(
                child: CircularProgressIndicator(),
              ),
            );
          } else {
            // If it's the first launch, show OnboardingScreen
            if (snapshot.data == true) {
              return OnboardingScreen();
            } else {
              return WelcomeScreen();
            }
          }
        },
      ),
    );
  }
}

class AppPreferences {
  static const String _keyIsFirstLaunch = 'is_first_launch';

  // Check if it's the first launch
  static Future<bool> isFirstLaunch() async {
    final prefs = await SharedPreferences.getInstance();
    return prefs.getBool(_keyIsFirstLaunch) ?? true;
  }

  // Set the first launch flag to false
  static Future<void> setFirstLaunchCompleted() async {
    final prefs = await SharedPreferences.getInstance();
    await prefs.setBool(_keyIsFirstLaunch, false);
  }
}
