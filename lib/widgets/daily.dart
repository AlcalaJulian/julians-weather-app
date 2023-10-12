import 'dart:io';

import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:julians_weather_app/model/daily_weather_model.dart';
import 'package:intl/intl.dart';

class Daily extends StatelessWidget {
  final WeatherDataDaily weatherDataDaily;
  const Daily({Key? key, required this.weatherDataDaily}) : super(key: key);

  // string manipulation
  String getDay(final day) {
    DateTime time = DateTime.fromMillisecondsSinceEpoch(day * 1000);
    final x = DateFormat('EEEE').format(time);
    switch (x) {
      case 'Monday':
        return 'Lunes';
      case 'Tuesday':
        return 'Martes';
      case 'Wednesday':
        return 'Miércoles';
      case 'Thursday':
        return 'Jueves';
      case 'Friday':
        return 'Viernes';
      case 'Saturday':
        return 'Sábado';
      case 'Sunday':
        return 'Domingo';
      default:
        return x;
    }
  }

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 40, horizontal: 40),
      child: Column(
        children: [
          Container(
            alignment: Alignment.topCenter,
            margin: const EdgeInsets.only(bottom: 10),
            child: const Text(
              "Proximos Días",
              style: TextStyle(color: Colors.white, fontSize: 30),
            ),
          ),
          dailyList(),
        ],
      ),
    );
  }

  Widget dailyList() {
    return SizedBox(
      height: 500,
      child: ListView.builder(
        scrollDirection: Axis.vertical,
        itemCount: weatherDataDaily.daily.length > 3
            ? 4
            : weatherDataDaily.daily.length,
        itemBuilder: (context, index) {
          return Column(
            children: [
              Padding(
                padding: const EdgeInsets.all(8.0),
                child: Container(
                    decoration: const BoxDecoration(
                      borderRadius: BorderRadius.all(Radius.circular(16.0)),
                      gradient: LinearGradient(
                        colors: [
                          Colors.blueAccent,
                          Colors.blueGrey,
                        ],
                        begin: Alignment.topLeft,
                        end: Alignment.bottomRight,
                      ),
                    ),
                    height: 90,
                    padding: const EdgeInsets.all(8),
                    child: Row(
                      crossAxisAlignment: CrossAxisAlignment.center,
                      mainAxisAlignment: MainAxisAlignment.spaceAround,
                      children: [
                        Column(
                          children: [
                            Text(
                              getDay(weatherDataDaily.daily[index].dt),
                              style: const TextStyle(
                                  color: Colors.white, fontSize: 18),
                            ),
                            SizedBox(height: 5),
                            Text(
                              "Max. ${weatherDataDaily.daily[index].temp!.max} °C / Min. ${weatherDataDaily.daily[index].temp!.min} °C",
                              style: const TextStyle(
                                  color: Colors.white, fontSize: 18),
                            ),
                            Text(
                              "${weatherDataDaily.daily[index].weather![0].description}",
                              style: const TextStyle(
                                  color: Colors.white, fontSize: 18),
                            ),
                          ],
                        ),
                        Column(
                          children: [
                            Image.asset(
                              "assets/weather/${weatherDataDaily.daily[index].weather![0].icon}.png",
                              width: 70,
                              height: 70,
                            ),
                          ],
                        ),
                      ],
                    )),
              ),
            ],
          );
        },
      ),
    );
  }
}
