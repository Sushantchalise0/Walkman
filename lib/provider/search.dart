import 'package:flutter/material.dart';

class SearchProvider with ChangeNotifier {
  String _currentQuery;

  get currentQuery => _currentQuery;

  set currentQuery(String query) {
    _currentQuery = query;
    notifyListeners();
  }
}