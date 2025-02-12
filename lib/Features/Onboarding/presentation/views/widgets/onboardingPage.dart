import 'package:flutter/material.dart';

class OnboardingPage extends StatelessWidget {
  final String title;
  final String content;
  final String image;

  OnboardingPage({
    required this.title,
    required this.content,
    required this.image,
  });

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(20.0),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Image.asset(
            image,
            height: 244, // Adjust the height as needed
            width: 255, // Adjust the width as needed
          ),
          const SizedBox(height: 20),
          Text(
            textAlign: TextAlign.center,
            title,
            style: const TextStyle(fontSize: 24, fontWeight: FontWeight.w500),
          ),
          const SizedBox(height: 20),
          Text(
            textAlign: TextAlign.center,
            content,
            style: const TextStyle(fontSize: 18, color: Colors.grey),
          ),
        ],
      ),
    );
  }
}
