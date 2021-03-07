import 'package:flutter/material.dart';

class MyPageRouteBuilder {
  final Widget screen;
  MyPageRouteBuilder({@required this.screen});

  PageRouteBuilder buildPageRoute() {
    return PageRouteBuilder(
      // transitionDuration: Duration(milliseconds: 200),
      pageBuilder: (_, __, ___) => screen,
      transitionsBuilder: (_, anim, __, child) {
        var begin = Offset(0.0, 1.0);
        var end = Offset.zero;
        var curve = Curves.ease;

        var tween = Tween(begin: begin, end: end).chain(
          CurveTween(curve: curve),
        );

        return SlideTransition(
          position: anim.drive(tween),
          child: child,
        );
      },
    );
  }
}
