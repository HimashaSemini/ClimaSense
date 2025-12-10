import 'package:flutter/material.dart';
import '../../data/models/weather_model.dart';

class WeatherHeading extends StatelessWidget {
  final WeatherModel weather;

  const WeatherHeading({super.key, required this.weather});

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Text(
          weather.cityName,
          style: const TextStyle(
            fontSize: 36,
            color: Colors.white,
            fontWeight: FontWeight.w600,
          ),
        ),

        const SizedBox(height: 5),

        Text(
          "${weather.temperature.toStringAsFixed(1)}°C",
          style: const TextStyle(
            fontSize: 48,
            color: Colors.white,  
            fontWeight: FontWeight.bold,
          ),
        ),

        const SizedBox(height: 5),

        Text(
          weather.condition.toUpperCase(),
          style: const TextStyle(
            fontSize: 18,
            color: Colors.grey,
          ),
        ),
      ],
    );
  }
}
