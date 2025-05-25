import 'package:flutter/material.dart';
import 'package:weather_app/constants.dart';
import 'package:weather_app/weather/open_weather.dart';

void main() {
  runApp(const MainApp());
}

class MainApp extends StatefulWidget {
  final openWeatherApi = const OpenWeatherAPI(OPEN_WEATHER_API_KEY);

  const MainApp({super.key});

  @override
  State<MainApp> createState() => _MainAppState();
}

class _MainAppState extends State<MainApp> {
  @override
  Widget build(BuildContext context) {
    return const MaterialApp(
      home: Scaffold(
        body: Center(
          child: Text('Hello World!'),
        ),
      ),
    );
  }
}
