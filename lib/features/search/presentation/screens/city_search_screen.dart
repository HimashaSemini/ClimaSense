import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../../../../core/theme/app_colors.dart';
import '../../../../core/theme/app_text_styles.dart';
import '../../business/providers/search_provider.dart';

class CitySearchScreen extends StatefulWidget {
  const CitySearchScreen({super.key});

  @override
  State<CitySearchScreen> createState() => _CitySearchScreenState();
}

class _CitySearchScreenState extends State<CitySearchScreen> {
  final TextEditingController _controller = TextEditingController();

  @override
  Widget build(BuildContext context) {
    final provider = Provider.of<SearchProvider>(context);

    return Scaffold(
      appBar: AppBar(
        title: const Text('Search City', style: AppTextStyles.heading3),
        backgroundColor: AppColors.deepPurple,
      ),
      body: Padding(
        padding: const EdgeInsets.all(16),
        child: Column(
          children: [
            TextField(
              controller: _controller,
              decoration: InputDecoration(
                hintText: 'Enter city name',
                filled: true,
                fillColor: Colors.white,
                border: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(12),
                ),
                suffixIcon: IconButton(
                  icon: const Icon(Icons.clear),
                  onPressed: () {
                    _controller.clear();
                    provider.clearResults();
                  },
                ),
              ),
              onChanged: (value) {
                provider.searchCities(value);
              },
            ),
            const SizedBox(height: 16),
            if (provider.isLoading) const CircularProgressIndicator(),
            if (provider.errorMessage != null)
              Text(provider.errorMessage!, style: const TextStyle(color: Colors.red)),
            Expanded(
              child: ListView.builder(
                itemCount: provider.searchResults.length,
                itemBuilder: (context, index) {
                  final city = provider.searchResults[index];
                  return ListTile(
                    leading: Image.network(
                      "https://openweathermap.org/img/wn/${city.icon}@2x.png",
                      width: 40,
                      height: 40,
                    ),
                    title: Text('${city.cityName}, ${city.country}', style: AppTextStyles.body1),
                    onTap: () {
                      Navigator.pop(context, city.cityName);
                    },
                  );
                },
              ),
            ),
          ],
        ),
      ),
    );
  }
}
