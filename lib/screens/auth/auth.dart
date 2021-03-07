import 'package:WalkmanMobile/screens/auth/facebookLogin.dart';
import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'dart:async';
import 'package:modal_progress_hud/modal_progress_hud.dart';
import 'package:toast/toast.dart';
import 'package:WalkmanMobile/screens/auth/googlesignin.dart';
import './auth_button.dart';
import 'package:WalkmanMobile/screens/landing/landing_page.dart';

class Auth extends StatefulWidget {
  @override
  _AuthState createState() => _AuthState();
}

class _AuthState extends State<Auth> {
  bool showLoading = false;
  var _width = 250.0;

  @override
  void initState() {
    super.initState();
    Timer(
      Duration(milliseconds: 500),
      () => {
        setState(() {
          _width = MediaQuery.of(context).size.width;
        }),
      },
    );
  }

  @override
  Widget build(BuildContext context) {
    double height = MediaQuery.of(context).size.height;
    double width = MediaQuery.of(context).size.width;
    return Scaffold(
      backgroundColor: Colors.white,
      body: ModalProgressHUD(
        inAsyncCall: showLoading,
        color: Colors.grey,
        offset: Offset(width * 0.45, height - 100.0),
        progressIndicator: CircularProgressIndicator(
          valueColor: AlwaysStoppedAnimation<Color>(
            Theme.of(context).primaryColor.withOpacity(0.5),
          ),
        ),
        child: Center(
          child: SingleChildScrollView(
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: <Widget>[
                AnimatedContainer(
                  curve: Curves.bounceOut,
                  duration: Duration(
                    seconds: 1,
                  ),
                  width: _width,
                  child: Image.asset(
                    'assets/images/auth_banner.png',
                    width: MediaQuery.of(context).size.width,
                    fit: BoxFit.fill,
                  ),
                ),
                SizedBox(
                  height: 50.0,
                ),
                AuthButton(
                  color: Color(0xFFCA3737),
                  icon: FontAwesomeIcons.google,
                  label: 'Continue with Google',
                  onPressed: () async {
                    setState(() {
                      showLoading = true;
                    });
                    await signInWithGoogle().then((value) {
                      setState(() {
                        showLoading = false;
                      });
                      if (value == true) {
                        Navigator.pushReplacementNamed(context, "/home");
                      } else {
                        Toast.show('Error logging in. Try Again!', context);
                      }
                    });
                  },
                ),
                SizedBox(
                  height: 10.0,
                ),
                AuthButton(
                  color: Color(0xFF4267B2),
                  icon: FontAwesomeIcons.facebook,
                  label: 'Continue with Facebook',
                  onPressed: () async {
                    setState(() {
                      showLoading = true;
                    });
                    login().then((value) {
                      setState(() {
                        showLoading = false;
                      });
                      if (value == 0) {
                        Navigator.pushReplacementNamed(context, "/home");
                      } else {
                        Toast.show('Error logging in. Try Again!', context);
                      }
                    });
                  },
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
