import '../api/forecast_api_service.dart';
import '../models/forecast_model.dart';

class ForecastRepository {
  final ForecastApiService _api = ForecastApiService();

  Future<ForecastModel?> getForecast(double lat, double lon) async {
    return await _api.fetchForecast(lat, lon);
  }
}
