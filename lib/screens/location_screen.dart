import 'package:flutter/material.dart';
import 'package:clima/utilities/constants.dart';

//create a constructor method that will set our final dynamic locationWeather property when the class is instantiated
class LocationScreen extends StatefulWidget {
  LocationScreen({this.locationWeather});

  final locationWeather;

  @override
  _LocationScreenState createState() => _LocationScreenState();
}

//call the initState method which allows us to capture the state of the Super class as it gets initialised
//we can use our widget keyword to tap into the properties and methods of the super class at this point
//create our 3 properties, int temperature, int condition and String cityName
//we then create our updateUI method which assigns values from our dynamic locationWeather variable to our properties
//this method gets called in the initState method and is passed the locationWeather using the widget keyword
class _LocationScreenState extends State<LocationScreen> {
  @override
  void initState() {
    super.initState();

    updateUI(widget.locationWeather);
  }

  int temperature;
  int condition;
  String cityName;

  //we assign the double temp variable the value of the temperature from the dynamic weatherData variable
  //this is a double at this stage and we want it to be an int
  //we then assign the value of temp converted to an int, to our temperature property
  void updateUI(dynamic weatherData) {
    double temp = weatherData['main']['temp'];
    temperature = temp.toInt();
    condition = weatherData['weather'][0]['id'];
    cityName = weatherData['name'];
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        decoration: BoxDecoration(
          image: DecorationImage(
            image: AssetImage('images/location_background.jpg'),
            fit: BoxFit.cover,
            colorFilter: ColorFilter.mode(Colors.white.withOpacity(0.8), BlendMode.dstATop),
          ),
        ),
        constraints: BoxConstraints.expand(),
        child: SafeArea(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            crossAxisAlignment: CrossAxisAlignment.stretch,
            children: <Widget>[
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: <Widget>[
                  FlatButton(
                    onPressed: () {},
                    child: Icon(
                      Icons.near_me,
                      size: 50.0,
                    ),
                  ),
                  FlatButton(
                    onPressed: () {},
                    child: Icon(
                      Icons.location_city,
                      size: 50.0,
                    ),
                  ),
                ],
              ),
              Padding(
                padding: EdgeInsets.only(left: 15.0),
                child: Row(
                  children: <Widget>[
                    Text(
                      '$temperature°',
                      style: kTempTextStyle,
                    ),
                    Text(
                      '☀️',
                      style: kConditionTextStyle,
                    ),
                  ],
                ),
              ),
              Padding(
                padding: EdgeInsets.only(right: 15.0),
                child: Text(
                  "It's 🍦 time in San Francisco!",
                  textAlign: TextAlign.right,
                  style: kMessageTextStyle,
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
