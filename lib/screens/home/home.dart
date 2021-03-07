import 'package:WalkmanMobile/screens/landing/start_walking/start_walking.dart';
import 'package:flutter/material.dart';
import 'package:animations/animations.dart';
import 'package:flutter/services.dart';
import 'package:provider/provider.dart';
import '../../screens/home/bottom_app_bar.dart';
import '../dashboard/dashboard.dart';
import '../leaderboard/leaderboard.dart';
import '../profile/profile.dart';
import '../search/shop.dart';
import '../../provider/bottom_navigation_bar.dart';

class Home extends StatefulWidget {
  @override
  _HomeState createState() => _HomeState();
}

class _HomeState extends State<Home> {
  final List<Widget> _screens = [
    Dashboard(),
    Leaderboard(),
    Search(),
    Profile(),
  ];
  @override
  Widget build(BuildContext context) {
    var provider = Provider.of<BottomNavigationBarProvider>(context);
    return WillPopScope(
      onWillPop: () => _willPopContainer(context),
      child: Scaffold(
        body: PageTransitionSwitcher(
          transitionBuilder: (child, primaryAnimation, secondaryAnimation) {
            return FadeThroughTransition(
              animation: primaryAnimation,
              secondaryAnimation: secondaryAnimation,
              child: child,
            );
          },
          child: _screens[provider.currentIndex],
        ),
        // floatingActionButton: FloatingActionButton(
        //   backgroundColor: Theme.of(context).primaryColor,
        //   child: Icon(Icons.directions_walk),
        //   onPressed: () {
        //     Navigator.push(context,
        //         MaterialPageRoute(builder: (context) => Startwalking()));
        //   },
        // ),
        // floatingActionButtonLocation: FloatingActionButtonLocation.centerDocked,
        bottomNavigationBar: BottomAppBarContainer(),
      ),
    );
  }

  _willPopContainer(context) {
    showModal<bool>(
      configuration: FadeScaleTransitionConfiguration(),
      context: context,
      builder: (c) => AlertDialog(
        title: Text(
          'Do you want to exit the Walkman app?',
          maxLines: 2,
        ),
        actions: [
          FlatButton(
            padding: EdgeInsets.symmetric(horizontal: 15.0),
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(18.0),
            ),
            child: Text('Yes'),
            onPressed: () => SystemNavigator.pop(),
          ),
          FlatButton(
            padding: EdgeInsets.symmetric(horizontal: 15.0),
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(18.0),
            ),
            child: Text(
              'No',
            ),
            onPressed: () => Navigator.pop(c, false),
          ),
        ],
      ),
    );
  }
}
