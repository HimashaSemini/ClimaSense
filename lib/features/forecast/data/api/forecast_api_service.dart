import 'dart:convert';
import 'package:http/http.dart' as http;

import '../../../../core/utils/constants.dart';
import '../models/forecast_model.dart';

class ForecastApiService {
  Future<ForecastModel?> fetchForecast(double lat, double lon) async {
    final url =
        "https://api.openweathermap.org/data/2.5/forecast?lat=$lat&lon=$lon&units=metric&appid=$kOpenWeatherApiKey";

    final response = await http.get(Uri.parse(url));

    if (response.statusCode != 200) return null;

    final data = jsonDecode(response.body);
    return ForecastModel.fromJson(data);
  }
}
