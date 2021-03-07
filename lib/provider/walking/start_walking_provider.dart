import 'package:flutter/material.dart';

class StartWalkingProvider extends ChangeNotifier {
  int _counter = 4;

  int getRemainingcounter() => _counter;

  void decCounter() {
    _counter == 0 ? _counter = 3 : _counter--;
    // _counter--;
    notifyListeners();
  }
}
