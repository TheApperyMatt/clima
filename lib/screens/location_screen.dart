import 'package:clima/screens/city_screen.dart';
import 'package:flutter/material.dart';
import 'package:clima/utilities/constants.dart';
import 'package:clima/services/weather.dart';

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
  WeatherModel weather = WeatherModel();

  int temperature;
  String weatherIcon;
  String cityName;
  String weatherMessage;

  @override
  void initState() {
    super.initState();

    updateUI(widget.locationWeather);
  }

  //we assign the double temp variable the value of the temperature from the dynamic weatherData variable
  //this is a double at this stage and we want it to be an int
  //we then assign the value of temp converted to an int, to our temperature property
  //we get the condition of the weather and assign it to a variable called condition
  //we get the weatherIcon by calling the getWeatherIcon method of the WeatherModel class
  //we get the weatherMessage by calling the getMessage method of the WeatherModel class
  //we wrap these property updates inside a setState method so they will automatically update when the class is initialised
  void updateUI(dynamic weatherData) {
    setState(() {
      if (weatherData == null) {
        temperature = 0;
        weatherIcon = 'Error';
        weatherMessage = 'Unable to retrieve weather data';
        cityName = '';
        return;
      }

      double temp = weatherData['main']['temp'];
      temperature = temp.toInt();
      var condition = weatherData['weather'][0]['id'];
      weatherIcon = weather.getWeatherIcon(condition);
      cityName = weatherData['name'];
      weatherMessage = weather.getMessage(temperature);
    });
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
                    //set our onPressed method to asynchronous
                    //assign the return value from the getLocationWeather method of the WeatherModel class to a dynamic variable, weatherData
                    //call our updateUI method once the dynamic variable has been set
                    onPressed: () async {
                      var weatherData = await weather.getLocationWeather();
                      updateUI(weatherData);
                    },
                    child: Icon(
                      Icons.near_me,
                      size: 50.0,
                    ),
                  ),
                  FlatButton(
                    onPressed: () async {
                      //the push method of the Navigator object pushes the current context onto the new screen
                      //it expects the current context and the destination route
                      //we give it a new object of the MaterialPageRoute class which expects a call back for the builder property
                      //we pass it a call back with the current context and return a new object of the destination class
                      //the push method can return a Future<T>, so we assign the return to a dynamic variable, typedName
                      //we make our onPressed method asynchronous so we can wait for our typedNamed variable to be set before using it
                      //the return is coming from the pop method in the CityScreen class
                      var typedName = await Navigator.push(
                        context,
                        MaterialPageRoute(
                          builder: (context) {
                            return CityScreen();
                          },
                        ),
                      );
                      //check if the city name provided by the user is null
                      //if not, assign a dynamic variable the return value of the getCityWeather asynchronous method of the WeatherModel class
                      //call our updateUI method and pass in our weatherData once it is assigned the return value
                      if (typedName != null) {
                        var weatherData = await weather.getCityWeather(typedName);
                        updateUI(weatherData);
                      }
                    },
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
                      //updated using our temperature property that is set as class is initialised
                      '$temperature°',
                      style: kTempTextStyle,
                    ),
                    Text(
                      //updated using our weatherIcon property that is set as class is initialised
                      weatherIcon,
                      style: kConditionTextStyle,
                    ),
                  ],
                ),
              ),
              Padding(
                padding: EdgeInsets.only(right: 15.0),
                child: Text(
                  //updated using string interpolation with our weatherMessage and cityName properties
                  //properties are set when the class is initialised
                  '$weatherMessage in $cityName!',
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
