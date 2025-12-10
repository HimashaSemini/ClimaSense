// lib/features/regionfilter/business/region_provider.dart

import 'package:flutter/material.dart';
import '../data/region_data.dart';

class RegionProvider extends ChangeNotifier {
  List<String> getRegions() => RegionData.regions;

  List<String> getCountries(String region) {
    return RegionData.countries[region] ?? [];
  }

  List<String> getCities(String country) {
    return RegionData.cities[country] ?? [];
  }
}
