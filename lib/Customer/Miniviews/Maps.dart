import 'package:flutter/material.dart';
import 'package:page_transition/page_transition.dart';
import 'package:pizzato/Customer/Services/ManageMaps.dart';
import 'package:pizzato/Customer/Views/Mycart.dart';
import 'package:provider/provider.dart';

class Maps extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Stack(
        children: [
          Provider.of<GenerateMaps>(context, listen: false).fetchMaps(),
          Positioned(
              top: 720,
              left: 50,
              child: Container(
                color: Colors.white,
                height: 80.0,
                width: 300,
                child: Text(Provider.of<GenerateMaps>(context, listen: true)
                    .getMainAddress),
              )),
          Positioned(
              top: 50.0,
              child: IconButton(
                icon: Icon(Icons.arrow_back_ios_outlined, color: Colors.white),
                onPressed: () {
                  Navigator.pushReplacement(
                      context,
                      PageTransition(
                          child: MyCart(), type: PageTransitionType.fade));
                },
              )),
        ],
      ),
    );
  }
}
