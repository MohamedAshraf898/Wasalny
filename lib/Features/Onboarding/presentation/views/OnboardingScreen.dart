import 'package:flutter/material.dart';
import 'package:smooth_page_indicator/smooth_page_indicator.dart';
import 'package:wasalny/Features/welcome/presentation/views/Welcome.dart';
import 'package:wasalny/constant.dart';
import 'package:wasalny/main.dart';

import 'widgets/onboardingPage.dart';

class OnboardingScreen extends StatefulWidget {
  @override
  _OnboardingScreenState createState() => _OnboardingScreenState();
}

class _OnboardingScreenState extends State<OnboardingScreen> {
  final PageController _controller = PageController(initialPage: 0);
  int _currentPage = 0;

  final List<Map<String, String>> onboardingPages = [
    {
      'title': 'ليه تستنى كتير وانت تقدر تلاقي مكانك بسهولة؟',
      'content': 'حدد موقفك، اختار كرسيك، وسافر من غير قلق',
      'image': 'assets/images/onboarding1.png',
    },
    {
      'title': ' وقتك مهم... ماتضيعوش في انتظار الميكروباص',
      'content': 'اعرف أماكن العربيات واحجز مكانك بكل سهولة',
      'image': 'assets/images/onboarding2.png',
    },
    {
      'title': 'ودّع البهدلة... وسافر براحة',
      'content': 'اعرف موقفك، تابع العربيات، واحجز كرسيك وانت في بيتك',
      'image': 'assets/images/onboarding3.png',
    },
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Stack(
        children: [
          PageView.builder(
            controller: _controller,
            reverse: true, // Makes scrolling RTL
            itemCount: onboardingPages.length,
            onPageChanged: (int page) {
              setState(() {
                _currentPage = page;
              });
            },
            itemBuilder: (context, index) {
              return OnboardingPage(
                title: onboardingPages[index]['title']!,
                content: onboardingPages[index]['content']!,
                image: onboardingPages[index]['image']!,
              );
            },
          ),
          Positioned(
            bottom: 20.0,
            left: 0,
            right: 0,
            child: Column(
              children: [
                Directionality(
                  textDirection:
                      TextDirection.rtl, // RTL for SmoothPageIndicator
                  child: SmoothPageIndicator(
                    controller: _controller,
                    count: onboardingPages.length,
                    effect: const WormEffect(
                      activeDotColor: Color(0xff08B783),
                      dotColor: Colors.grey,
                    ),
                  ),
                ),
                const SizedBox(height: 20),
                if (_currentPage == onboardingPages.length - 1)
                  ElevatedButton(
                    onPressed: () async {
                      // Mark onboarding as completed
                      await AppPreferences.setFirstLaunchCompleted();

                      // Navigate to the HomeScreen
                      Navigator.pushReplacement(
                        context,
                        MaterialPageRoute(
                            builder: (context) => WelcomeScreen()),
                      );
                    },
                    style: ElevatedButton.styleFrom(
                      backgroundColor: kPrimaryColor,
                      padding: const EdgeInsets.symmetric(
                          vertical: 14, horizontal: 40),
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(8),
                      ),
                    ),
                    child: const Text(
                      'ابدأ الآن',
                      style: TextStyle(color: Colors.white, fontSize: 18),
                    ),
                  ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
