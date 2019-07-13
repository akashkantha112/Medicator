import 'dart:ui';

import 'package:flutter/material.dart';
import 'package:page_transition/page_transition.dart';

import 'HomePage.dart';

class SplashScreen extends StatefulWidget {
  @override
  _SplashScreenState createState() => _SplashScreenState();
}

class _SplashScreenState extends State<SplashScreen> {
  final String imageUrl = "assets/splash.jpg";

  void goToNextPage(BuildContext context) {
    Navigator.pushReplacement(
        context,
        PageTransition(
            child: new HomePage(), type: PageTransitionType.downToUp));
  }

  @override
  void initState() {
    super.initState();
    Future.delayed(Duration(seconds: 3)).then((_) {
      goToNextPage(context);
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        decoration: BoxDecoration(
          image:
              DecorationImage(fit: BoxFit.cover, image: AssetImage(imageUrl)),
        ),
        child: BackdropFilter(
          filter: new ImageFilter.blur(sigmaY: 1.5, sigmaX: 1.5),
          child: SafeArea(
            child: Padding(
              padding: EdgeInsets.only(
                  top: MediaQuery.of(context).size.height * .64),
              child: Center(
                child: Text(
                  "Disease Predictor",
                  style: TextStyle(
                      color: Colors.black,
                      decoration: TextDecoration.none,
                      fontSize: 25.0,
                      fontStyle: FontStyle.italic),
                ),
              ),
            ),
          ),
        ),
      ),
    );
  }
}
