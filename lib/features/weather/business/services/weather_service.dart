import '../../data/api/weather_api_service.dart';
import '../../data/models/weather_model.dart';

class WeatherService {
  final WeatherApiService _api = WeatherApiService();

  Future<WeatherModel?> getWeather(String city) async {
    return await _api.fetchWeather(city);
  }

  Future<String> getAlerts(double lat, double lon) async {
    return await _api.fetchAlerts(lat, lon);
  }

  Future<List<String>> searchRegions(String query) async {
    return await _api.searchCities(query);
  }

  Future<WeatherModel?> getWeatherByLatLon(double lat, double lon) async {
    return await _api.getWeatherByLatLon(lat, lon);   
  }
}
