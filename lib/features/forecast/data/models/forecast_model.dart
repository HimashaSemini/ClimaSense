class DailyForecast {
  final String date;
  final double minTemp;
  final double maxTemp;
  final String description;
  final int humidity;
  final double windSpeed;
  final String condition;  
  final String icon; 

  DailyForecast({
    required this.date,
    required this.minTemp,
    required this.maxTemp,
    required this.description,
    required this.humidity,
    required this.windSpeed,
    required this.condition,
    required this.icon,
  });

  factory DailyForecast.fromJson(Map<String, dynamic> json) {
  return DailyForecast(
    date: json['dt_txt'] ?? '',
    minTemp: (json['main']['temp_min']).toDouble(),
    maxTemp: (json['main']['temp_max']).toDouble(),
    description: json['weather'][0]['description'],
    humidity: json['main']['humidity'],
    windSpeed: json['wind']['speed'].toDouble(),
    condition: json["weather"][0]["main"], 
    icon: json["weather"][0]["icon"],
  );}}

class ForecastModel {
  final List<DailyForecast> days;
  ForecastModel({required this.days});

  factory ForecastModel.fromJson(Map<String, dynamic> json) {
    return ForecastModel(
      days: (json["list"] as List)
          .map((e) => DailyForecast.fromJson(e))
          .toList(),
    );}}


