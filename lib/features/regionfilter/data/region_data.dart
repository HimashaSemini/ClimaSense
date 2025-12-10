// lib/features/regionfilter/data/region_data.dart

class RegionData {
  static const List<String> regions = [
    "Asia",
    "Europe",
    "Africa",
    "North America",
    "South America",
    "Australia",
    "Antarctica"
  ];

  static const Map<String, List<String>> countries = {
    "Asia": ["Sri Lanka", "India", "Japan", "China"],
    "Europe": ["France", "Germany", "Italy", "Spain"],
    "Africa": ["Kenya", "Egypt", "Nigeria", "South Africa"],
    "North America": ["USA", "Canada", "Mexico"],
    "South America": ["Brazil", "Argentina", "Chile"],
    "Australia": ["Australia"],
    "Antarctica": ["Research Base 1"]
  };

  static const Map<String, List<String>> cities = {
    "Sri Lanka": ["Colombo", "Kandy", "Galle"],
    "India": ["Mumbai", "Delhi", "Bangalore"],
    "Japan": ["Tokyo", "Osaka", "Kyoto"],
    "China": ["Beijing", "Shanghai"],

    "France": ["Paris", "Lyon"],
    "Germany": ["Berlin", "Munich"],
    "Italy": ["Rome", "Milan"],
    "Spain": ["Madrid", "Barcelona"],

    "Kenya": ["Nairobi", "Mombasa"],
    "Egypt": ["Cairo", "Alexandria"],
    "Nigeria": ["Lagos", "Abuja"],
    "South Africa": ["Cape Town", "Johannesburg"],

    "USA": ["New York", "Los Angeles"],
    "Canada": ["Toronto", "Vancouver"],
    "Mexico": ["Mexico City", "Cancun"],

    "Brazil": ["Rio", "São Paulo"],
    "Argentina": ["Buenos Aires"],
    "Chile": ["Santiago"],

    "Australia": ["Sydney", "Melbourne"],

    "Research Base 1": ["Base Camp"]
  };
}
