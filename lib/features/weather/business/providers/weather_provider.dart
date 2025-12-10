import 'package:flutter/material.dart';
import '../../data/models/weather_model.dart';
import '../services/weather_service.dart';
import '../../../../core/utils/location_service.dart';

import 'package:ClimaSense/features/regionfilter/regionmodel.dart';
import '../../../regionfilter/bussiness/region_service.dart';

class WeatherProvider extends ChangeNotifier {
  final WeatherService _service = WeatherService();

  WeatherModel? weather;
  bool isLoading = false;
  String? errorMessage;

  // -----------------------------------------------------
  // FETCH WEATHER BY CITY
  // -----------------------------------------------------
  Future<void> fetchWeather(String city) async {
    isLoading = true;
    errorMessage = null;
    notifyListeners();

    try {
      weather = await _service.getWeather(city);

      if (weather == null) {
        errorMessage = "City not found.";
      }
    } catch (e) {
      errorMessage = "Error: Unable to load weather.";
    }

    isLoading = false;
    notifyListeners();
  }

  // -----------------------------------------------------
  // AUTO-DETECT WEATHER BY LOCATION
  // -----------------------------------------------------
  Future<void> fetchWeatherByLocation() async {
    isLoading = true;
    errorMessage = null;
    notifyListeners();

    try {
      final locationService = LocationService();
      final pos = await locationService.getCurrentLocation();

      if (pos == null) {
        errorMessage = "Unable to fetch location.";
      } else {
        weather = await _service.getWeatherByLatLon(
          pos.latitude,
          pos.longitude,
        );
      }
    } catch (e) {
      errorMessage = "Error getting location weather.";
    }

    isLoading = false;
    notifyListeners();
  }

  // -----------------------------------------------------
  // OPTIONAL — Convert country name → code
  // -----------------------------------------------------
  Future<String?> countryNameToCode(String name) async {
    final countriesJson = await RegionService.loadCountries();

    final country = countriesJson.firstWhere(
      (c) => c["name"].toLowerCase() == name.toLowerCase(),
      orElse: () => null,
    );

    return country == null ? null : country["code"];
  }

  // -----------------------------------------------------
  // SEARCH REGION COUNTRIES
  // -----------------------------------------------------
  Future<List<Region>> searchRegionCountries(String query) async {
    final regionsJson = await RegionService.loadRegions();
    List<Region> allRegions =
        regionsJson.map((e) => Region.fromJson(e)).toList();

    if (query.isEmpty) return allRegions;

    return allRegions
        .where((r) => r.name.toLowerCase().contains(query.toLowerCase()))
        .toList();
  }

  // -----------------------------------------------------
  // AUTOCOMPLETE REGION SEARCH
  // -----------------------------------------------------
  Future<List<String>> searchRegions(String query) async {
    if (query.isEmpty) return [];
    return await _service.searchRegions(query);
  }
}
