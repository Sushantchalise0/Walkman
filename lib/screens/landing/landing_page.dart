import 'dart:async';
import 'package:WalkmanMobile/screens/landing/start_walking/start_walking.dart';
import 'package:flutter/material.dart';
import 'package:flutter_secure_storage/flutter_secure_storage.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:provider/provider.dart';
import '../../provider/botton_click_provider.dart';
import '../../util/colors.dart';
import '../../util/styles.dart';
import '../../screens/landing/map_container.dart';

class LandingPage extends StatefulWidget {
  @override
  _LandingPageState createState() => _LandingPageState();
}

class _LandingPageState extends State<LandingPage> {
  FlutterSecureStorage _flutterSecureStorage = FlutterSecureStorage();

  @override
  void initState() {
    super.initState();
  }

  String elapsedTime = '00:00:00';

  deleteStorage() async {
    await _flutterSecureStorage.deleteAll();
  }

  @override
  void dispose() {
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      floatingActionButtonLocation: FloatingActionButtonLocation.centerFloat,
      floatingActionButton: Row(
        mainAxisAlignment: MainAxisAlignment.center,
        children: <Widget>[
          GestureDetector(
            onTap: () {
              Navigator.pushReplacement(context,
                  MaterialPageRoute(builder: (context) => Startwalking()));
            },
            child: Container(
              width: 150.0,
              height: 50.0,
              decoration: BoxDecoration(
                color: ThemeColor.darkGreen,
                borderRadius: BorderRadius.circular(30),
              ),
              child: Center(
                child: Text(
                  'Start Walking',
                  style: ThemeText.userNameText,
                ),
              ),
            ),
          ),
          SizedBox(width: 5.0),
          GestureDetector(
            onTap: () {
              Navigator.pushNamed(context, '/home');
            },
            child: Container(
              width: 150.0,
              height: 50.0,
              decoration: BoxDecoration(
                color: ThemeColor.darkGreen,
                borderRadius: BorderRadius.circular(30),
              ),
              child: Center(
                child: Text(
                  'Go to Home',
                  style: ThemeText.userNameText,
                ),
              ),
            ),
          ),
        ],
      ),
      body: SafeArea(
        child: Column(
          children: <Widget>[
            Container(
              child: Column(
                children: <Widget>[
                  SizedBox(height: 5.0),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: <Widget>[
                      Container(),
                      SvgPicture.asset(
                        'assets/images/walkman.svg',
                        height: 70.0,
                      ),
                    ],
                  ),
                ],
              ),
            ),
            Padding(
                padding: const EdgeInsets.all(8),
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: <Widget>[
                    const Padding(
                      padding: EdgeInsets.symmetric(horizontal: 4),
                      child: Text(
                        'Duration',
                        style: TextStyle(
                          fontSize: 17,
                          fontFamily: 'Helvetica',
                        ),
                      ),
                    ),
                    Padding(
                      padding: const EdgeInsets.symmetric(horizontal: 4),
                      child: Text(
                        elapsedTime,
                        style: TextStyle(
                            fontSize: 30,
                            fontFamily: 'Helvetica',
                            fontWeight: FontWeight.bold),
                      ),
                    ),
                  ],
                )),
            Container(
              child: Column(
                children: <Widget>[
                  SizedBox(height: 20.0),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceAround,
                    children: <Widget>[
                      Flexible(
                        child: Column(
                          children: <Widget>[
                            Text(
                              '0.00',
                              style: ThemeText.boldStepsCount,
                            ),
                            SizedBox(height: 4.0),
                            Text(
                              'Distance(KM)',
                              style: TextStyle(
                                color: Colors.black,
                                fontSize: 16.0,
                              ),
                            ),
                          ],
                        ),
                      ),
                      Flexible(
                        child: Column(
                          children: <Widget>[
                            Text(
                              '0',
                              style: ThemeText.boldStepsCount,
                            ),
                            SizedBox(height: 4.0),
                            Text(
                              'Green Coins',
                              style: TextStyle(
                                color: Colors.black,
                                fontSize: 16.0,
                              ),
                            ),
                          ],
                        ),
                      ),
                      Flexible(
                        child: Column(
                          children: <Widget>[
                            Text(
                              '00.00',
                              style: ThemeText.boldStepsCount,
                            ),
                            SizedBox(height: 4.0),
                            Text(
                              'steps/km',
                              style: TextStyle(
                                color: Colors.black,
                                fontSize: 16.0,
                              ),
                            ),
                          ],
                        ),
                      ),
                    ],
                  ),
                ],
              ),
            ),
            SizedBox(height: 20),
            MapContainer(),
          ],
        ),
      ),
    );
  }
}

Future<dynamic> myBackgroundMessageHandler(Map<String, dynamic> message) async {
  print(message);
}
