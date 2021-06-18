import 'package:flutter/material.dart';
import 'package:pizzato/Customer/Services/ManageData.dart';
import 'package:provider/provider.dart';

class Calculations with ChangeNotifier {
  int cheeseValue = 0, beaconValue = 0, onionValue = 0, cartData = 0;
  String size = '0';
  String get getSize => size;
  bool isSelected = false,
      smallTapped = false,
      mediumTapped = false,
      largeTapped = false,
      selected = false;
  int get getCheeseValue => cheeseValue;
  int get getBeaconValue => beaconValue;
  int get getOnionValue => onionValue;
  int get getCartData => cartData;
  bool get getSelected => selected;

  addCheese() {
    cheeseValue++;
    notifyListeners();
  }

  addBeacon() {
    beaconValue++;
    notifyListeners();
  }

  addOnion() {
    onionValue++;
    notifyListeners();
  }

  minusOnion() {
    onionValue--;
    notifyListeners();
  }

  minusCheese() {
    cheeseValue--;
    notifyListeners();
  }

  minusBeacon() {
    beaconValue--;
    notifyListeners();
  }

  selectSmallSize() {
    smallTapped = true;
    size = 'S';
    notifyListeners();
  }

  selectMediumSize() {
    mediumTapped = true;
    size = 'M';
    notifyListeners();
  }

  selectLargeSize() {
    largeTapped = true;
    size = 'L';
    notifyListeners();
  }

  removeAllData() {
    cheeseValue = 0;
    beaconValue = 0;
    onionValue = 0;
    mediumTapped = false;
    smallTapped = false;
    largeTapped = false;
    notifyListeners();
  }

  addToCart(BuildContext context, dynamic data) async {
    if (smallTapped != false || mediumTapped != false || largeTapped != false) {
      cartData++;
      await Provider.of<ManageData>(context, listen: false)
          .submitData(context, data);
      notifyListeners();
    } else {
      return showModalBottomSheet(
          context: context,
          builder: (context) {
            return Container(
              color: Colors.black45,
              height: 50.0,
              child: Center(
                child:
                    Text('Select Size!', style: TextStyle(color: Colors.white)),
              ),
            );
          });
    }
  }
}
