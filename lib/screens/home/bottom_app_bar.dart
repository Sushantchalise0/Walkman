import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../../screens/home/bottom_navigation_bar_item.dart';
import '../../provider/bottom_navigation_bar.dart';

class BottomAppBarContainer extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    var provider = Provider.of<BottomNavigationBarProvider>(context);
    return BottomAppBar(
      child: Container(
        height: 62,
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: <Widget>[
            MyBottomNavigationBarItem(
              provider: provider,
              currentScreenIndex: 2,
              iconLocation: "assets/icons/shop.svg",
              iconType: 'svg',
              label: 'Shop',
            ),
            MyBottomNavigationBarItem(
              provider: provider,
              currentScreenIndex: 0,
              iconLocation: "assets/icons/dashboard.svg",
              iconType: 'svg',
              label: 'Dashboard',
            ),
            MyBottomNavigationBarItem(
              provider: provider,
              currentScreenIndex: 1,
              iconLocation: "assets/icons/leaderboard1.svg",
              iconType: 'svg',
              label: 'Leaderboard',
            ),
            MyBottomNavigationBarItem(
              provider: provider,
              currentScreenIndex: 3,
              iconLocation: "assets/icons/profile.svg",
              iconType: 'svg',
              label: 'Profile',
            )
          ],
        ),
      ),
    );
  }
}
