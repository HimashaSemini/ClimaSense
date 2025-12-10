import '../../data/models/search_result_model.dart';
import '../../data/repository/search_repository.dart';

class SearchService {
  final SearchRepository _repository = SearchRepository();

  /// Search for cities matching the query
  Future<List<SearchResultModel>> searchCities(String query) async {
    return await _repository.searchCities(query);
  }
}
