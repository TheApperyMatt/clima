import 'package:flutter/material.dart';
import 'package:clima/services/location.dart';
import 'package:clima/services/networking.dart';

const apiKey = 'e25bfe176324ee69f095f5552c92eb46';

class LoadingScreen extends StatefulWidget {
  @override
  _LoadingScreenState createState() => _LoadingScreenState();
}

class _LoadingScreenState extends State<LoadingScreen> {
  double latitude;
  double longitude;

  //initState method fires once as soon as the app is run, this takes place before the build method
  //make a call to our asynchronous getLocation method
  @override
  void initState() {
    super.initState();
    getLocationData();
  }

  //asynchronous method that will get the location of the user's device
  //after getting the latitude and longitude of the user's device, we create an object of the NetworkHelper class
  //it expects a String variable which is the url
  //we then assign the return of the getData method of the NetworkHelper class, which is JSON data, to a variable called weatherData
  //we use the var keyword because the return type is dynamic and cannot be explicitly set to any particular type
  void getLocationData() async {
    Location location = Location();
    await location.getCurrentLocation();

    latitude = location.latitude;
    longitude = location.longitude;

    NetworkHelper networkHelper = NetworkHelper('https://api.openweathermap.org/data/2.5/weather?lat=$latitude&lon=$longitude&appid=$apiKey');

    var weatherData = await networkHelper.getData();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold();
  }
}
