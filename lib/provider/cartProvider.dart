import 'package:flutter/foundation.dart';
import 'package:WalkmanMobile/model/walkdeals.dart';

class CartProvider extends ChangeNotifier {
  List<Walkmandeals> _cartList = [];

  List<Walkmandeals> get cartList => _cartList;

  setcartList(Walkmandeals newCartItem) {
    _cartList.add(newCartItem);
    notifyListeners();
  }

  removeCartItem(int index) {
    _cartList.removeAt(index);
    notifyListeners();
  }
}