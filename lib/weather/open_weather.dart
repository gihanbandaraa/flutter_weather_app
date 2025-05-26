import 'dart:convert';

import 'package:http/http.dart' as http;

class OpenWeatherAPI {
  final String apiKey;

  const OpenWeatherAPI(this.apiKey);

  Future<Map> getWeather({
    required double lat,
    required double lon,
  }) async {
    var url =
        "https://api.openweathermap.org/data/2.5/weather?units=metric&lat=$lat&lon=$lon&exclude={part}&appid=$apiKey";

    var res = await http.get(Uri.parse(url));
    print(res.body);
    return jsonDecode(res.body);
  }

  String getWeatherIcon(String iconCode) {
    return "https://openweathermap.org/img/wn/$iconCode@4x.png";
  }
}
