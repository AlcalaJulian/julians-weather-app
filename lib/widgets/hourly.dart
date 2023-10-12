import 'dart:ui';

import 'package:flutter/material.dart';
import 'package:get/state_manager.dart';
import 'package:intl/intl.dart';
import 'package:julians_weather_app/controller/weather_controller.dart';
import 'package:julians_weather_app/model/hourly_weather_model.dart';

class Hourly extends StatelessWidget {
  final WeatherDataHourly weatherDataHourly;
  Hourly({Key? key, required this.weatherDataHourly})
      : super(key: key);

  RxInt cardIndex = WeatherController().getIndex();

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Container(
              margin: const EdgeInsets.only(top: 20,bottom: 10, left: 20,right: 20),
              alignment: Alignment.topCenter,
              child: const Text("Pronostico por hora",
                  style: TextStyle(fontSize: 18, color: Colors.white)),
            ),
            Container(
              margin: const EdgeInsets.symmetric(vertical: 5, horizontal: 20),
              alignment: Alignment.topCenter,
              child: const Text(
                "Hoy",
                style: TextStyle(fontSize: 18, color: Colors.white),
              ),
            ),
          ],
        ),
        const SizedBox(height: 10),
        hourlyList(context),
      ],
    );
  }

  Widget hourlyList(BuildContext context) {
    return Container(
      height:MediaQuery.of(context).size.height* 0.35,
      padding: const EdgeInsets.only(top: 0, bottom: 10),
      child: ListView.builder(
        scrollDirection: Axis.horizontal,
        itemCount: weatherDataHourly.hourly.length > 12
            ? 14
            : weatherDataHourly.hourly.length,
        itemBuilder: (context, index) {
          return Obx((() => GestureDetector(
              onTap: () {
                cardIndex.value = index;
              },
              child: Padding(
                padding: const EdgeInsets.all(8.0),
                child: ClipRRect(
                  borderRadius: BorderRadius.circular(30),
                  child: Container(
                    height: 100,
                    width: 100,
                    color: Colors.transparent,
                    child: Stack(children: [
                      BackdropFilter(
                        filter: ImageFilter.blur(
                          sigmaX: 4.0,
                          sigmaY: 4.0,
                        ),
                        child: Container(),
                      ),
                      Container(
                        decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(30),
                          border:
                              Border.all(color: Colors.white.withOpacity(0.13)),
                          gradient: LinearGradient(
                              begin: Alignment.topLeft,
                              end: Alignment.bottomRight,
                              colors: [
                                Colors.white.withOpacity(0.15),
                                Colors.white.withOpacity(0.05),
                              ]),
                        ),
                        child: Container(
                          width: 100,
                          height: 130,
                          decoration: BoxDecoration(
                              borderRadius: BorderRadius.circular(30),
                              gradient: cardIndex.value == index
                                  ? const LinearGradient(colors: [
                                      Color.fromRGBO(93, 143, 219, 1),
                                      Color.fromRGBO(26, 35, 126, 1),
                                    ])
                                  : null),
                          child: Column(
                            children: [
                              HourlyDetails(
                                index: index,
                                cardIndex: cardIndex.toInt(),
                                temp: weatherDataHourly.hourly[index].temp!,
                                timeStamp: weatherDataHourly.hourly[index].dt!,
                                weatherIcon: weatherDataHourly
                                    .hourly[index].weather![0].icon!,
                              ),
                            ],
                          ),
                        ),
                      ),
                    ]),
                  ),
                ),
              ))));
        },
      ),
    );
  }
}

// hourly details class
class HourlyDetails extends StatelessWidget {
  int temp;
  int index;
  int cardIndex;
  int timeStamp;
  String weatherIcon;

  HourlyDetails(
      {Key? key,
      required this.cardIndex,
      required this.index,
      required this.timeStamp,
      required this.temp,
      required this.weatherIcon})
      : super(key: key);
  String getTime(final timeStamp) {
    DateTime time = DateTime.fromMillisecondsSinceEpoch(timeStamp * 1000);
    String x = DateFormat('jm').format(time);
    return x;
  }

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(20.0),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.spaceAround,
        children: [
          Text(getTime(timeStamp),
              style: TextStyle(
                color: cardIndex == index
                    ? Colors.white
                    : Colors.black,fontSize: 13
              )),
          Image.asset(
            "assets/weather/$weatherIcon.png",
            height: 50,
            width: 50,
          ),
          Text("$temp°",
              style: TextStyle(
                color: cardIndex == index
                    ? Colors.white
                    : Colors.black,fontSize: 14
              ))
        ],
      ),
    );
  }
}
