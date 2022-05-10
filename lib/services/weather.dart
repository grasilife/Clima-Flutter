import 'package:clima/services/networking.dart';
import 'package:clima/utilities/geolocator.dart';

final String kOpenWeatherMapApiKey = 'b205997d83c1a3dc2c2f33bc31660aa1';
final String openWeatherMapURL = 'https://api.openweathermap.org/data/2.5';

class WeatherModel {
  Future<dynamic> getLocationData() async {
    Location location = Location();
    print(location);
    await location.getCurrentLoacation();
    NetworkHelper networkHelper = NetworkHelper(
        '$openWeatherMapURL/weather?lat=${location.latitude}&lon=${location.longitude}&units=metric&appid=$kOpenWeatherMapApiKey');
    var weatherData = await networkHelper.getData();
    print(weatherData);
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
