import 'dart:async';

import 'package:flutter/foundation.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:http/http.dart' as http;

class CartService extends ChangeNotifier {
  List<String> _productID = [];

  List<String> get productID => _productID;

  void addProduct(String productID) {
    _productID.add(productID);
  }

  Future<bool> getCartData() async {
    SharedPreferences _sharedPreferences =
        await SharedPreferences.getInstance();
    try {
      final response = await http
          .get(
        'http://peaceful-atoll-49860.herokuapp.com/cart?detail=' +
            _sharedPreferences.getString('id'),
      )
          .timeout(Duration(seconds: 15), onTimeout: () {
        throw TimeoutException('Error Getting Cart');
      });
      if (response.statusCode == 200) {
        return true;
      } else {
        return false;
      }
    } catch (e) {
      return false;
    }
  }

  Future<bool> addToCart() async {
    SharedPreferences _sharedPreferences =
        await SharedPreferences.getInstance();
    try {
      final response = await http.post(
          'https://peaceful-atoll-49860.herokuapp.com/Cart/addToCart',
          body: {
            "detail": _sharedPreferences.getString('id'),
            "productID": _productID
          }).timeout(Duration(seconds: 15), onTimeout: () {
        throw TimeoutException('Error Adding Cart');
      });
      if (response.statusCode == 200) {
        return true;
      } else {
        return false;
      }
    } catch (e) {
      return false;
    }
  }
}
