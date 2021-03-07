import 'dart:async';
import 'dart:convert';
import 'package:flutter/foundation.dart';
import 'package:http/http.dart' as http;
import 'package:shared_preferences/shared_preferences.dart';
import 'package:WalkmanMobile/model/billingModel.dart';

class BillingAddressProvider extends ChangeNotifier {
  Future<BillingModel> getBillingAddress() async {
    SharedPreferences _sharedPreferences =
        await SharedPreferences.getInstance();
    try {
      final http.Response response = await http.get(
          'https://peaceful-atoll-49860.herokuapp.com/billing?detail=5fdc7307b1e85f0017117393'
          // _sharedPreferences.getString('id')
          );
      if (response.statusCode == 200) {
        BillingModel model = BillingModel.fromJson(json.decode(response.body));
        return model;
      }
    } catch (e) {
      return null;
    }
  }

  Future<bool> setBillingAddress(String id, String fullName, String phoneNumber,
      String province, String city, String address) async {
    SharedPreferences _sharedPreferences =
        await SharedPreferences.getInstance();
    try {
      final http.Response response = await http.post(
          'https://peacefull-atoll-49860.herokuapp.com/Billing/setAddress',
          body: {
            'id': id,
            'detail': _sharedPreferences.getString('id'),
            'fullName': fullName,
            'phoneNumber': phoneNumber,
            'province': province,
            'city': city,
            'address': address
          }).timeout(Duration(seconds: 15), onTimeout: () {
        throw TimeoutException('Error Saving Billing Address');
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

  Future<bool> updateBillingAddress(String fullName, String phoneNumber,
      String province, String city, String address) async {
    SharedPreferences _sharedPreferences =
        await SharedPreferences.getInstance();
    try {
      final http.Response response = await http.post(
          'https://peaceful-atoll-49860.herokuapp.com/Billing/updateAddress',
          body: {
            'detail': _sharedPreferences.getString('id'),
            'fullName': fullName,
            'phoneNumber': phoneNumber,
            'province': province,
            'city': city,
            'address': address
          }).timeout(Duration(seconds: 15), onTimeout: () {
        throw TimeoutException('Error Saving Billing Address');
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
