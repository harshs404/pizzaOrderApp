import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:pizzato/Admin/Services/AdminAuth.dart';
import 'package:pizzato/Admin/Services/DelieryOptions.dart';
import 'package:pizzato/Admin/Services/MapsHelpers.dart';
import 'package:pizzato/Admin/Views/AdminDetails.dart';
import 'package:pizzato/Customer/Helpers/Footer.dart';
import 'package:pizzato/Customer/Helpers/Headers.dart';
import 'package:pizzato/Customer/Helpers/Middle.dart';
import 'package:pizzato/Customer/Providers/Authentication.dart';
import 'package:pizzato/Customer/Providers/Calculations.dart';
import 'package:pizzato/Customer/Providers/Payment.dart';
import 'package:pizzato/Customer/Services/ManageData.dart';
import 'package:pizzato/Customer/Services/ManageMaps.dart';
import 'package:pizzato/Customer/Views/SplashScreen.dart';
import 'package:provider/provider.dart';

// Key points :
// 1.The source code contains all the code that is performed in the videos.
// 2.Add Google-Services.Json File under android/app.
// 3.Add google maps API key from the google cloud console and paste under the androidManifest.xml
// 4.The code stucture is made for beginners,Feel free to modify it accordingly.
// 5.If you find something wrong about the code,Feel free to correct it and notify me.
// 6.The calculations operations may be unsubtle,You can change that.
// 7.Please dont share the code with anyone.
// 8.All the assets used during the project are available in the folder.
// 9.Run 'Flutter pub get' to import all the dependencies.
// 10.Almost 98% of the code is as per the youtube videos and 2% may be more or less
// 11.Lastly, HAVE FUN :)

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp();
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MultiProvider(
      providers: [
        // Use create() instead of value() for creating base model
        ChangeNotifierProvider.value(value: DeliveryOptions()),
        ChangeNotifierProvider.value(value: AdminAuth()),
        ChangeNotifierProvider.value(value: AdminDetailsHelper()),
        ChangeNotifierProvider.value(value: MapsHelpers()),
        ChangeNotifierProvider.value(value: PaymentHelper()),
        ChangeNotifierProvider.value(value: Calculations()),
        ChangeNotifierProvider.value(value: Authentication()),
        ChangeNotifierProvider.value(value: Headers()),
        ChangeNotifierProvider.value(value: MiddleHelpers()),
        ChangeNotifierProvider.value(value: ManageData()),
        ChangeNotifierProvider.value(value: Footers()),
        ChangeNotifierProvider.value(value: GenerateMaps()),
      ],
      child: MaterialApp(
          title: 'Pizzato',
          debugShowCheckedModeBanner: false,
          themeMode: ThemeMode.dark,
          theme: ThemeData(
            canvasColor: Colors.transparent,
            fontFamily: 'Monteserrat',
            primarySwatch: Colors.red,
            primaryColor: Colors.redAccent,
            visualDensity: VisualDensity.adaptivePlatformDensity,
          ),
          home: SplashScreen()),
    );
  }
}
