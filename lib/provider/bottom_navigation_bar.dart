import 'package:flutter/material.dart';

class BottomNavigationBarProvider with ChangeNotifier {
  int _currentIndex = 2;

  get currentIndex => _currentIndex;

  set currentIndex(int index) {
    _currentIndex = index;
    notifyListeners();
  }
}
