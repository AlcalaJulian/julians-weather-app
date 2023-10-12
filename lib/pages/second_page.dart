import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:julians_weather_app/widgets/daily.dart';

import '../controller/weather_controller.dart';

class SecondPage extends StatelessWidget {
  final weatherController = Get.find<WeatherController>();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Stack(
        children: [
          Container(
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
            child: Daily(
              weatherDataDaily: weatherController.getData().getDailyWeather(),
            ),
          ),
          Positioned(
            top: 33,
            left: 0,
            child: IconButton(
              icon: const Icon(
                Icons.arrow_back_ios_new,
                color: Colors.white,
                size: 30,
              ),
              onPressed: () {
                Navigator.pop(context);
              },
            ),
          )
        ],
      ),
    );
  }
}
