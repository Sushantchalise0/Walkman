import 'dart:async';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:WalkmanMobile/provider/walking/start_walking_provider.dart';

class Startwalking extends StatefulWidget {
  @override
  _StartwalkingState createState() => _StartwalkingState();
}

class _StartwalkingState extends State<Startwalking> {
  int time = 0;
  @override
  void initState() {
    super.initState();
    Timer.periodic(Duration(seconds: 1), (t) {
      var startWalking =
          Provider.of<StartWalkingProvider>(context, listen: false);
      startWalking.decCounter();
      if (startWalking.getRemainingcounter() == 0) {
        Navigator.pushNamed(context, '/walking');
      }
      startWalking.getRemainingcounter() < 1
          ? t.cancel()
          : startWalking.getRemainingcounter();
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[
            Consumer<StartWalkingProvider>(
              builder: (context, data, child) {
                return Text(
                  data.getRemainingcounter()?.toString() ?? '',
                  style: TextStyle(
                    color: Colors.black,
                    fontSize: 44.0,
                    fontWeight: FontWeight.bold,
                  ),
                );
              },
            ),
            SizedBox(height: 16.0),
          ],
        ),
      ),
    );
  }
}
