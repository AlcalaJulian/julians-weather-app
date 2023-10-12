import 'package:geolocator/geolocator.dart';
import 'package:get/get.dart';
import 'package:julians_weather_app/api/open_weather_api.dart';
import 'package:julians_weather_app/model/weather_model.dart';

class WeatherController extends GetxController {
  final _lat = 0.0.obs;
  double get getLat => _lat.value;
  set getLat(double value) => _lat.value = value;

  final _lon = 0.0.obs;
  double get getLon => _lon.value;
  set getLon(double value) => _lon.value = value;

  final _isLoading = true.obs;
  get loading => _isLoading.value;
  set loading(value) => _isLoading.value = value;

  final _currentIndex = 0.obs;
  get currentIndex => _currentIndex.value;
  set currentIndex(value) => _currentIndex.value = value;

  final weatherData = WeatherData().obs;
  RxInt getIndex() {
    return _currentIndex;
  }

  WeatherData getData() {
    return weatherData.value;
  }

  @override
  void onInit() {
    if (_isLoading.isTrue) {
      getLocation();
    } else {
      getIndex();
    }
    super.onInit();
  }

  getLocation() async {
    bool isServiceEnabled;
    LocationPermission locationPermission;

    isServiceEnabled = await Geolocator.isLocationServiceEnabled();
    if (!isServiceEnabled) {
      return Future.error("Location not enabled");
    }

    locationPermission = await Geolocator.checkPermission();

    if (locationPermission == LocationPermission.deniedForever) {
      return Future.error("Location permission are denied forever");
    } else if (locationPermission == LocationPermission.denied) {
      locationPermission = await Geolocator.requestPermission();
      if (locationPermission == LocationPermission.denied) {
        return Future.error("Location permission is denied");
      }
    }

    return await Geolocator.getCurrentPosition(
            desiredAccuracy: LocationAccuracy.high)
        .then((value) {
      _lat.value = value.latitude;
      _lon.value = value.longitude;
      return GetWeatherAPI()
          .processData(value.latitude, value.longitude)
          .then((value) {
        weatherData.value = value;
        _isLoading.value = false;
      });
    });
  }
}
