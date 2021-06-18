import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:geocoder/geocoder.dart' as geoCo;
import 'package:geolocator/geolocator.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';

class GenerateMaps extends ChangeNotifier {
  Position position;
  Position get getPosition => position;
  String finalAddress = 'Searching address...';
  String get getFinalAddress => finalAddress;
  GoogleMapController googleMapController;
  Map<MarkerId, Marker> markers = <MarkerId, Marker>{};
  GeoPoint geoPoint;
  GeoPoint get getGeoPoint => geoPoint;
  String countryName, mainAddress = 'Mock address';
  String get getGetCountryName => countryName;
  String get getMainAddress => mainAddress;

  Future getCurrentLocation() async {
    var postionData = await GeolocatorPlatform.instance.getCurrentPosition();
    final cords =
        geoCo.Coordinates(postionData.latitude, postionData.longitude);
    var address =
        await geoCo.Geocoder.local.findAddressesFromCoordinates(cords);
    String mainAddress = address.first.addressLine;
    finalAddress = mainAddress;
    print(getFinalAddress);
    notifyListeners();
  }

  getMarkers(double lat, double lng) {
    MarkerId markerId = MarkerId(lat.toString() + lng.toString());
    Marker marker = Marker(
      markerId: markerId,
      icon: BitmapDescriptor.defaultMarker,
      position: LatLng(lat, lng),
      infoWindow: InfoWindow(title: getMainAddress, snippet: 'Country name'),
    );
    markers[markerId] = marker;
  }

  fetchMaps() {
    return GoogleMap(
        mapType: MapType.hybrid,
        myLocationEnabled: true,
        mapToolbarEnabled: true,
        onTap: (loc) async {
          final cords = geoCo.Coordinates(loc.latitude, loc.longitude);
          var address =
              await geoCo.Geocoder.local.findAddressesFromCoordinates(cords);
          countryName = address.first.countryName;
          mainAddress = address.first.addressLine;
          geoPoint = GeoPoint(loc.latitude, loc.longitude);
          notifyListeners();
          markers == null
              ? getMarkers(loc.latitude, loc.longitude)
              : markers.clear();
          print(mainAddress);
        },
        markers: Set<Marker>.of(markers.values),
        onMapCreated: (GoogleMapController mapController) {
          googleMapController = mapController;
          notifyListeners();
        },
        initialCameraPosition:
            CameraPosition(target: LatLng(21.000, 21.000), zoom: 18.0));
  }
}
