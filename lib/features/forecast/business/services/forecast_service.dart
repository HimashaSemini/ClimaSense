import '../../data/api/forecast_api_service.dart';
import '../../data/models/forecast_model.dart';

class ForecastService {
  final ForecastApiService _api = ForecastApiService();

  Future<ForecastModel?> getForecast(double lat, double lon) async {
    try {
      return await _api.fetchForecast(lat, lon);
    } catch (e) {
      rethrow;
    }
  }
}
