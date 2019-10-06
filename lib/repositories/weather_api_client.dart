import 'package:dio/dio.dart';
import 'package:flutter_bloc_test/sample/weather_sample/models/models.dart';
import 'package:meta/meta.dart';

class WeatherApiClient {
  static const baseUrl = 'https://www.metaweather.com';
  final Dio dio;

  WeatherApiClient({@required this.dio}) : assert(dio != null);

  Future<int> getLocationId(String city) async {
    final path = '$baseUrl/api/location/search/?query=$city';
    final response = await this.dio.get(path);
    if (response.statusCode != 200) {
      throw Exception('出错：在获得城市locationId时出错');
    }
    return (response.data.first)['woeid'];
  }

  Future<Weather> fetchWeather(int locationId) async {
    final path = '$baseUrl/api/location/$locationId';
    final response = await dio.get(path);

    if (response.statusCode != 200) {
      throw Exception('出错：在获得位置天气时出错');
    }

    return Weather.fromJson(response.data);
  }
}
