import 'package:flutter/material.dart';
import 'package:clima/services/location.dart';

class LoadingScreen extends StatefulWidget {
  @override
  _LoadingScreenState createState() => _LoadingScreenState();
}

class _LoadingScreenState extends State<LoadingScreen> {
  @override
  void initState() {
    super.initState();
    getLocation();
  }

  void getLocation() async {
    Location location = Location();
    await location.getCurrentLocation();
    print(location.latitude);
    print(location.longitude);
  }

  @override
  Widget build(BuildContext context) {
//    String myMargin = 'abc';
//    double myStringAsDouble;
//
//    try {
//      myStringAsDouble = double.parse(myMargin);
//    } catch (e) {
//      print(e);
//      myStringAsDouble = 30.0;
//    }
//
//    return Scaffold(
//      body: Container(
//        color: Colors.red,
//        margin: EdgeInsets.all(myStringAsDouble),
//      ),
//    );
    return Scaffold(
      body: Center(
        child: RaisedButton(
          onPressed: () {
            getLocation();
          },
          child: Text('Get Location'),
        ),
      ),
    );
  }
}
