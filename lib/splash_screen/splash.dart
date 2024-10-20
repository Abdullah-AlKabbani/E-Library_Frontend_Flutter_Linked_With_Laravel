// This program was made By Abdullah AL-Kabbani in 2023 AD.
// Warehouse Management System

import 'package:easy_splash_screen/easy_splash_screen.dart';
import 'package:flutter/material.dart';
import 'package:e_library/log_in/FirstRoute.dart';
import 'package:e_library/log_in/Otp.dart';
import 'package:e_library/log_in/Forget.dart';
import 'package:animated_text_kit/animated_text_kit.dart';

class Loading1 extends StatelessWidget {
  const Loading1({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return EasySplashScreen(
      logo: Image.asset('assets/Loding 1.gif'),
      logoWidth: 200,
      backgroundColor: const Color(0xFFF8BBD0),
      durationInSeconds: 2,
      navigator:  FirstRoute(context),
      showLoader: true,
      loaderColor: Colors.deepPurple,
      loadingText: const Text("Loading..."),
    );
  }
}

class Splash2 extends StatelessWidget {
  const Splash2(BuildContext context, {Key? key}) : super(key: key);

  @override
  Widget build(context) {
    return Stack(children: <Widget>[
      EasySplashScreen(
        logo: Image.asset('assets/Splash_Screen.gif',alignment: Alignment.topCenter),
        gradientBackground: const LinearGradient(
          begin: Alignment.topLeft,
          end: Alignment.bottomRight,
          colors: [
            Color(0xFF191936),
            Color(0xFF252559),
          ],
        ),
        logoWidth: 240,
        backgroundColor: const Color(0xFF191936),
        durationInSeconds: 6,
        navigator:  FirstRoute(context),
        showLoader: true,
        loaderColor: const Color(0xFFF8BBD0),
        loadingText: const Text(
          "Loading...",
          style: TextStyle(color:  Color(0xFFF8BBD0)),
        ),
      ),
      Container(
        alignment: Alignment.bottomCenter,
        padding: const EdgeInsets.fromLTRB (10, 10, 10, 150),
        child: AnimatedTextKit(
          animatedTexts: [
            TyperAnimatedText('ASRM E-LIBRARY',
                speed: const Duration(milliseconds: 300),
                curve: Curves.easeInCubic,
                textAlign: TextAlign.end,
                textStyle:
                    const TextStyle(
                        fontSize: 25,
                        fontWeight: FontWeight.bold,
                        color: Color(0xFFF8BBD0),
                        fontFamily: 'Jokerman',
                        decoration: TextDecoration.none,
                    )),
          ],
        ),
      ),
    ]);
  }
}
