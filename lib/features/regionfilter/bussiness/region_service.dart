import 'dart:convert';
import 'package:flutter/services.dart';

class RegionService {
  static Future<List<dynamic>> loadRegions() async {
    final String jsonStr = await rootBundle.loadString(
      'lib/features/regionfilter/data/regions.json',
    );
    return json.decode(jsonStr);
  }

  static Future<List<dynamic>> loadCountries() async {
    final String jsonStr = await rootBundle.loadString(
      'lib/features/regionfilter/data/countries.json',
    );
    return json.decode(jsonStr);
  }

  static Future<List<dynamic>> loadCities() async {
    final String jsonStr = await rootBundle.loadString(
      'lib/features/regionfilter/data/cities.json',
    );
    return json.decode(jsonStr);
  }
}
