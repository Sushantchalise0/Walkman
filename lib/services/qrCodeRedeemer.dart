import 'dart:async';
import 'dart:io';
import 'package:WalkmanMobile/util/constant.dart';
import 'package:flutter/foundation.dart';
import 'package:http/http.dart' as http;

class QRCodeRedeemer extends ChangeNotifier {
  Future getData() async {
    try {
      print(apiEndPoint);
      final response = await http.post(
           apiEndPoint +'/redeem/set',
          headers: {
            'Content-Type': 'application/x-www-form-urlencoded'
          }).timeout(Duration(seconds: 10), onTimeout: () {
        throw TimeoutException(
            'The connection has timed out, Please try again!');
      });
      if (response.statusCode == HttpStatus.ok) {
      } else {}
    } catch (e) {}
  }
}