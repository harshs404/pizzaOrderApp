import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:eva_icons_flutter/eva_icons_flutter.dart';
import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:pizzato/Admin/Services/DelieryOptions.dart';
import 'package:pizzato/Admin/Services/MapsHelpers.dart';
import 'package:provider/provider.dart';

class AdminDetailsHelper with ChangeNotifier {
  detailSheet(BuildContext context, DocumentSnapshot documentSnapshot) {
    Provider.of<MapsHelpers>(context, listen: false)
        .getMarkerData('adminCollections');
    return showModalBottomSheet(
        isScrollControlled: true,
        context: context,
        builder: (context) {
          return Container(
            height: MediaQuery.of(context).size.height * 0.95,
            width: MediaQuery.of(context).size.width,
            child: Column(
              mainAxisAlignment: MainAxisAlignment.start,
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 150.0),
                  child: Divider(
                    thickness: 4.0,
                    color: Colors.white,
                  ),
                ),
                Container(
                  width: 400.0,
                  child: Padding(
                    padding: const EdgeInsets.only(top: 8.0),
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                      children: [
                        Row(
                          children: [
                            Icon(EvaIcons.person, color: Colors.red),
                            Text('${documentSnapshot.data()['username']}',
                                style: TextStyle(
                                    color: Colors.white,
                                    fontSize: 16.0,
                                    fontWeight: FontWeight.bold)),
                          ],
                        ),
                        Row(
                          children: [
                            Icon(FontAwesomeIcons.mapPin, color: Colors.red),
                            Container(
                              constraints: BoxConstraints(maxWidth: 360.0),
                              child: Text(
                                  '${documentSnapshot.data()['address']}',
                                  style: TextStyle(
                                      color: Colors.white,
                                      fontSize: 16.0,
                                      fontWeight: FontWeight.bold)),
                            ),
                          ],
                        ),
                      ],
                    ),
                  ),
                ),
                Padding(
                  padding: const EdgeInsets.all(12.0),
                  child: Container(
                    decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(25.0)),
                    height: 350.0,
                    width: 400.0,
                    child: Provider.of<MapsHelpers>(context, listen: false)
                        .showGoogeMaps(context, documentSnapshot),
                  ),
                ),
                Padding(
                  padding: const EdgeInsets.only(top: 0.0),
                  child: Container(
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                      children: [
                        Row(
                          children: [
                            Icon(FontAwesomeIcons.clock,
                                color: Colors.lightGreenAccent),
                            Text(' ${documentSnapshot.data()['time']}',
                                style: TextStyle(
                                    color: Colors.white,
                                    fontSize: 16.0,
                                    fontWeight: FontWeight.bold)),
                          ],
                        ),
                        Row(
                          children: [
                            Icon(FontAwesomeIcons.rupeeSign,
                                color: Colors.lightBlueAccent),
                            Text('Price : ${documentSnapshot.data()['price']}',
                                style: TextStyle(
                                    color: Colors.white,
                                    fontSize: 16.0,
                                    fontWeight: FontWeight.bold)),
                          ],
                        ),
                      ],
                    ),
                  ),
                ),
                Padding(
                  padding: const EdgeInsets.only(top: 12.0),
                  child: Container(
                    decoration: BoxDecoration(
                        border: Border.all(color: Colors.white),
                        borderRadius: BorderRadius.circular(10.0)),
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      crossAxisAlignment: CrossAxisAlignment.center,
                      children: [
                        Row(
                          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                          children: [
                            CircleAvatar(
                              radius: 50.0,
                              backgroundColor: Colors.transparent,
                              backgroundImage: NetworkImage(
                                  documentSnapshot.data()['image']),
                            ),
                            Column(
                              children: [
                                Text(
                                    'Pizza : ${documentSnapshot.data()['pizza']}',
                                    style: TextStyle(
                                        color: Colors.white,
                                        fontSize: 19.0,
                                        fontWeight: FontWeight.bold)),
                                Container(
                                  width: 200.0,
                                  child: Row(
                                    mainAxisAlignment:
                                        MainAxisAlignment.spaceEvenly,
                                    children: [
                                      Text(
                                          'Cheese x ${documentSnapshot.data()['cheese']}',
                                          style: TextStyle(
                                              color: Colors.white,
                                              fontSize: 12.0,
                                              fontWeight: FontWeight.bold)),
                                      Text(
                                          'Onion x ${documentSnapshot.data()['onion']}',
                                          style: TextStyle(
                                              color: Colors.white,
                                              fontSize: 12.0,
                                              fontWeight: FontWeight.bold)),
                                      Text(
                                          'Beacon x ${documentSnapshot.data()['beacon']}',
                                          style: TextStyle(
                                              color: Colors.white,
                                              fontSize: 12.0,
                                              fontWeight: FontWeight.bold)),
                                    ],
                                  ),
                                ),
                              ],
                            ),
                            Padding(
                              padding: const EdgeInsets.only(left: 10.0),
                              child: CircleAvatar(
                                backgroundColor: Colors.purple,
                                child: Text(documentSnapshot.data()['size'],
                                    style: TextStyle(
                                        color: Colors.white,
                                        fontSize: 20.0,
                                        fontWeight: FontWeight.bold)),
                              ),
                            )
                          ],
                        ),
                      ],
                    ),
                  ),
                ),
                Padding(
                  padding: const EdgeInsets.only(top: 16.0),
                  child: Container(
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                      children: [
                        FlatButton.icon(
                            color: Colors.red,
                            onPressed: () {
                              Provider.of<DeliveryOptions>(context,
                                      listen: false)
                                  .manageOrders(context, documentSnapshot,
                                      'cancelledOrders', 'Delivery Skipped');
                            },
                            icon: Icon(FontAwesomeIcons.solidEye,
                                color: Colors.white),
                            label: Text('Skip',
                                style: TextStyle(
                                    color: Colors.white,
                                    fontSize: 18.0,
                                    fontWeight: FontWeight.bold))),
                        FlatButton.icon(
                            color: Colors.lightBlueAccent,
                            onPressed: () {
                              Provider.of<DeliveryOptions>(context,
                                      listen: false)
                                  .manageOrders(context, documentSnapshot,
                                      'deliveredOrders', 'Delivery Accepted');
                            },
                            icon: Icon(FontAwesomeIcons.delicious,
                                color: Colors.white),
                            label: Text('Deliver',
                                style: TextStyle(
                                    color: Colors.white,
                                    fontSize: 18.0,
                                    fontWeight: FontWeight.bold))),
                      ],
                    ),
                  ),
                ),
                Padding(
                  padding: const EdgeInsets.only(top: 20.0),
                  child: FlatButton.icon(
                      color: Colors.orangeAccent,
                      onPressed: () {},
                      icon: Icon(FontAwesomeIcons.phone, color: Colors.white),
                      label: Text('Contact Owner',
                          style: TextStyle(
                              color: Colors.white,
                              fontSize: 18.0,
                              fontWeight: FontWeight.bold))),
                ),
              ],
            ),
            decoration: BoxDecoration(
              color: Color(0xFF200B4B),
              borderRadius: BorderRadius.circular(25.0),
            ),
          );
        });
  }
}
