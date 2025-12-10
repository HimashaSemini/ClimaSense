import 'package:flutter/material.dart';
import '../weather/business/providers/weather_provider.dart';
import 'smart_alert.dart';
import 'smart_alert_generator.dart';

class AlertProvider extends ChangeNotifier {
  List<SmartAlert> alerts = [];

  void loadSmartAlerts(WeatherProvider provider) {
    alerts = SmartAlertGenerator.getAlerts(provider);
    notifyListeners();
  }
}
