import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../weather/business/providers/weather_provider.dart';
import 'favourites_provider.dart';

class FavoriteCitiesScreen extends StatelessWidget {
  const FavoriteCitiesScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text("Favorite Cities")),

      body: Stack(
        children: [
          /// BACKGROUND IMAGE
          Positioned.fill(
            child: Image.asset(
              "assets/images/bg2.jpg",
              fit: BoxFit.cover,
            ),
          ),

          /// FAVORITE LIST
          Consumer<FavoriteProvider>(
            builder: (context, provider, child) {
              if (provider.favorites.isEmpty) {
                return const Center(
                  child: Text(
                    "No favorites yet",
                    style: TextStyle(fontSize: 18, color: Colors.white),
                  ),
                );
              }

              return ListView.builder(
                padding: const EdgeInsets.all(16),
                itemCount: provider.favorites.length,
                itemBuilder: (context, index) {
                  final fav = provider.favorites[index];

                  return Dismissible(
                    key: ValueKey(fav),

                    direction: DismissDirection.endToStart,

                    background: Container(
                      alignment: Alignment.centerRight,
                      padding: const EdgeInsets.symmetric(horizontal: 20),
                      margin: const EdgeInsets.only(bottom: 12),
                      decoration: BoxDecoration(
                        color: Colors.redAccent.withOpacity(0.8),
                        borderRadius: BorderRadius.circular(16),
                      ),
                      child: const Icon(Icons.delete, color: Colors.white, size: 32),
                    ),

                    onDismissed: (_) {
                      provider.removeFavorite(fav);
                      ScaffoldMessenger.of(context).showSnackBar(
                        SnackBar(
                          content: Text("$fav removed"),
                          duration: const Duration(seconds: 1),
                        ),
                      );
                    },

                    child: AnimatedContainer(
                      duration: const Duration(milliseconds: 250),
                      curve: Curves.easeOut,
                      margin: const EdgeInsets.only(bottom: 12),
                      decoration: BoxDecoration(
                        color: Colors.white.withOpacity(0.18),
                        borderRadius: BorderRadius.circular(16),
                        border: Border.all(color: Colors.white30),
                      ),

                      child: ListTile(
                        title: Text(
                          fav,
                          style: const TextStyle(
                            color: Colors.white,
                            fontSize: 18,
                          ),
                        ),

                        /// LOAD WEATHER
                        onTap: () {
                          Provider.of<WeatherProvider>(context, listen: false)
                              .fetchWeather(fav);
                          Navigator.pop(context);
                        },

                        trailing: IconButton(
                          icon: const Icon(Icons.edit, color: Colors.white),
                          onPressed: () => _editCity(context, provider, fav),
                        ),
                      ),
                    ),
                  );
                },
              );
            },
          ),
        ],
      ),
    );
  }

  /// RENAME DIALOG
  void _editCity(BuildContext context, FavoriteProvider provider, String oldCity) {
    final controller = TextEditingController(text: oldCity);

    showDialog(
      context: context,
      builder: (context) => AlertDialog(
        title: const Text("Rename City"),
        content: TextField(
          controller: controller,
          decoration: const InputDecoration(labelText: "New city name"),
        ),
        actions: [
          TextButton(
            onPressed: () => Navigator.pop(context),
            child: const Text("Cancel"),
          ),
          TextButton(
            onPressed: () {
              provider.updateFavorite(oldCity, controller.text);
              Navigator.pop(context);
            },
            child: const Text("Update"),
          ),
        ],
      ),
    );
  }
}
