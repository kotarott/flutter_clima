import 'package:flutter_clima/services/location.dart';
import 'package:flutter_clima/services/networking.dart';

const apiKey = 'd5ee0ec07f2c1142c477371f1e152ca8';
const openWeatherMapDomain = 'api.openweathermap.org';

class WeatherModel {
  Future<dynamic> getCityWeather(String cityName) async {
    NetworkHelper networkHelper = NetworkHelper(
      domain: openWeatherMapDomain,
      path: 'data/2.5/weather',
      params: {
        'q': cityName,
        'units': 'metric',
        'appid': apiKey,
      },
    );
    var weatherData = await networkHelper.getData();
    return weatherData;
  }

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
      return '๐ฉ';
    } else if (condition < 400) {
      return '๐ง';
    } else if (condition < 600) {
      return 'โ๏ธ';
    } else if (condition < 700) {
      return 'โ๏ธ';
    } else if (condition < 800) {
      return '๐ซ';
    } else if (condition == 800) {
      return 'โ๏ธ';
    } else if (condition <= 804) {
      return 'โ๏ธ';
    } else {
      return '๐คทโ';
    }
  }

  String getMessage(int temp) {
    if (temp > 25) {
      return 'It\'s ๐ฆ time';
    } else if (temp > 20) {
      return 'Time for shorts and ๐';
    } else if (temp < 10) {
      return 'You\'ll need ๐งฃ and ๐งค';
    } else {
      return 'Bring a ๐งฅ just in case';
    }
  }
}
