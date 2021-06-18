import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';

class MapsHelpers with ChangeNotifier {
  GoogleMapController adminMapController;
  Map<MarkerId, Marker> markers = <MarkerId, Marker>{};
  initMarker(specify, specifyId) async {
    var markerIdVal = specifyId;
    final MarkerId markerId = MarkerId(markerIdVal);
    final Marker marker = Marker(
      markerId: markerId,
      position:
          LatLng(specify['location'].latitude, specify['location'].longitude),
      infoWindow: InfoWindow(title: 'Order', snippet: specify['address']),
    );
    markers[markerId] = marker;
  }

  Future getMarkerData(String collection) async {
    FirebaseFirestore.instance.collection(collection).get().then((myMockDoc) {
      if (myMockDoc.docs.isNotEmpty) {
        for (int i = 0; i < myMockDoc.docs.length; i++) {
          initMarker(myMockDoc.docs[i].data(), myMockDoc.docs[i].id);
          print(myMockDoc.docs[i].data());
        }
      }
    });
  }

  showGoogeMaps(BuildContext context, DocumentSnapshot documentSnapshot) {
    return GoogleMap(
        mapToolbarEnabled: true,
        markers: Set<Marker>.of(markers.values),
        myLocationButtonEnabled: true,
        myLocationEnabled: true,
        mapType: MapType.satellite,
        onMapCreated: (GoogleMapController mapController) {
          adminMapController = mapController;
          notifyListeners();
        },
        initialCameraPosition: CameraPosition(
            target: LatLng(documentSnapshot.data()['location'].latitude,
                documentSnapshot.data()['location'].longitude),
            zoom: 15.0));
  }
}
