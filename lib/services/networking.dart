import 'package:http/http.dart' as http;
import 'dart:convert';

class NetworkHelper {
  //constructor method sets the value of the final String property, url
  //get data method is of Future type because we will use the await keyword whenever we call it
  //we use the http package to send a get request to the url that is set by the constructor method
  //we assign the return of the get request to a Response property, called response
  //we check the statusCode of the response
  //if the response is ok, we assign the body property of the response object to a String variable, called data
  //we then use the convert package to jsonEncode the data variable and return it
  NetworkHelper(this.url);

  final String url;

  Future getData() async {
    http.Response response = await http.get(url);

    if (response.statusCode == 200) {
      String data = response.body;

      return jsonDecode(data);
    } else {
      print(response.statusCode);
    }
  }
}
