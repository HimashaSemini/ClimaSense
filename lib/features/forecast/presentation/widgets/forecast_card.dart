import 'package:flutter/material.dart';
import '../../data/models/forecast_model.dart';

class ForecastCard extends StatelessWidget {
  final DailyForecast day;

  const ForecastCard({super.key, required this.day});

  @override
  Widget build(BuildContext context) {
    return Card(
      margin: const EdgeInsets.symmetric(vertical: 10, horizontal: 16),
      child: ListTile(
        title: Text(day.date),
        subtitle: Text(day.description),
        trailing: Text(
          "${day.minTemp}°C / ${day.maxTemp}°C",
          style: const TextStyle(fontWeight: FontWeight.bold),
        ),
      ),
    );
  }
}
