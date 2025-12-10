import '../../data/models/weather_model.dart';
import '../../business/services/weather_service.dart';

class WeatherRepository {
  final WeatherService _weatherService = WeatherService();

  Future<WeatherModel?> getWeather(String cityName) async {
    return await _weatherService.getWeather(cityName);
  }

  Future<List<String>> searchRegions(String query) async {
    return await _weatherService.searchRegions(query);
  }

  Future<String> getAlerts(double lat, double lon) async {
    return await _weatherService.getAlerts(lat, lon);
  }

  Future<WeatherModel?> getWeatherByLatLon(double lat, double lon) async {
    return await _weatherService.getWeatherByLatLon(lat, lon);
  }
}
