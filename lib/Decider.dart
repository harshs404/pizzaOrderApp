import 'package:flutter/material.dart';
import 'package:page_transition/page_transition.dart';
import 'package:pizzato/Admin/Views/AdminLogin.dart';
import 'package:pizzato/Customer/Views/Login.dart';

class Decider extends StatelessWidget {
 // FilterChip()
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Stack(
        children: [
          Container(
            decoration: BoxDecoration(
                gradient: LinearGradient(
                    begin: Alignment.topCenter,
                    end: Alignment.bottomCenter,
                    stops: [
                  0.2,
                  0.45,
                  0.6,
                  0.9
                ],
                    colors: [
                  Color(0xFFFF6600),
                  Color(0xFFFCF82F),
                  Color(0xFFD3CF00),
                  Color(0xFFFF6600),
                ])),
          ),
          Positioned(
            top: 50,
            child: Container(
                height: MediaQuery.of(context).size.height,
                width: MediaQuery.of(context).size.width,
                child: Image.asset('images/deciderbg.png')),
          ),
          Positioned(
              top: 120.0,
              left: 15.0,
              child: Container(
                height: 200.0,
                width: 400.0,
                child: RichText(
                  text: TextSpan(
                      text: 'Select ',
                      style: TextStyle(
                          fontFamily: 'Monteserrat',
                          color: Colors.white,
                          fontWeight: FontWeight.bold,
                          fontSize: 46.0),
                      children: <TextSpan>[
                        TextSpan(
                            text: 'Your ',
                            style: TextStyle(
                                color: Colors.white,
                                fontWeight: FontWeight.bold,
                                fontSize: 46.0)),
                        TextSpan(
                            text: 'Side',
                            style: TextStyle(
                                color: Colors.white,
                                fontWeight: FontWeight.bold,
                                fontSize: 46.0))
                      ]),
                ),
              )),
          Positioned(
              top: 220.0,
              child: Container(
                width: 400.0,
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                  children: [
                    MaterialButton(
                        color: Colors.redAccent,
                        child: Text('Customer',
                            style: TextStyle(
                                color: Colors.white,
                                fontSize: 20.0,
                                fontWeight: FontWeight.bold)),
                        onPressed: () {
                          Navigator.pushReplacement(
                              context,
                              PageTransition(
                                  child: Login(),
                                  type: PageTransitionType.bottomToTop));
                        }),
                    MaterialButton(
                        color: Colors.redAccent,
                        child: Text('Employee',
                            style: TextStyle(
                                color: Colors.white,
                                fontSize: 20.0,
                                fontWeight: FontWeight.bold)),
                        onPressed: () {
                          Navigator.pushReplacement(
                              context,
                              PageTransition(
                                  child: AdminLogin(),
                                  type: PageTransitionType.topToBottom));
                        })
                  ],
                ),
              )),
          Positioned(
              top: 720.0,
              left: 20.0,
              right: 20.0,
              child: Container(
                width: 400.0,
                constraints: BoxConstraints(maxHeight: 200.0),
                child: Column(
                  children: [
                    Text("By continuing you agree Pizzato's Terms of ",
                        style: TextStyle(
                            color: Colors.grey.shade600, fontSize: 12.0)),
                    Text("Services & Privacy Policy",
                        style: TextStyle(
                            color: Colors.grey.shade600, fontSize: 12.0))
                  ],
                ),
              ))
        ],
      ),
    );
  }
}
