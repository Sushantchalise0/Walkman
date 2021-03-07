import 'dart:convert';
import 'package:flutter_secure_storage/flutter_secure_storage.dart';
import 'package:health/health.dart';
import 'package:http/http.dart' as http;

class SetProgress {
  FlutterSecureStorage _flutterSecureStorage = FlutterSecureStorage();
  Future setProgress() async {
    try {
      String detail = await _flutterSecureStorage.read(key: 'detail');
      String startTime = await _flutterSecureStorage.read(key: 'startTime');
      int stepCount = 0;

      List<HealthDataPoint> _healthDataList = [];

      HealthFactory health = HealthFactory();

      List<HealthDataType> types = [HealthDataType.STEPS];

      bool accessWasGranted = await health.requestAuthorization(types);

      if (accessWasGranted) {
        try {
          List<HealthDataPoint> healthData =
              await health.getHealthDataFromTypes(
                  DateTime.fromMillisecondsSinceEpoch(1612310400000),
                  DateTime.now(),
                  types);
          _healthDataList.addAll(healthData);
          _healthDataList = HealthFactory.removeDuplicates(_healthDataList);

          for (var i = 0; i < _healthDataList.length; i++) {
            stepCount = stepCount + _healthDataList[i].value;
          }

          Map<String, dynamic> requestBody = {
            "detail": detail,
            "start_time": int.parse(startTime),
            "end_time": DateTime.now().millisecondsSinceEpoch,
            "distance": stepCount
          };
          final response = await http
              .post(
                  'https://peaceful-atoll-49860.herokuapp.com/progresses/setProgress',
                  headers: {
                    'Accept': 'application/json',
                    'Content-Type': 'application/json',
                  },
                  body: jsonEncode(requestBody))
              .timeout(Duration(seconds: 20));
          if (response.statusCode == 200) {
            print(response.body);
            return true;
          } else {
            return false;
          }
        } catch (e) {}
      } else {}
    } catch (e) {
      return false;
    }
  }
}
