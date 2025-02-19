import 'package:fitness4all/common/color_extensions.dart';
import 'package:fitness4all/screen/login/on_boarding_screen.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

class SplashScreen extends StatefulWidget {
  const SplashScreen({super.key});

  @override
  State<SplashScreen> createState() => _SplashScreenState();
}

class _SplashScreenState extends State<SplashScreen> {
  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    SystemChrome.setEnabledSystemUIMode(SystemUiMode.leanBack);
    loadAppScreen();
  }
  void loadAppScreen() async {
    await Future.delayed(const Duration(seconds: 3));
    loadOnBoardingScreen();
  }

  void loadOnBoardingScreen(){
    context.push(const OnBoardingScreen());
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: Image.asset(
          "assets/img/app_logo.jpg",
          width: context.width * 0.65,

        ),
      ),
    );
  }
}
