import 'package:flutter/material.dart';
import 'package:weather_app/constants.dart';
import 'package:weather_app/weather/open_weather.dart';
import 'package:material_design_icons_flutter/material_design_icons_flutter.dart';
import 'package:google_fonts/google_fonts.dart';

void main() {
  runApp(const MainApp());
}

class MainApp extends StatefulWidget {
  const MainApp({super.key});

  @override
  State<MainApp> createState() => _MainAppState();
}

class _MainAppState extends State<MainApp> {
  final openWeatherApi = const OpenWeatherAPI(OPEN_WEATHER_API_KEY);
  @override
  Widget build(BuildContext context) {
    final textTheme = Theme.of(context).textTheme;

    return MaterialApp(
      theme: ThemeData(
        textTheme: GoogleFonts.latoTextTheme(textTheme).copyWith(
          bodyMedium: GoogleFonts.poppins(textStyle: textTheme.bodyMedium),
        ),
      ),
      debugShowCheckedModeBanner: false,
      home: Scaffold(
          body: Center(
        child: SafeArea(
          child: FutureBuilder(
            future: openWeatherApi.getWeather(
                lat: 6.93832000797627, lon: 81.07097479033017),
            builder: (context, snapshot) {
              if (snapshot.connectionState == ConnectionState.waiting) {
                return const CircularProgressIndicator();
              } else if (snapshot.hasError) {
                return Text('Error: ${snapshot.error}');
              }
              var weatherData = snapshot.data;
              if (weatherData == null) {
                return const Text('No weather data available');
              }

              return Column(
                children: [
                  Image.network(openWeatherApi
                      .getWeatherIcon(weatherData['weather'][0]['icon'])),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        '${weatherData['main']['temp']}',
                        style: const TextStyle(
                          fontSize: 40,
                          fontWeight: FontWeight.bold,
                          height: 1,
                        ),
                      ),
                      const Text(
                        '°C',
                        style: TextStyle(
                            fontSize: 20, fontWeight: FontWeight.bold),
                      ),
                    ],
                  ),
                  Text(
                    weatherData['name'],
                    style: const TextStyle(fontSize: 15),
                  ),
                  Container(
                    width: double.infinity,
                    margin: const EdgeInsets.symmetric(
                        horizontal: 20, vertical: 20),
                    padding: const EdgeInsets.all(10),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceAround,
                      children: [
                        Column(
                          children: [
                            Icon(Icons.water_drop_outlined,
                                color: Colors.blue[700]),
                            Text(
                              '${weatherData['main']['humidity']}%',
                              style: const TextStyle(
                                fontSize: 15,
                                fontWeight: FontWeight.bold,
                              ),
                            ),
                          ],
                        ),
                        Column(
                          children: [
                            Icon(MdiIcons.thermometerMinus,
                                color: Colors.red[700]),
                            Text(
                              '${weatherData['main']['temp_min']}°C',
                              style: const TextStyle(
                                  fontSize: 15, fontWeight: FontWeight.bold),
                            ),
                          ],
                        ),
                        Column(
                          children: [
                            Icon(MdiIcons.thermometerPlus,
                                color: Colors.red[700]),
                            Text(
                              '${weatherData['main']['temp_max']}°C',
                              style: const TextStyle(
                                  fontSize: 15, fontWeight: FontWeight.bold),
                            ),
                          ],
                        ),
                      ],
                    ),
                  )
                ],
              );
            },
          ),
        ),
      )),
    );
  }
}
