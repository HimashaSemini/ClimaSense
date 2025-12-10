class WeatherModel {
  final String cityName;
  final double temperature;
  final String condition;
  final String icon;
  final double windSpeed;
  final String date;
  final int humidity;
  final double latitude;
  final double longitude;

  WeatherModel({
    required this.cityName,
    required this.temperature,
    required this.condition,
    required this.icon,
    required this.windSpeed,
    required this.date,
    required this.humidity,
    required this.latitude,
    required this.longitude,
  });

  factory WeatherModel.fromJson(Map<String, dynamic> json) {
    return WeatherModel(
      cityName: json["name"] ?? "",
      temperature: (json["main"]["temp"] as num).toDouble(),
      condition: json["weather"][0]["description"],
      icon: json["weather"][0]["icon"],
      windSpeed: (json["wind"]["speed"] as num).toDouble(),

      // FIXED → CURRENT WEATHER HAS ONLY "dt"
      date: DateTime.fromMillisecondsSinceEpoch(json["dt"] * 1000).toString(),

      humidity: json["main"]["humidity"],
      latitude: (json["coord"]["lat"] as num).toDouble(),
      longitude: (json["coord"]["lon"] as num).toDouble(),
    );
  }

  WeatherModel copyWith({
    String? cityName,
    double? temperature,
    String? condition,
    String? icon,
    double? windSpeed,
    String? date,
    int? humidity,
    double? latitude,
    double? longitude,
  }) {
    return WeatherModel(
      cityName: cityName ?? this.cityName,
      temperature: temperature ?? this.temperature,
      condition: condition ?? this.condition,
      icon: icon ?? this.icon,
      windSpeed: windSpeed ?? this.windSpeed,
      date: date ?? this.date,
      humidity: humidity ?? this.humidity,
      latitude: latitude ?? this.latitude,
      longitude: longitude ?? this.longitude,
    );
  }
}
