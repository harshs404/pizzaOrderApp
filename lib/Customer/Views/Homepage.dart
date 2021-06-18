import 'package:flutter/material.dart';
import 'package:pizzato/Customer/Helpers/Footer.dart';
import 'package:pizzato/Customer/Helpers/Headers.dart';
import 'package:pizzato/Customer/Helpers/Middle.dart';
import 'package:pizzato/Customer/Services/ManageMaps.dart';
import 'package:provider/provider.dart';

class HomeScreen extends StatefulWidget {
  @override
  _HomeScreenState createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  @override
  void initState() {
    Provider.of<GenerateMaps>(context, listen: false).getCurrentLocation();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      drawer: Drawer(),
      floatingActionButton: Footers().floatingActionButton(context),
      backgroundColor: Colors.white,
      body: SingleChildScrollView(
        child: Container(
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
          child: Padding(
            padding: const EdgeInsets.only(left: 0.0),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.start,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Headers().appBar(context),
                Headers().headerText(),
                Headers().headerMenu(context),
                MiddleHelpers().textFav(),
                MiddleHelpers().dataFav(context, 'favourite'),
                MiddleHelpers().textBusiness(),
                MiddleHelpers().dataBusiness(context, 'business')
              ],
            ),
          ),
        ),
      ),
    );
  }
}
