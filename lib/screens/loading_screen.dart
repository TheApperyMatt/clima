import 'package:flutter/material.dart';
import 'package:clima/services/location.dart';
import 'package:clima/services/networking.dart';
import 'location_screen.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';

const apiKey = 'e25bfe176324ee69f095f5552c92eb46';

class LoadingScreen extends StatefulWidget {
  @override
  _LoadingScreenState createState() => _LoadingScreenState();
}

class _LoadingScreenState extends State<LoadingScreen> {
  double latitude;
  double longitude;

  //initState method fires once as soon as the LoadingScreen class is initialised, this takes place before the build method
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

    //create a new object of the NetworkHelper class and pass it the API url that we want to get data from
    //it expects a String url which we are passing it
    NetworkHelper networkHelper = NetworkHelper(
        'https://api.openweathermap.org/data/2.5/weather?lat=${location.latitude}&lon=${location.longitude}&appid=$apiKey&units=metric');

    //tap into the getData method of the NetworkHelper class to assign our dynamic variable, weatherData, the JSON decoded data returned
    var weatherData = await networkHelper.getData();

    //use the push method of the Navigator class to transition to the location_screen.dart
    //when we instantiate the LocationScreen class, we give it our dynamic weatherData as input
    //the constructor method of the LocationScreen class expects a dynamic variable with the placeholder locationWeather
    Navigator.push(
      context,
      MaterialPageRoute(builder: (context) {
        return LocationScreen(
          locationWeather: weatherData,
        );
      }),
    );
  }

  //we place a SpinKitFoldingCube widget inside a center widget, which is inside a Scaffold widget
  //we change the color and size properties of the SpinKitFoldingCube widget
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: SpinKitFoldingCube(
          color: Colors.white,
          size: 200.0,
        ),
      ),
    );
  }
}

//https://www.youtube.com/watch?v=ZCY1L_27Ph8
