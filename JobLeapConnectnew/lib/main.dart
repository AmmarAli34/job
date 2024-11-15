import 'package:flutter/material.dart';
import 'package:jobleapconnectnew/pages/onboarding/on_boarding_screen.dart';
import 'package:jobleapconnectnew/pages/splash/splash_page.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'JobLeap Connect ',
      theme: ThemeData(),
      home: SplashPage(
        child: OnBoardingScreen(),
      ),
    );
  }
}
