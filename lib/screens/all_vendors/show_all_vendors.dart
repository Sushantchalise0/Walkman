import 'package:flutter/material.dart';
import 'package:WalkmanMobile/screens/all_vendors/all_vendors_grid.dart';
import 'package:WalkmanMobile/screens/all_vendors/all_vendors_header.dart';

class ShowAllVendors extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        body: Column(
          children: <Widget>[
            AllVendorHeader(),
            AllVendorsGrid(),
          ],
        ),
      ),
    );
  }
}
