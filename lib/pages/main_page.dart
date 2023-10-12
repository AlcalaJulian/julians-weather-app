import 'package:geocoding/geocoding.dart';
import 'package:get/get.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:julians_weather_app/controller/weather_controller.dart';
import 'package:julians_weather_app/pages/second_page.dart';
import 'package:julians_weather_app/widgets/hourly.dart';
import '../model/current_weather_model.dart';

class MainPage extends StatefulWidget {
  final WeatherDataCurrent weatherDataCurrent;

  const MainPage({Key? key, required this.weatherDataCurrent})
      : super(key: key);

  @override
  State<MainPage> createState() => _MainPageState();
}

class _MainPageState extends State<MainPage> {
  String city = "";

  String getDate() {
    String year = DateFormat("y").format(DateTime.now());
    String day = DateFormat("d").format(DateTime.now());

    String month = DateFormat("MMMM").format(DateTime.now());
    switch (month) {
      case 'January':
        month = 'Enero';
        break;
      case 'February':
        month = 'Febrero';
        break;
      case 'March':
        month = 'Marzo';
        break;
      case 'April':
        month = 'Abril';
        break;
      case 'May':
        month = 'Mayo';
        break;
      case 'June':
        month = 'Junio';
        break;
      case 'July':
        month = 'Julio';
        break;
      case 'August':
        month = 'Agosto';
        break;
      case 'September':
        month = 'Septiembre';
        break;
      case 'October':
        month = 'Octubre';
        break;
      case 'November':
        month = 'Noviembre';
        break;
      case 'December':
        month = 'Diciembre';
        break;
    }
    return '$day de $month de $year';
  }

  final WeatherController weatherController =
      Get.put(WeatherController(), permanent: true);

  @override
  void initState() {
    getAddress(weatherController.getLat, weatherController.getLon);
    super.initState();
  }

  getAddress(lat, lon) async {
    List<Placemark> placemark = await placemarkFromCoordinates(lat, lon);
    Placemark place = placemark[0];
    setState(() {
      city = place.locality!;
    });
  }

  @override
  Widget build(BuildContext context) {
    var weatherDataCurrent = widget.weatherDataCurrent;

    return Center(
      child: SafeArea(
        child: Stack(
          children: [
            Column(
              mainAxisAlignment: MainAxisAlignment.center,
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                Image.asset(
                  "assets/weather/${weatherDataCurrent.current.weather![0].icon}.png",
                  height: 100,
                  width: 100,
                ),
                Container(
                  margin: const EdgeInsets.only(left: 20, right: 20),
                  alignment: Alignment.topCenter,
                  child: Text(
                    city,
                    style: const TextStyle(
                        fontSize: 35, height: 2, color: Colors.white),
                  ),
                ),
                Text("${weatherDataCurrent.current.temp!.toInt()}°",
                    style: const TextStyle(
                      fontWeight: FontWeight.w600,
                      fontSize: 40,
                      color: Colors.white,
                    )),
                Text("${weatherDataCurrent.current.weather![0].description}",
                    style: const TextStyle(
                      fontWeight: FontWeight.w400,
                      fontSize: 20,
                      color: Colors.white,
                    )),
                const SizedBox(height: 10),
                Text("Humedad : ${weatherDataCurrent.current.humidity} %",
                    style: const TextStyle(
                        fontSize: 14,
                        height: 0.8,
                        color: Colors.white,
                        fontWeight: FontWeight.w400)),
                Container(
                  margin:
                      const EdgeInsets.only(left: 20, right: 20, bottom: 10),
                  alignment: Alignment.topCenter,
                  child: Text(
                    getDate(),
                    style: const TextStyle(
                        fontSize: 14, color: Colors.white, height: 1.5),
                  ),
                ),
                Row(mainAxisAlignment: MainAxisAlignment.center, children: [
                  const Text("Sensación Termica :",
                      style: TextStyle(
                          fontSize: 14,
                          height: 0.8,
                          color: Colors.white,
                          fontWeight: FontWeight.w400)),
                  const SizedBox(width: 10),
                  Text("${weatherDataCurrent.current.feelsLike} °C",
                      style: const TextStyle(
                          fontSize: 14,
                          height: 0.8,
                          color: Colors.white,
                          fontWeight: FontWeight.w400)),
                ]),
                Hourly(
                    weatherDataHourly:
                        weatherController.getData().getHourlyWeather()),
              ],
            ),
            IconButton(
              icon: const Icon(
                Icons.list,
                color: Colors.white,
                size: 40,
              ),
              onPressed: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(builder: (context) => SecondPage()),
                );
              },
            )
          ],
        ),
      ),
    );
  }
}
