import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:flutter_secure_storage/flutter_secure_storage.dart';
import 'package:health/health.dart';
import './screens/auth/auth.dart';
import 'package:location/location.dart';
import 'package:toast/toast.dart';
import 'package:http/http.dart' as http;
import 'dart:io';

class LoaderPage extends StatefulWidget {
  @override
  _LoaderPageState createState() => _LoaderPageState();
}

class _LoaderPageState extends State<LoaderPage> {
  FlutterSecureStorage _flutterSecureStorage = FlutterSecureStorage();
  Location location = new Location();

  @override
  void initState() {
    loadStorage();
    super.initState();
  }

  String lastUpdated;

  // permissionStatus() async {
  //   bool _serviceEnabled;

  //   _serviceEnabled = await location.serviceEnabled();

  //   if (_serviceEnabled == true) {
  //     PermissionStatus isPermissionEnabled = await location.requestPermission();
  //     if (isPermissionEnabled == PermissionStatus.granted) {
  //       return;
  //     } else if (isPermissionEnabled == PermissionStatus.denied) {
  //       permissionStatus();
  //     } else if (isPermissionEnabled == PermissionStatus.deniedForever) {
  //       Toast.show("Permission Denied Forever! We will not track you.", context,
  //           duration: Toast.LENGTH_LONG, gravity: Toast.BOTTOM);
  //     }
  //     return;
  //   }

  //   await location.requestService();

  //   _serviceEnabled = await location.serviceEnabled();

  //   await location.enableBackgroundMode(enable: false);

  //   if (_serviceEnabled == true) {
  //     PermissionStatus isPermissionEnabled = await location.requestPermission();
  //     if (isPermissionEnabled == PermissionStatus.granted) {
  //       return;
  //     } else {
  //       permissionStatus();
  //     }
  //     return;
  //   }

  //   if (_serviceEnabled == false) {
  //     permissionStatus();
  //   }
  // }

  int todayStep = 0;

  loadStorage() async {
    try {
      final String name = await _flutterSecureStorage.read(key: 'displayName');
      final String detail = await _flutterSecureStorage.read(key: 'detail');
      final String email = await _flutterSecureStorage.read(key: 'email');

      if (name != null && email != null && detail != null) {
        print(detail);
        await http
            .get("https://peaceful-atoll-49860.herokuapp.com/viewTime?detail=" +
                detail)
            .then((value) async {
          if (value.statusCode == HttpStatus.created) {
            var response = json.decode(value.body);
            lastUpdated = response["last_updated"];

            HealthFactory health = HealthFactory();

            List<HealthDataType> types = [HealthDataType.STEPS];

            bool accessWasGranted = await health.requestAuthorization(types);

            if (accessWasGranted) {
              await health
                  .getHealthDataFromTypes(
                      DateTime(
                          DateTime.fromMillisecondsSinceEpoch(
                                  int.parse(lastUpdated))
                              .year,
                          DateTime.fromMillisecondsSinceEpoch(
                                  int.parse(lastUpdated))
                              .month,
                          DateTime.fromMillisecondsSinceEpoch(
                                  int.parse(lastUpdated))
                              .day),
                      DateTime.now(),
                      types)
                  .then((value) async {
                int finalData = 0;
                for (var i = 0; i < value.length; i++) {
                  finalData = finalData + value[i].value;
                }
                todayStep = finalData;
                Map<String, dynamic> requestBody = {
                  "detail": detail,
                  "distance": todayStep
                };
                await http
                    .post(
                        'https://peaceful-atoll-49860.herokuapp.com/progresses/setProgress',
                        headers: {
                          'Accept': 'application/json',
                          'Content-Type': 'application/json',
                        },
                        body: jsonEncode(requestBody))
                    .timeout(Duration(seconds: 20));
                Navigator.pushReplacementNamed(context, "/home");
              });
            }
          } else {}
        }).catchError((e) {
          print(e);
          Navigator.pushAndRemoveUntil(
              context,
              MaterialPageRoute(builder: (context) => Auth()),
              (route) => false);
        });
      } else {
        Navigator.pushAndRemoveUntil(context,
            MaterialPageRoute(builder: (context) => Auth()), (route) => false);
      }
    } catch (e) {
      print(e);
      Toast.show(
          "Error getting your data. Make sure you have google fit installed.",
          context,
          duration: Toast.LENGTH_LONG,
          gravity: Toast.BOTTOM);
      Navigator.pushAndRemoveUntil(context,
          MaterialPageRoute(builder: (context) => Auth()), (route) => false);
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(child: CircularProgressIndicator()),
    );
  }
}
