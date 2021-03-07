import 'dart:convert';
import 'package:WalkmanMobile/model/stepCountodel.dart';
import 'package:flutter_secure_storage/flutter_secure_storage.dart';
import 'package:http/http.dart' as http;

class StepCount {
  Future<StepCountModel> getStepCount() async {
    try {
      FlutterSecureStorage _flutterSecureStorage = FlutterSecureStorage();
      String detail = await _flutterSecureStorage.read(key: 'detail');

      final response = await http.post(
          'https://peaceful-atoll-49860.herokuapp.com/userProfile',
          body: {'detail': detail},
          headers: {'Content-Type': 'application/x-www-form-urlencoded'});
      print(response.body);

      return StepCountModel.fromJson(json.decode(response.body));
    } catch (e) {}
  }
}
