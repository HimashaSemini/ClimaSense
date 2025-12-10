import 'package:flutter/material.dart';
import '../../data/models/search_result_model.dart';
import '../../data/api/search_api_service.dart';

class SearchProvider extends ChangeNotifier {
  final SearchApiService _apiService = SearchApiService();

  List<SearchResultModel> _searchResults = [];
  List<SearchResultModel> get searchResults => _searchResults;

  bool _isLoading = false;
  bool get isLoading => _isLoading;

  String? _errorMessage;
  String? get errorMessage => _errorMessage;

  Future<void> searchCities(String query) async {
    if (query.isEmpty) {
      _searchResults = [];
      notifyListeners();
      return;
    }

    _isLoading = true;
    _errorMessage = null;
    notifyListeners();

    try {
      _searchResults = await _apiService.searchCities(query);
    } catch (e) {
      _errorMessage = e.toString();
    }

    _isLoading = false;
    notifyListeners();
  }

  void clearResults() {
    _searchResults = [];
    notifyListeners();
  }
}
