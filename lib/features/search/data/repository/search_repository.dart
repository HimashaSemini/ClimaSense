import '../api/search_api_service.dart';
import '../models/search_result_model.dart';

class SearchRepository {
  final SearchApiService _apiService = SearchApiService();

  /// Search cities matching the query
  Future<List<SearchResultModel>> searchCities(String query) async {
    return await _apiService.searchCities(query);
  }
}
