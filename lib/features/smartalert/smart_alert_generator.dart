import 'package:flutter/material.dart';
import '../weather/business/providers/weather_provider.dart';
import 'smart_alert.dart';

class SmartAlertGenerator {
  static List<SmartAlert> getAlerts(WeatherProvider provider) {
    final weather = provider.weather;
    if (weather == null) return [];

    final double temp = weather.temperature;
    final String condition = weather.condition.toLowerCase();

    List<SmartAlert> alerts = [];

    /// Rain alert
    if (condition.contains("rain")) {
      alerts.add(
        SmartAlert(
          title: "Rainy Weather",
          message: 
          "It looks like it's going to rain today. Make sure to carry an umbrella. ☔  "
          "..........................................................   " 
          "Wear slip-resistant shoes, and allow for extra travel time. Roads may be wet, "
          "so stay safe if you're heading out!",
          icon: Icons.beach_access,
          color: Colors.blue,
        ),
      );
    }

    /// Hot weather alert
    if (temp > 30) {
      alerts.add(
        SmartAlert(
          title: "Hot Day",
          message: 
          "Today is extremely hot! Remember to drink plenty of water 💧, avoid staying "
          "..........................................................   " 
          "Directly under the sun for too long, and try to wear light clothing. "
          "If you feel dizzy or tired, take a break in a cool place.",
          icon: Icons.wb_sunny,
          color: Colors.orange,
        ),
      );
    }

    /// Cold alert
    if (temp < 15) {
      alerts.add(
        SmartAlert(
          title: "Cold Weather",
          message: 
          "The temperature is quite low today.                                          "
          "..........................................................   " 
          "Be sure to wear warm clothes 🧣🧤 especially if you’re going out early in the morning or late at night. Keep yourself warm!",
          icon: Icons.ac_unit,
          color: Colors.lightBlueAccent,
        ),
      );
    }

    /// Clear sky
    if (condition.contains("clear")) {
      alerts.add(
        SmartAlert(
          title: "Clear & Sunny",
          message: 
          "The sky is clear and the weather looks amazing today!☀️                     "
          "..........................................................   " 
          "It's a perfect time for outdoor activities. Don’t forget your sunglasses and apply sunscreen if you stay out long.",
          icon: Icons.wb_cloudy,
          color: Colors.green,
        ),
      );
    }

    return alerts;
  }
}
