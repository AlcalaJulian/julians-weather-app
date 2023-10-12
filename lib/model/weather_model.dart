import 'package:julians_weather_app/model/current_weather_model.dart';
import 'package:julians_weather_app/model/daily_weather_model.dart';
import 'package:julians_weather_app/model/hourly_weather_model.dart';

class WeatherData {
  final WeatherDataCurrent? current;
  final WeatherDataHourly? hourly;
  final WeatherDataDaily? daily;

  WeatherData([this.current, this.hourly, this.daily]);

  WeatherDataCurrent getCurrentWeather() => current!;
  WeatherDataHourly getHourlyWeather() => hourly!;
  WeatherDataDaily getDailyWeather() => daily!;
}
