import 'package:flutter/material.dart';

class FavoriteProvider extends ChangeNotifier {
  final List<String> _favorites = [];

  List<String> get favorites => _favorites;

  bool isFavorite(String city) {
    return _favorites.contains(city);
  }

  void addFavorite(String city) {
    if (!_favorites.contains(city)) {
      _favorites.add(city);
      notifyListeners();
    }}

  void removeFavorite(String city) {
    _favorites.remove(city);
    notifyListeners(); }

  void updateFavorite(String oldName, String newName) {
    int index = _favorites.indexOf(oldName);
    if (index != -1) {
      _favorites[index] = newName;
      notifyListeners();} }
}
