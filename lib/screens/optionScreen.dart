//this screen show two button -- start walking or go to home
import 'package:flutter/material.dart';

class SplashPage extends StatefulWidget {
  @override
  _SplashPageState createState() => _SplashPageState();
}

class _SplashPageState extends State<SplashPage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
        body: Column(
      children: [
        Image.asset(
          'assets/images/auth_banner.png',
          width: MediaQuery.of(context).size.width,
          fit: BoxFit.fill,
        ),
        RaisedButton(onPressed: null)
      ],
    ));
  }
}
