import 'package:clima/services/location.dart';
import 'package:clima/services/networking.dart';

const apiKey = 'e25bfe176324ee69f095f5552c92eb46';
const openWeatherMapURL = 'https://api.openweathermap.org/data/2.5/weather';

class WeatherModel {
  //new model that will return the weather data based on a city name provided by the user
  //get url changes to take the city name instead of the lat and lon values
  //assign the return value of the getData method of the NetworkHelper class to a dynamic variable called weatherData
  //return weatherData AFTER it has been set
  Future<dynamic> getCityWeather(String city) async {
    NetworkHelper networkHelper = NetworkHelper('$openWeatherMapURL?q=$city&appid=$apiKey&units=metric');

    var weatherData = await networkHelper.getData();

    return weatherData;
  }

  Future<dynamic> getLocationWeather() async {
    Location location = Location();
    await location.getCurrentLocation();

    //create a new object of the NetworkHelper class and pass it the API url that we want to get data from
    //it expects a String url which we are passing it
    NetworkHelper networkHelper = NetworkHelper('$openWeatherMapURL?lat=${location.latitude}&lon=${location.longitude}&appid=$apiKey&units=metric');

    //tap into the getData method of the NetworkHelper class to assign our dynamic variable, weatherData, the JSON decoded data returned
    var weatherData = await networkHelper.getData();

    return weatherData;
  }

  String getWeatherIcon(int condition) {
    if (condition < 300) {
      return '🌩';
    } else if (condition < 400) {
      return '🌧';
    } else if (condition < 600) {
      return '☔️';
    } else if (condition < 700) {
      return '☃️';
    } else if (condition < 800) {
      return '🌫';
    } else if (condition == 800) {
      return '☀️';
    } else if (condition <= 804) {
      return '☁️';
    } else {
      return '🤷‍';
    }
  }

  String getMessage(int temp) {
    if (temp > 25) {
      return 'It\'s 🍦 time';
    } else if (temp > 20) {
      return 'Time for shorts and 👕';
    } else if (temp < 10) {
      return 'You\'ll need 🧣 and 🧤';
    } else {
      return 'Bring a 🧥 just in case';
    }
  }
}
