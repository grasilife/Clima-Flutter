import 'package:flutter/material.dart';
import 'package:clima/utilities/geolocator.dart';
import 'package:clima/services/networking.dart';

class LoadingScreen extends StatefulWidget {
  @override
  _LoadingScreenState createState() => _LoadingScreenState();
}

class _LoadingScreenState extends State<LoadingScreen> {
  double latitude;
  double longitude;
  @override
  void initState() {
    super.initState();
    getLocation();
  }

  void getLocation() async {
    Location location = Location();
    await location.getCurrentLoacation();
    latitude = location.latitude;
    longitude = location.longitude;
    getLocationData();
  }

  void getLocationData() async {
    NetworkHelper networkHelper = NetworkHelper(
        'https://api.openweathermap.org/data/2.5/weather?lat=$latitude&lon=$longitude&appid=$kOpenweathermapApiKey');
    var weatherData = await networkHelper.getData();
    double temperature = weatherData['main']['temp'];
    int condition = weatherData['weather'][0]['id'];
    String city = weatherData['name'];
    print(temperature);
    print(condition);
    print(city);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: RaisedButton(
          onPressed: () {
            //Get the current location
          },
          child: Text('Get Location'),
        ),
      ),
    );
  }
}
