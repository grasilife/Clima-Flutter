import 'package:flutter/material.dart';
import 'package:clima/utilities/geolocator.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';

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
    await location.getCurrentLoacation();
    getData(lat: location.latitude, lon: location.longitude);
  }

  void getData({lat: double, lon: double}) async {
    http.Response response = await http.get(Uri.parse(
        'https://api.openweathermap.org/data/2.5/weather?lat=$lat&lon=$lon&appid=$kOpenweathermapApiKey'));
    if (response.statusCode == 200) {
      String data = response.body;
      const JsonDecoder decoder = JsonDecoder();
      final Map<String, dynamic> decoderData = decoder.convert(data);
      double temperature = decoderData['main']['temp'];
      int condition = decoderData['weather'][0]['id'];
      String city = decoderData['name'];

      print(temperature);
      print(condition);
      print(city);
    } else {
      print('天气数据获取失败');
    }
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
