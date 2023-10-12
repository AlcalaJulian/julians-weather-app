import 'package:julians_weather_app/model/weather_model.dart';
import 'package:julians_weather_app/model/current_weather_model.dart';
import 'package:julians_weather_app/model/daily_weather_model.dart';
import 'package:julians_weather_app/model/hourly_weather_model.dart';
import 'package:dio/dio.dart' as dio;
import 'package:get/get.dart';


class GetWeatherAPI {
  WeatherData? weatherData;
  final dio.Dio _dio = Get.put<dio.Dio>(dio.Dio());
  final String apiKey = "626f68557f6dcd272e10a717d721701f"; // reemplazar apikey 
  Future<WeatherData> processData(double lat, double lon) async {
    try {
      final url ="https://api.openweathermap.org/data/2.5/onecall?lat=$lat&lon=$lon&appid=$apiKey&units=metric&exclude=minutely&lang=sp";
      final response = await _dio.get(url);
      final responseData = response.data;

      weatherData = WeatherData(
        WeatherDataCurrent.fromJson(responseData),
        WeatherDataHourly.fromJson(responseData),
        WeatherDataDaily.fromJson(responseData),
      );

      return weatherData!;
    } catch (e) {
      throw Exception('Error al procesar los datos del clima: $e');
    }
  }
}



