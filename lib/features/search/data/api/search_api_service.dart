import 'dart:convert';
import 'package:http/http.dart' as http;
import '../models/search_result_model.dart';
import '../../../../core/utils/constants.dart';

class SearchApiService {

  Future<List<SearchResultModel>> searchCities(String query) async {
    final url =
        'https://api.openweathermap.org/data/2.5/find?q=$query&type=like&appid=$kOpenWeatherApiKey';
    final response = await http.get(Uri.parse(url));

    if (response.statusCode == 200) {
      final data = jsonDecode(response.body);
      final List list = data['list'];
      return list.map((e) => SearchResultModel.fromJson(e)).toList();
    } else {
      throw Exception('Failed to search cities');
    }
  }
}
