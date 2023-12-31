import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:julians_weather_app/pages/home_screen.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return const GetMaterialApp(
      home: HomeScreen(),
      title: " Julians Weather App",
      debugShowCheckedModeBanner: false,
    );
  }
}
