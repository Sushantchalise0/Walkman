import 'dart:convert';

import 'package:WalkmanMobile/model/dashBoardModel.dart';
import 'package:flutter_secure_storage/flutter_secure_storage.dart';
import 'package:http/http.dart' as http;

class DashBoardService {
  FlutterSecureStorage _flutterSecureStorage = FlutterSecureStorage();

  Future getDashBoard() async {
    String detail = await _flutterSecureStorage.read(key: 'detail');
    try {
      final response = await http.post(
          'https://peaceful-atoll-49860.herokuapp.com/progresses/getProgress',
          body: {'detail': detail});
      return json.decode(response.body);
    } catch (e) {
      print(e);
    }
  }
}
