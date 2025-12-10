import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'bussiness/regionprovider.dart';

class RegionFilterScreen extends StatefulWidget {
  const RegionFilterScreen({super.key});

  @override
  State<RegionFilterScreen> createState() => _RegionFilterScreenState();
}

class _RegionFilterScreenState extends State<RegionFilterScreen> {
  String? selectedRegion;
  String? selectedCountry;

  List<String> regions = [];
  List<String> countries = [];
  List<String> cities = [];

  @override
  void initState() {
    super.initState();
    loadRegions();
  }

  void loadRegions() {
    final provider = Provider.of<RegionProvider>(context, listen: false);
    regions = provider.getRegions();
    setState(() {});
  }

  void loadCountries(String region) {
    final provider = Provider.of<RegionProvider>(context, listen: false);
    countries = provider.getCountries(region);
    setState(() {});
  }

  void loadCities(String country) {
    final provider = Provider.of<RegionProvider>(context, listen: false);
    cities = provider.getCities(country);
    setState(() {});
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text("Filter by Region")),

      body: Stack(
        children: [
          //Background wallpaper 
          Positioned.fill(
            child: Image.asset(
              "assets/images/bg3.jpg", 
              fit: BoxFit.cover,
            ),
          ),
      
      Padding(
        padding: const EdgeInsets.all(16),
        child: Column(
          children: [
            /// REGION DROPDOWN
            DropdownButtonFormField<String>(
              decoration: const InputDecoration(
                labelText: "Region",
                labelStyle: TextStyle(color: Colors.white), 
                border: OutlineInputBorder(),
                filled: true,
                fillColor: Color.fromARGB(88, 0, 0, 0),
              ),

              dropdownColor: const Color.fromARGB(173, 54, 71, 79),
              items: regions.map((r) => DropdownMenuItem(
                value: r,
                child: Text(r, style: const TextStyle(color: Colors.white)),
              )).toList(),
              onChanged: (value) {
                selectedRegion = value;
                selectedCountry = null;
                cities.clear();

                loadCountries(value!);
              },
            ),

            const SizedBox(height: 20),

            /// COUNTRY DROPDOWN
            if (selectedRegion != null)
              DropdownButtonFormField<String>(
                decoration: const InputDecoration(
                  labelText: "Country",
                  labelStyle: TextStyle(color: Colors.white),
                  border: OutlineInputBorder(),
                  filled: true,
                  fillColor: Color.fromARGB(88, 0, 0, 0),
                ),

                dropdownColor: const Color.fromARGB(173, 54, 71, 79),
                items: countries.map((c) => DropdownMenuItem(
                  value: c,
                  child: Text(c, style: const TextStyle(color: Colors.white)),
                )).toList(),
                onChanged: (value) {
                  selectedCountry = value;
                  loadCities(value!);
                },
              ),

            const SizedBox(height: 20),

            /// CITY DROPDOWN
            if (selectedCountry != null)
              DropdownButtonFormField<String>(
                decoration: const InputDecoration(
                  labelText: "City",
                  labelStyle: TextStyle(color: Colors.white),
                  border: OutlineInputBorder(),
                  filled: true,
                  fillColor: Color.fromARGB(88, 0, 0, 0),
                ),

                dropdownColor: const Color.fromARGB(173, 54, 71, 79),
                items: cities.map((city) => DropdownMenuItem(
                  value: city,
                  child: Text(city, style: const TextStyle(color: Colors.white)),
                )).toList(),
                onChanged: (city) {
                  Navigator.pop(context, city);
                },
              ),      
          ],
        ),
      ),
        ],
      ),
    );
  }
}