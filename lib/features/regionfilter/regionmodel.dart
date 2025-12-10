class Region {
  final String name;
  final List<String> countries;

  Region({
    required this.name,
    required this.countries,
  });

  factory Region.fromJson(Map<String, dynamic> json) {
    return Region(
      name: json["name"],
      countries: List<String>.from(json["countries"]),
    );
  }
}
