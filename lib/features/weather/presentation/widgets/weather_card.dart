import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../../data/models/weather_model.dart';
import '../../../favorites/favourites_provider.dart';

class WeatherCard extends StatelessWidget {
  final WeatherModel weather;

  const WeatherCard({super.key, required this.weather});

  @override
  Widget build(BuildContext context) {
    final favProvider = Provider.of<FavoriteProvider>(context);

    final bool isFav = favProvider.isFavorite(weather.cityName);

    return Card(
      elevation: 4,
      margin: const EdgeInsets.symmetric(horizontal: 12, vertical: 8),
      child: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Row(
          children: [

            /// WEATHER ICON
            Image.network(
              "https://openweathermap.org/img/wn/${weather.icon}@2x.png",
              width: 80,
              height: 80,
            ),

            const SizedBox(width: 20),

            /// WEATHER DETAILS + FAVORITE BUTTON
            Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [

                  /// City Name + Favorite Button
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Text(
                        weather.cityName,
                        style: const TextStyle(
                          fontSize: 18,
                          fontWeight: FontWeight.bold
                        ),
                      ),

                      IconButton(
                        icon: Icon(
                          isFav ? Icons.favorite : Icons.favorite_border,
                          color: isFav ? Colors.red : Colors.grey,
                        ),
                        onPressed: () {
                          if (isFav) {
                            favProvider.removeFavorite(weather.cityName);
                          } else {
                            favProvider.addFavorite(weather.cityName);
                          }
                        },
                      ),
                    ],
                  ),

                  const SizedBox(height: 6),

                  Text(
                    weather.condition.toUpperCase(),
                    style: const TextStyle(fontSize: 16),
                  ),

                  const SizedBox(height: 8),

                  Text("Humidity: ${weather.humidity}%",
                      style: const TextStyle(fontSize: 14)),

                  Text("Wind: ${weather.windSpeed} m/s",
                      style: const TextStyle(fontSize: 14)),

                  Text("Date: ${weather.date}",
                      style: const TextStyle(fontSize: 14)),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}
