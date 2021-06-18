import 'package:eva_icons_flutter/eva_icons_flutter.dart';
import 'package:flutter/material.dart';
import 'package:page_transition/page_transition.dart';
import 'package:pizzato/Customer/Views/Mycart.dart';

class Footers extends ChangeNotifier {
  Widget floatingActionButton(BuildContext context) {
    return FloatingActionButton(
      backgroundColor: Colors.lightGreenAccent,
      onPressed: () {
        Navigator.pushReplacement(
            context,
            PageTransition(
                child: MyCart(), type: PageTransitionType.rightToLeftWithFade));
      },
      child: Icon(EvaIcons.shoppingBag,color: Colors.black),
    );
  }
}
