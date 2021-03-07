import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';

class Vendorall extends StatefulWidget {
  @override
  _VendorallState createState() => _VendorallState();
}

class _VendorallState extends State<Vendorall> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        titleSpacing: 0.0,
        title: Container(
          height: 35.0,
          margin: EdgeInsets.only(right: 12.0),
          padding: EdgeInsets.only(left: 0),
          decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(20.0),
            color: Colors.white,
          ),
          child: TextField(
            decoration: InputDecoration(
                contentPadding: EdgeInsets.all(5.0),
                // border: InputBorder.none,
                border: OutlineInputBorder(
                  borderSide: BorderSide(color: Colors.grey),
                  borderRadius: BorderRadius.circular(20.0),
                ),
                focusedBorder: OutlineInputBorder(
                  borderSide: BorderSide(color: Colors.grey),
                  borderRadius: BorderRadius.circular(20.0),
                ),
                prefixIcon: Icon(
                  Icons.search,
                  color: Colors.black54,
                  size: 25,
                ),
                suffix: Icon(
                  FontAwesomeIcons.solidTimesCircle,
                  color: Colors.white60,
                  size: 18,
                ),
                hintText: 'Search here'),
          ),
        ),
      ),
    );
  }
}
