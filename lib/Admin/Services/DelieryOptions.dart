import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:pizzato/Admin/Services/MapsHelpers.dart';
import 'package:provider/provider.dart';

class DeliveryOptions with ChangeNotifier {
  showOrders(BuildContext context, String collection) {
    return showModalBottomSheet(
        context: context,
        builder: (context) {
          return Container(
              decoration: BoxDecoration(
                color: Color(0xFF200B4B),
                borderRadius: BorderRadius.circular(25.0),
              ),
              height: MediaQuery.of(context).size.height * 0.50,
              width: MediaQuery.of(context).size.width,
              child: StreamBuilder<QuerySnapshot>(
                stream: FirebaseFirestore.instance
                    .collection(collection)
                    .snapshots(),
                builder: (context, snapshot) {
                  if (snapshot.connectionState == ConnectionState.waiting) {
                    return Center(child: CircularProgressIndicator());
                  } else {
                    return new ListView(
                        children: snapshot.data.docs
                            .map((DocumentSnapshot documentSnapshot) {
                      return Container(
                        decoration: BoxDecoration(
                          color: Color(0xFF200B4B),
                          borderRadius: BorderRadius.circular(25.0),
                        ),
                        child: ListTile(
                          trailing: IconButton(
                            icon: Icon(FontAwesomeIcons.mapPin,
                                color: Colors.green),
                            onPressed: () {
                              showMap(context, documentSnapshot, collection);
                            },
                          ),
                          subtitle: Text(documentSnapshot.data()['name'],
                              style: TextStyle(
                                  color: Colors.white,
                                  fontSize: 16.0,
                                  fontWeight: FontWeight.bold)),
                          title: Text(documentSnapshot.data()['address'],
                              style: TextStyle(
                                  color: Colors.white,
                                  fontSize: 20.0,
                                  fontWeight: FontWeight.bold)),
                          leading: CircleAvatar(
                            backgroundColor: Colors.transparent,
                            backgroundImage:
                                NetworkImage(documentSnapshot.data()['image']),
                          ),
                        ),
                      );
                    }).toList());
                  }
                },
              ));
        });
  }

  // Firestore operations
  Future manageOrders(BuildContext context, DocumentSnapshot documentSnapshot,
      String collection, String message) async {
    await FirebaseFirestore.instance.collection(collection).add({
      'image': documentSnapshot.data()['image'],
      'name': documentSnapshot.data()['username'],
      'pizza': documentSnapshot.data()['pizza'],
      'address': documentSnapshot.data()['address'],
      'location': documentSnapshot.data()['location'],
    }).whenComplete(() {
      showMessage(context, message);
    });
  }

  showMap(BuildContext context, DocumentSnapshot documentSnapshot,
      String collection) {
    Provider.of<MapsHelpers>(context, listen: false)
        .getMarkerData(collection)
        .whenComplete(() {
      return showModalBottomSheet(
          context: context,
          builder: (context) {
            return Container(
              height: MediaQuery.of(context).size.height * 0.50,
              width: MediaQuery.of(context).size.width,
              child: Column(
                children: [
                  Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 150.0),
                    child: Divider(
                      thickness: 4.0,
                      color: Colors.white,
                    ),
                  ),
                  SizedBox(
                    width: 400.0,
                    child: Provider.of<MapsHelpers>(context, listen: false)
                        .showGoogeMaps(context, documentSnapshot),
                    height: 300.0,
                  )
                ],
              ),
            );
          });
    });
  }

  showMessage(BuildContext context, String message) {
    return showModalBottomSheet(
        context: context,
        builder: (context) {
          return Container(
            decoration: BoxDecoration(
              color: Color(0xFF200B4B),
              borderRadius: BorderRadius.circular(25.0),
            ),
            height: 50.0,
            width: 400.0,
            child: Center(
              child: Text(message,
                  style: TextStyle(
                      color: Colors.white,
                      fontWeight: FontWeight.bold,
                      fontSize: 16.0)),
            ),
          );
        });
  }
}
