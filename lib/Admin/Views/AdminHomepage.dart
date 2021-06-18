import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:eva_icons_flutter/eva_icons_flutter.dart';
import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:page_transition/page_transition.dart';
import 'package:pizzato/Admin/Services/DelieryOptions.dart';
import 'package:pizzato/Admin/Views/AdminDetails.dart';
import 'package:pizzato/Decider.dart';
import 'package:provider/provider.dart';
import 'package:shared_preferences/shared_preferences.dart';

class AdminHomepage extends StatefulWidget {
  @override
  _AdminHomepageState createState() => _AdminHomepageState();
}

class _AdminHomepageState extends State<AdminHomepage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      floatingActionButtonLocation: FloatingActionButtonLocation.centerFloat,
      floatingActionButton: floatinActionButton(context),
      drawer: Drawer(),
      body: RefreshIndicator(
        backgroundColor: Colors.white,
        color: Colors.lightBlueAccent,
        onRefresh: () async {
          print('Meow');
        },
        child: Stack(
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
                    Color(0xFF200B4B),
                    Color(0xFF201F22),
                    Color(0xFF1A1031),
                    Color(0xFF19181F),
                  ])),
            ),
            appBar(context),
            timeChips(context),
            orderData(context)
          ],
        ),
      ),
    );
  }
}

Widget appBar(BuildContext context) {
  return AppBar(
    backgroundColor: Colors.transparent,
    centerTitle: true,
    actions: [
      IconButton(
          icon: Icon(EvaIcons.logOutOutline),
          onPressed: () async {
            SharedPreferences sharedPreferences =
                await SharedPreferences.getInstance();
            sharedPreferences.remove('uid');
            Navigator.pushReplacement(
                context,
                PageTransition(
                    child: Decider(), type: PageTransitionType.leftToRight));
          }),
    ],
    title: Text(
      'Orders',
      style: TextStyle(
          color: Colors.white, fontSize: 28.0, fontWeight: FontWeight.bold),
    ),
  );
}

Widget orderData(BuildContext context) {
  return Positioned(
    top: 200,
    child: SizedBox(
      height: 800.0,
      width: 400.0,
      child: StreamBuilder<QuerySnapshot>(
        stream: FirebaseFirestore.instance
            .collection('adminCollections')
            .snapshots(),
        builder: (context, snapshot) {
          if (snapshot.connectionState == ConnectionState.waiting) {
            return Center(
              child: CircularProgressIndicator(),
            );
          } else {
            return new ListView(
                children:
                    snapshot.data.docs.map((DocumentSnapshot documentSnapshot) {
              return Padding(
                padding: const EdgeInsets.only(top: 8.0),
                child: Container(
                  color: Colors.deepPurple,
                  child: ListTile(
                    onTap: () {
                      Provider.of<AdminDetailsHelper>(context, listen: false)
                          .detailSheet(context, documentSnapshot);
                    },
                    trailing: IconButton(
                      onPressed: () {},
                      icon: Icon(FontAwesomeIcons.magnet,
                          color: Colors.lightBlueAccent),
                    ),
                    leading: CircleAvatar(
                      backgroundImage:
                          NetworkImage(documentSnapshot.data()['image']),
                    ),
                    title: Text(documentSnapshot.data()['pizza'],
                        style: TextStyle(
                            color: Colors.white,
                            fontSize: 20.0,
                            fontWeight: FontWeight.bold)),
                    subtitle: Text(documentSnapshot.data()['address'],
                        style: TextStyle(
                            color: Colors.white,
                            fontSize: 14.0,
                            fontWeight: FontWeight.bold)),
                  ),
                ),
              );
            }).toList());
          }
        },
      ),
    ),
  );
}

Widget floatinActionButton(BuildContext context) {
  return Row(
    mainAxisAlignment: MainAxisAlignment.spaceEvenly,
    children: [
      FloatingActionButton(
          backgroundColor: Colors.redAccent,
          child: Icon(Icons.cancel_outlined, color: Colors.white),
          onPressed: () {
            Provider.of<DeliveryOptions>(context, listen: false)
                .showOrders(context, 'cancelledOrders');
          }),
      FloatingActionButton(
          backgroundColor: Colors.greenAccent,
          child: Icon(FontAwesomeIcons.check, color: Colors.white),
          onPressed: () {
            Provider.of<DeliveryOptions>(context, listen: false)
                .showOrders(context, 'deliveredOrders');
          }),
    ],
  );
}

Widget timeChips(BuildContext context) {
  return Positioned(
    top: 120.0,
    child: Container(
      width: 400,
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
        children: [
          ActionChip(
              shadowColor: Colors.purpleAccent,
              backgroundColor: Colors.purple,
              label: Text('Today',
                  style: TextStyle(
                      color: Colors.white,
                      fontWeight: FontWeight.bold,
                      fontSize: 16.0)),
              onPressed: () {}),
          ActionChip(
              shadowColor: Colors.purpleAccent,
              backgroundColor: Colors.purple,
              label: Text('This Week',
                  style: TextStyle(
                      color: Colors.white,
                      fontWeight: FontWeight.bold,
                      fontSize: 16.0)),
              onPressed: () {}),
          ActionChip(
              shadowColor: Colors.purpleAccent,
              backgroundColor: Colors.purple,
              label: Text('This Month',
                  style: TextStyle(
                      color: Colors.white,
                      fontWeight: FontWeight.bold,
                      fontSize: 16.0)),
              onPressed: () {}),
        ],
      ),
    ),
  );
}
