import 'package:flutter/material.dart';
import 'package:pizzato/Customer/Services/ManageMaps.dart';
import 'package:provider/provider.dart';
import 'package:razorpay_flutter/razorpay_flutter.dart';

class PaymentHelper with ChangeNotifier {
  TimeOfDay deliveryTiming = TimeOfDay.now();
  bool showCheckoutButton = false;
  bool get getShowCheckoutButton => showCheckoutButton;

  Future selectTime(BuildContext context) async {
    final selectedTime =
        await showTimePicker(context: context, initialTime: TimeOfDay.now());
    if (selectedTime != null && selectedTime != deliveryTiming) {
      deliveryTiming = selectedTime;
      print(deliveryTiming.format(context));
      notifyListeners();
    }
  }

  showCheckoutButtonMethod() {
    showCheckoutButton = true;
    notifyListeners();
  }

  selectLocation(BuildContext context) {
    return showModalBottomSheet(
        isScrollControlled: true,
        context: context,
        builder: (context) {
          return Container(
            child: Column(
              children: [
                Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 150.0),
                  child: Divider(
                    color: Colors.white,
                    thickness: 4.0,
                  ),
                ),
                Container(
                  height: 50.0,
                  child: Text(
                    'Location : ${Provider.of<GenerateMaps>(context, listen: true).getMainAddress}',
                    style: TextStyle(
                        color: Colors.white,
                        fontSize: 16.0,
                        fontWeight: FontWeight.bold),
                  ),
                ),
                Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: Container(
                    child: Provider.of<GenerateMaps>(context, listen: false)
                        .fetchMaps(),
                    height: MediaQuery.of(context).size.height * 0.65,
                    width: MediaQuery.of(context).size.width,
                  ),
                )
              ],
            ),
            height: MediaQuery.of(context).size.height * 0.80,
            width: MediaQuery.of(context).size.width,
            decoration: BoxDecoration(color: Color(0xFF191531)),
          );
        });
  }

  handlePaymentSucess(
      BuildContext context, PaymentSuccessResponse paymentSuccessResponse) {
    return showResponse(context, paymentSuccessResponse.paymentId);
  }

  handlePaymentError(
      BuildContext context, PaymentFailureResponse paymentFailureResponse) {
    return showResponse(context, paymentFailureResponse.message);
  }

  handleExternalWaller(
      BuildContext context, ExternalWalletResponse externalWalletResponse) {
    return showResponse(context, externalWalletResponse.walletName);
  }

  showResponse(BuildContext context, String response) {
    return showModalBottomSheet(
        context: context,
        builder: (context) {
          return Container(
            height: 100.0,
            width: 400.0,
            child: Text('The reponse is $response', style: TextStyle()),
          );
        });
  }
}
