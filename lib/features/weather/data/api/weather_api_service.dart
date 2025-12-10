import 'dart:convert';
import 'package:http/http.dart' as http;
import '../../../../core/utils/constants.dart';
import '../models/weather_model.dart';

class WeatherApiService {
  // -------------------------------------------------------------
  // 1. SEARCH CITIES (Free Geocoding API)
  // -------------------------------------------------------------
  Future<List<String>> searchCities(String query) async {
    final url =
        "https://api.openweathermap.org/geo/1.0/direct?q=$query&limit=5&appid=$kOpenWeatherApiKey";

    final response = await http.get(Uri.parse(url));
    if (response.statusCode != 200) return [];

    final List data = jsonDecode(response.body);
    return data.map((e) => e["name"] as String).toList();
  }

  // -------------------------------------------------------------
  // 2. FETCH WEATHER (Free Geocoding → Free Current Weather API)
  // -------------------------------------------------------------
  Future<WeatherModel?> fetchWeather(String city) async {
    // Step 1 → Convert city → lat/lon
    final geoUrl =
        "https://api.openweathermap.org/geo/1.0/direct?q=$city&limit=1&appid=$kOpenWeatherApiKey";

    final geoRes = await http.get(Uri.parse(geoUrl));
    if (geoRes.statusCode != 200) return null;

    final geoData = jsonDecode(geoRes.body);
    if (geoData.isEmpty) return null;

    final double lat = (geoData[0]["lat"] as num).toDouble();
    final double lon = (geoData[0]["lon"] as num).toDouble();
    final String cityName = geoData[0]["name"];

    // Step 2 → Fetch CURRENT weather (FREE)
    final weatherUrl =
        "https://api.openweathermap.org/data/2.5/weather?lat=$lat&lon=$lon&units=metric&appid=$kOpenWeatherApiKey";

    final weatherRes = await http.get(Uri.parse(weatherUrl));
    if (weatherRes.statusCode != 200) return null;

    final json = jsonDecode(weatherRes.body);

    return WeatherModel.fromJson(json).copyWith(
      cityName: cityName,
      latitude: lat,
      longitude: lon,
    );
  }

  // -------------------------------------------------------------
  // 3. FETCH ALERTS (Free One Call 3.0 → Alerts are FREE)
  // -------------------------------------------------------------
  Future<String> fetchAlerts(double lat, double lon) async {
    final url =
        "https://api.openweathermap.org/data/3.0/onecall?lat=$lat&lon=$lon&appid=$kOpenWeatherApiKey";

    final response = await http.get(Uri.parse(url));
    if (response.statusCode != 200) return "No alerts.";

    final json = jsonDecode(response.body);

    if (json["alerts"] == null) return "No alerts available.";

    return json["alerts"][0]["event"] ?? "Weather Alert";
  }

  Future<WeatherModel?> getWeatherByLatLon(double lat, double lon) async {
  final url =
      "https://api.openweathermap.org/data/2.5/weather?lat=$lat&lon=$lon&units=metric&appid=$kOpenWeatherApiKey";

  final response = await http.get(Uri.parse(url));
  if (response.statusCode != 200) return null;

  final json = jsonDecode(response.body);

  return WeatherModel.fromJson(json).copyWith(
    latitude: lat,
    longitude: lon,
  );
}



}
