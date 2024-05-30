import 'package:flutter/material.dart';

class SearchProvider extends ChangeNotifier {
  String? searchText = 'general';

  void searchQuery(String query) {
    query.isEmpty ? 'general' : searchText = query;
    notifyListeners();
  }

  void resetSearch() {
    searchText = 'general';
    notifyListeners();
  }
}
