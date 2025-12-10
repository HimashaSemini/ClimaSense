import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../../../weather/data/models/weather_model.dart';
import '../../../weather/business/providers/weather_provider.dart';

import '../../../weather/presentation/widgets/weather_card.dart';
import '../../../weather/presentation/widgets/weather_header.dart';

import '../../../forecast/presentation/screens/forecast_screen.dart';
import '../../../regionfilter/region_filter_screen.dart';

import '../../../smartalert/alert_screen.dart';
import '../../../favorites/favorites_screen.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  final TextEditingController cityController = TextEditingController();

  @override
  void initState() {
    super.initState();

    /// Auto fetch weather using location
    Future.microtask(() {
      Provider.of<WeatherProvider>(context, listen: false)
          .fetchWeatherByLocation();
    });
  }

  /// Receive selected city from Region screen
  Future<void> openRegionFilter() async {
    final selectedCity = await Navigator.push(
      context,
      MaterialPageRoute(builder: (_) => const RegionFilterScreen()),
    );

    if (selectedCity != null && selectedCity is String) {
      cityController.text = selectedCity;

      Provider.of<WeatherProvider>(context, listen: false)
          .fetchWeather(selectedCity);
      setState(() {});
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("ClimaSense"),
        centerTitle: true,
        actions: [
          /// Alerts
          Consumer<WeatherProvider>(
            builder: (context, provider, child) {
              if (provider.weather == null) return const SizedBox();
              return IconButton(
                icon: const Icon(Icons.notifications_active),
                onPressed: () {
                  Navigator.push(
                    context,
                    MaterialPageRoute(
                      builder: (_) => const AlertsScreen(),
                    ),
                  );
                },
              );
            },
          ),

          /// Favorites
          IconButton(
            icon: const Icon(Icons.favorite),
            onPressed: () {
              Navigator.push(
                context,
                MaterialPageRoute(builder: (_) => const FavoriteCitiesScreen()),
              );
            },
          ),
        ],
      ),

      /// ================================
      /// BODY
      /// ================================
      body: Stack(
        children: [
          //Background wallpaper 
          Positioned.fill(
            child: Image.asset(
              "assets/images/bg.jpg", 
              fit: BoxFit.cover,
            ),
          ),

        Padding(
          padding: const EdgeInsets.all(16),

          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              /// Search bar
              TextField(
                controller: cityController,
                decoration: InputDecoration(
                  filled: true,
                  fillColor: const Color.fromARGB(150, 255, 255, 255),
                  hintText: "Enter city name",
                  border: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(12),
                  ),
                  suffixIcon: IconButton(
                    icon: const Icon(Icons.search),
                    onPressed: () {
                      if (cityController.text.isNotEmpty) {
                        Provider.of<WeatherProvider>(context, listen: false)
                            .fetchWeather(cityController.text);
                      }
                    },
                  ),
                ),
              ),

            const SizedBox(height: 20),

            /// Weather data
            Expanded(
              child: Consumer<WeatherProvider>(
                builder: (context, provider, child) {
                  if (provider.isLoading) {
                    return const Center(child: CircularProgressIndicator());
                  }

                  if (provider.errorMessage != null) {
                    return Center(
                      child: Text(
                        provider.errorMessage!,
                        style: const TextStyle(color: Colors.red),
                      ),
                    );
                  }

                  if (provider.weather == null) {
                    return const Center(
                      child: Text(
                        "Fetching weather...",
                        style: TextStyle(fontSize: 16),
                      ),
                    );
                  }

                  final WeatherModel weather = provider.weather!;

                  return SingleChildScrollView(
                    child: Column(
                      children: [
                        WeatherHeading(weather: weather),
                        const SizedBox(height: 20),

                        WeatherCard(weather: weather),
                        const SizedBox(height: 20),

                        /// Forecast
                        Card(
                          elevation: 3,
                          child: ListTile(
                            leading:
                                const Icon(Icons.calendar_month, size: 30),
                            title: const Text(
                              "View 5‑Day Forecast",
                              style: TextStyle(fontSize: 17),
                            ),
                            trailing: const Icon(Icons.arrow_forward_ios),
                            onTap: () {
                              Navigator.push(
                                context,
                                MaterialPageRoute(
                                  builder: (_) => ForecastScreen(
                                    lat: weather.latitude,
                                    lon: weather.longitude,
                                  ),
                                ),
                              );
                            },
                          ),
                        ),

                        const SizedBox(height: 10),

                        /// Region Filter Button
                        Card(
                          elevation: 3,
                          child: ListTile(
                            leading: const Icon(Icons.map, size: 30),
                            title: const Text(
                              "Filter by Region",
                              style: TextStyle(fontSize: 17),
                            ),
                            trailing: const Icon(Icons.arrow_forward_ios),
                            onTap: openRegionFilter,
                           ),
                            ),
                          ],
                        ),
                      );
                    },
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
