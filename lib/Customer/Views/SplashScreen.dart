import 'dart:async';
import 'package:flutter/material.dart';
import 'package:lottie/lottie.dart';
import 'package:page_transition/page_transition.dart';
import 'package:pizzato/Decider.dart';
import 'package:pizzato/Customer/Views/Homepage.dart';
import 'package:shared_preferences/shared_preferences.dart';

String userUid, userEmail;

class SplashScreen extends StatefulWidget {
  @override
  _SplashScreenState createState() => _SplashScreenState();
}

class _SplashScreenState extends State<SplashScreen> {
  Future getUid() async {
    SharedPreferences sharedPreferences = await SharedPreferences.getInstance();
    userUid = sharedPreferences.getString('uid');
    userEmail = sharedPreferences.getString('userEmail');
    print(userUid);
  }

  @override
  void initState() {
    getUid().whenComplete(() {
      Timer(
          Duration(seconds: 3),
          () => Navigator.pushReplacement(
              context,
              PageTransition(
                  child: userUid == null ? Decider() : HomeScreen(),
                  type: PageTransitionType.leftToRightWithFade)));
    });

    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      body: Container(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            SizedBox(
              height: 200.0,
              width: 400.0,
              child: Lottie.asset('animation/slice.json'),
            ),
            RichText(
                text: TextSpan(
                    text: 'Piz',
                    style: TextStyle(
                        fontSize: 56.0,
                        fontWeight: FontWeight.bold,
                        color: Colors.black),
                    children: <TextSpan>[
                  TextSpan(
                      text: 'z',
                      style: TextStyle(
                          fontSize: 56.0,
                          fontWeight: FontWeight.bold,
                          color: Colors.red)),
                  TextSpan(
                      text: 'ato',
                      style: TextStyle(
                          color: Colors.black,
                          fontWeight: FontWeight.bold,
                          fontSize: 56.0))
                ]))
          ],
        ),
      ),
    );
  }
}
