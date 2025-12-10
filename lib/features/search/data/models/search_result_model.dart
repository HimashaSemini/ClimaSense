class SearchResultModel {
  final String cityName;
  final String country;
  final double lat;
  final double lon;
  final String icon; 

  SearchResultModel({
    required this.cityName,
    required this.country,
    required this.lat,
    required this.lon,
    required this.icon,
  });

  factory SearchResultModel.fromJson(Map<String, dynamic> json) {
    return SearchResultModel(
      cityName: json['name'],
      country: json['sys']['country'],
      lat: (json['coord']['lat'] as num).toDouble(),
      lon: (json['coord']['lon'] as num).toDouble(),
      icon: (json['weather'] != null && json['weather'].isNotEmpty)
          ? json['weather'][0]['icon']
          : '01d', // default icon
    );
  }
}
