import 'package:clima/services/weather.dart';
import 'package:flutter/material.dart';
import 'location_screen.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';

class LoadingScreen extends StatefulWidget {
  @override
  _LoadingScreenState createState() => _LoadingScreenState();
}

class _LoadingScreenState extends State<LoadingScreen> {
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
    //use the push method of the Navigator class to transition to the location_screen.dart
    //when we instantiate the LocationScreen class, we give it our dynamic weatherData as input
    //the constructor method of the LocationScreen class expects a dynamic variable with the placeholder locationWeather
    WeatherModel weatherModel = WeatherModel();

    var weatherData = await weatherModel.getLocationWeather();

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
        child: SpinKitChasingDots(
          color: Colors.white,
          size: 200.0,
        ),
      ),
    );
  }
}
