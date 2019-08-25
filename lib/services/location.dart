import 'package:geolocator/geolocator.dart';

class Location {
  //double properties, latitude and longitude
  double latitude;
  double longitude;

  //Future type method because the await keyword will be used whenever it is called
  //try and get the current location using the Geolocator package
  //assign return of Geolocator request to a Position type property, position
  //set the latitude and longitude properties of our Location class to the latitude and longitude properties of the position object
  //catch any exceptions that might occur
  Future<void> getCurrentLocation() async {
    try {
      Position position = await Geolocator().getCurrentPosition(desiredAccuracy: LocationAccuracy.low);

      latitude = position.latitude;
      longitude = position.longitude;
    } catch (e) {
      print(e);
    }
  }
}
