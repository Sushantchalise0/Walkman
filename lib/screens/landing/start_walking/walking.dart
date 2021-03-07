import 'dart:async';
import 'package:WalkmanMobile/services/setProgress.dart';
import 'package:flutter/material.dart';
import 'package:flutter_secure_storage/flutter_secure_storage.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:stop_watch_timer/stop_watch_timer.dart';
import 'package:toast/toast.dart';
import '../../../screens/landing/map_container.dart';
import '../../../util/styles.dart';

class Walking extends StatefulWidget {
  @override
  _WalkingState createState() => _WalkingState();
}

class _WalkingState extends State<Walking> {
  FlutterSecureStorage _flutterSecureStorage = FlutterSecureStorage();
  bool isPaused = false;
  final StopWatchTimer _stopWatchTimer = StopWatchTimer(
    isLapHours: true,
    onChange: (value) => print('onChange $value'),
    onChangeRawSecond: (value) => print('onChangeRawSecond $value'),
    onChangeRawMinute: (value) => print('onChangeRawMinute $value'),
  );

  Stopwatch watch = Stopwatch();
  Timer timer;
  bool startStop = true;

  String elapsedTime = '00:00:00';

  updateTime(Timer timer) {
    if (watch.isRunning) {
      setState(() {
        elapsedTime = transformMilliSeconds(watch.elapsedMilliseconds);
      });
    }
  }

  startOrStop() {
    if (startStop) {
      startWatch();
    } else {
      stopWatch();
    }
  }

  startWatch() {
    setState(() {
      startStop = false;
      watch.start();
      timer = Timer.periodic(Duration(milliseconds: 100), updateTime);
    });
  }

  stopWatch() {
    setState(() {
      startStop = true;
      watch.stop();
      setTime();
    });
  }

  setTime() {
    var timeSoFar = watch.elapsedMilliseconds;
    setState(() {
      elapsedTime = transformMilliSeconds(timeSoFar);
    });
  }

  transformMilliSeconds(int milliseconds) {
    int hundreds = (milliseconds / 10).truncate();
    int seconds = (hundreds / 100).truncate();
    int minutes = (seconds / 60).truncate();
    int hours = (minutes / 60).truncate();

    String hoursStr = (hours % 60).toString().padLeft(2, '0');
    String minutesStr = (minutes % 60).toString().padLeft(2, '0');
    String secondsStr = (seconds % 60).toString().padLeft(2, '0');

    return "$hoursStr:$minutesStr:$secondsStr";
  }

  @override
  void initState() {
    super.initState();
    loadStorage();
    startOrStop();
  }

  loadStorage() async {
    await _flutterSecureStorage.write(
        key: 'startTime',
        value: DateTime.now().millisecondsSinceEpoch.toString());
    await _flutterSecureStorage.write(key: 'totalCoins', value: '0');
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      floatingActionButtonLocation: FloatingActionButtonLocation.centerFloat,
      floatingActionButton: GestureDetector(
        onTap: () {
          _finishedMessage(context);
        },
        child: Container(
          width: 150.0,
          height: 50.0,
          padding: EdgeInsets.symmetric(horizontal: 30),
          decoration: BoxDecoration(
              color: Color(0xFFD53A52),
              borderRadius: BorderRadius.circular(12)),
          child: Center(
            child: Text(
              'FINISH',
              style: ThemeText.userNameText,
            ),
          ),
        ),
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
              padding: const EdgeInsets.only(bottom: 0),
              child: StreamBuilder<int>(
                stream: _stopWatchTimer.secondTime,
                initialData: _stopWatchTimer.secondTime.value,
                builder: (context, snap) {
                  return Column(
                    children: <Widget>[
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
                                padding:
                                    const EdgeInsets.symmetric(horizontal: 4),
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
                    ],
                  );
                },
              ),
            ),
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
            MapContainer(),
          ],
        ),
      ),
    );
  }

  void _finishedMessage(context) {
    showGeneralDialog(
      barrierColor: Colors.black.withOpacity(0.5),
      transitionBuilder: (context, a1, a2, widget) {
        return Transform.scale(
          scale: a1.value,
          child: Opacity(
            opacity: a1.value,
            child: AlertDialog(
              shape:
                  OutlineInputBorder(borderRadius: BorderRadius.circular(16.0)),
              title: Text('Save Activity'),
              content: Text(
                  'Are you sure want to stop walking and save your activity?'),
              actions: [
                FlatButton(
                    onPressed: () async {
                      startOrStop();
                      showDialog(
                          context: context,
                          barrierDismissible: false,
                          builder: (context) => AlertDialog(
                                content: new Container(
                                    child: Row(
                                  children: <Widget>[
                                    new CircularProgressIndicator(
                                      strokeWidth: 3.0,
                                      backgroundColor:
                                          Theme.of(context).primaryColor,
                                      valueColor:
                                          new AlwaysStoppedAnimation<Color>(
                                              Colors.white),
                                    ),
                                    new Container(
                                        margin: EdgeInsets.only(left: 20.0),
                                        child: Text("Please Wait..."))
                                  ],
                                )),
                              ));
                      FlutterSecureStorage _storage = FlutterSecureStorage();
                      await _storage.write(
                          key: 'endTime',
                          value:
                              DateTime.now().millisecondsSinceEpoch.toString());

                      SetProgress _setProgress = SetProgress();
                      await _setProgress.setProgress().then((value) {
                        if (value == true) {
                          Navigator.pushNamed(context, '/home');
                        } else {
                          Toast.show('Error sending your data', context);
                        }
                      });
                    },
                    child: Text('Yes')),
                FlatButton(
                    onPressed: () {
                      Navigator.pop(context);
                    },
                    child: Text(
                      'No',
                    )),
              ],
            ),
          ),
        );
      },
      transitionDuration: Duration(milliseconds: 200),
      barrierDismissible: true,
      barrierLabel: '',
      context: context,
      pageBuilder: (context, animation1, animation2) {
        return null;
      },
    );
  }
}
