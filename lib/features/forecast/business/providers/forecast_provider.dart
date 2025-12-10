import 'package:flutter/material.dart';
import '../services/forecast_service.dart';
import '../../data/models/forecast_model.dart';

class ForecastProvider extends ChangeNotifier {
  final ForecastService _service = ForecastService();

  ForecastModel? forecast;
  bool isLoading = false;
  String? errorMessage;

  Future<void> loadForecast(double lat, double lon) async {
    isLoading = true;
    errorMessage = null;
    notifyListeners();

    try {
      forecast = await _service.getForecast(lat, lon);

      if (forecast == null) {
        errorMessage = "Forecast not available.";
      }
    } catch (e) {
      errorMessage = "Error loading forecast.";
    }

    isLoading = false;
    notifyListeners();
  }
}
