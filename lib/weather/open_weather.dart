import 'package:http/http.dart' as http;

class OpenWeatherAPI {
  final String apiKey;

  const OpenWeatherAPI(this.apiKey);

  void getWeather({
    required double lat,
    required double lon,
  }) {
    var url =
        "https://api.openweathermap.org/data/3.0/onecall?lat=$lat&lon=$lon&exclude={part}&appid=$apiKey";

    http.get(Uri.parse(url)).then((response) {
      if (response.statusCode == 200) {
        // Handle successful response
        print('Weather data: ${response.body}');
      } else {
        // Handle error response
        print('Error fetching weather data: ${response.statusCode}');
      }
    }).catchError((error) {
      // Handle network or other errors
      print('Error: $error');
    });
  }
}
