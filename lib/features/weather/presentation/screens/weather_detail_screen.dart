import 'package:flutter/material.dart';
import '../../../forecast/data/models/forecast_model.dart';

class WeatherDetailScreen extends StatelessWidget {
  final DailyForecast  forecast;

  const WeatherDetailScreen({super.key, required this.forecast});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(
          "${forecast.maxTemp.toStringAsFixed(1)}° / "
          "${forecast.minTemp.toStringAsFixed(1)}°  —  ${forecast.condition}",
        ),
      ),

      body: Padding(
        padding: const EdgeInsets.all(16.0),

        child: Column(
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            Image.network(
              "https://openweathermap.org/img/wn/${forecast.icon}@2x.png",
              width: 120,
              height: 120,
            ),

            const SizedBox(height: 20),

            Text(
              forecast.condition.toUpperCase(),
              style: const TextStyle(
                fontSize: 20,
                fontWeight: FontWeight.bold
              ),
            ),

            const SizedBox(height: 10),

            Text(
              "Date: ${forecast.date}",
              style: const TextStyle(fontSize: 16),
            ),

            const SizedBox(height: 10),

            Text(
              "Min: ${forecast.minTemp.toStringAsFixed(1)}°C",
              style: const TextStyle(fontSize: 16),
            ),
            Text(
              "Max: ${forecast.maxTemp.toStringAsFixed(1)}°C",
              style: const TextStyle(fontSize: 16),
            ),
          ],
        ),
      ),
    );
  }
}
