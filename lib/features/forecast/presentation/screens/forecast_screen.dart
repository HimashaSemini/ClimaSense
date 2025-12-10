import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../../business/providers/forecast_provider.dart';
import '../../data/models/forecast_model.dart';
import '../../../../core/theme/app_colors.dart';

class ForecastScreen extends StatelessWidget {
  final double lat;
  final double lon;

  const ForecastScreen({
    super.key,
    required this.lat,
    required this.lon,
  });

  IconData getWeatherIcon(String condition) {
    switch (condition.toLowerCase()) {
      case "rain":
        return Icons.water_drop;
      case "clouds":
        return Icons.cloud;
      case "clear":
        return Icons.wb_sunny;
      case "thunderstorm":
        return Icons.flash_on;
      case "snow":
        return Icons.ac_unit;
      default:
        return Icons.wb_cloudy;
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.deepPurple,

      appBar: AppBar(
        title: const Text("Forecast"),
        elevation: 0,
        backgroundColor: AppColors.darkIndigo,
        foregroundColor: Colors.white,
      ),

      extendBodyBehindAppBar: true,

      body: Container(
        decoration: const BoxDecoration(
          gradient: LinearGradient(
            colors: [AppColors.deepPurple,
              AppColors.purpleShade,],
            begin: Alignment.topCenter,
            end: Alignment.bottomCenter,
          ),
        ),

        child: FutureBuilder(
          future: Provider.of<ForecastProvider>(context, listen: false)
              .loadForecast(lat, lon),
          builder: (context, snapshot) {
            return Consumer<ForecastProvider>(
              builder: (context, provider, child) {
                if (provider.isLoading) {
                  return const Center(child: CircularProgressIndicator(color: AppColors.skyBlue,));
                }

                if (provider.errorMessage != null) {
                  return Center(
                    child: Text(
                      provider.errorMessage!,
                      style: const TextStyle(color: Colors.redAccent, fontSize: 18),
                    ),
                  );
                }

                if (provider.forecast == null) {
                  return const Center(
                    child: Text(
                      "No forecast available.",
                      style: TextStyle(color: Colors.white, fontSize: 18),
                    ),
                  );
                }

                final ForecastModel forecast = provider.forecast!;

                return ListView.builder(
                  padding: const EdgeInsets.only(top: 120, left: 16, right: 16, bottom: 20),
                  itemCount: forecast.days.length,
                  itemBuilder: (context, index) {
                    final day = forecast.days[index];

                    return Container(
                      margin: const EdgeInsets.only(bottom: 20),
                      decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(20),
                        color: const Color.fromARGB(43, 255, 255, 255),
                        border: Border.all(color: const Color.fromARGB(155, 255, 255, 255)),
                      ),
                      child: ListTile(
                        contentPadding: const EdgeInsets.all(18),
                        leading: CircleAvatar(
                          radius: 28,
                          backgroundColor: const Color.fromARGB(167, 144, 117, 227),
                          child: Icon(
                            getWeatherIcon(day.condition),
                            color: const Color.fromARGB(174, 143, 223, 255),
                            size: 32,
                          ),
                        ),
                        title: Text(
                          day.date,
                          style: const TextStyle(
                            fontSize: 18,
                            fontWeight: FontWeight.bold,
                            color: Colors.white,
                          ),
                        ),
                        subtitle: Text(
                          day.description,
                          style: const TextStyle(color: Colors.white70),
                        ),
                        trailing: Text(
                          "${day.maxTemp}° / ${day.minTemp}°",
                          style: const TextStyle(
                            fontSize: 16,
                            fontWeight: FontWeight.bold,
                            color: Colors.white,
                          ),
                        ),
                      ),
                    );
                  },
                );
              },
            );
          },
        ),
      ),
    );
  }
}
