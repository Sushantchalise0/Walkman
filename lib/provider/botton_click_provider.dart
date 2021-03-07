import 'package:flutter/material.dart';

class BottonClickprovider extends ChangeNotifier {
  bool _isClick = false;
  bool _isbuttonClick = false;

  get isClick => _isClick;

  get isbuttonClick => _isbuttonClick;

  set isbuttonClick(bool buttonClick){
    _isbuttonClick = buttonClick;
    notifyListeners();
  }

  set isClick(bool click) {
    _isClick = click;
    notifyListeners();
  }
}