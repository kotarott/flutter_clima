import 'package:flutter_clima/services/location.dart';
import 'package:flutter_clima/services/networking.dart';

const apiKey = 'd5ee0ec07f2c1142c477371f1e152ca8';
const openWeatherMapDomain = 'api.openweathermap.org';

class WeatherModel {
  Future<dynamic> getLocationWeather() async {
    Location location = Location();
    await location.getCurrentLocation();
    double latitude = location.latitude;
    double longitude = location.longitude;
    NetworkHelper networkHelper = NetworkHelper(
      domain: openWeatherMapDomain,
      path: 'data/2.5/weather',
      params: {
        'lat': latitude.toString(),
        'lon': longitude.toString(),
        'units': 'metric',
        'appid': apiKey,
      },
    );
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
