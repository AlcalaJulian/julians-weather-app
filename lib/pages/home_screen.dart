import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:julians_weather_app/controller/weather_controller.dart';
import 'package:julians_weather_app/pages/main_page.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({Key? key}) : super(key: key);

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  // call
  final WeatherController weatherController =
      Get.put(WeatherController(), permanent: true);
  @override
  Widget build(BuildContext context) {
    return Scaffold(

      body: SafeArea(
        child: Obx(() => weatherController.loading
            ? const Center(
                child: Image(
                    image: AssetImage(
                "assets/loading/loading.gif",
              )))
            : Container(
                decoration: const BoxDecoration(
                  gradient: LinearGradient(
                    colors: [
                      Color.fromRGBO(93, 143, 219, 1),
                      Color.fromRGBO(26, 35, 126, 1)
                    ], // Colores del degradado
                    begin: Alignment.topLeft, 
                    end: Alignment.bottomRight,
                  ),
                ),
                child: Center(
                  child: MainPage(
                      weatherDataCurrent:
                          weatherController.getData().getCurrentWeather()),
                ),
              )),
      ),
    );
  }
}