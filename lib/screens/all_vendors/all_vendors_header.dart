import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:WalkmanMobile/screens/all_vendors/filter_chip.dart';

class AllVendorHeader extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Container(
      height: 210.0,
      color: Theme.of(context).primaryColor,
      child: Column(
        children: <Widget>[
          SizedBox(
            height: 14.0,
          ),
          Padding(
            padding: EdgeInsets.symmetric(vertical: 8.0),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceAround,
              children: <Widget>[
                GestureDetector(
                  onTap: () => Navigator.pop(context),
                  child: Icon(
                    FontAwesomeIcons.times,
                    color: Colors.white,
                  ),
                ),
                  Container(
                    height: 35.0,
                    width: 250.0,
                    decoration: BoxDecoration(
                      color: Colors.white,
                      borderRadius: BorderRadius.circular(12),
                    ),
                    child: TextField(
                      decoration: InputDecoration(
                          contentPadding: EdgeInsets.all(2.0),
                          border: OutlineInputBorder(
                            borderSide: BorderSide(color: Colors.grey),
                            borderRadius: BorderRadius.circular(12.0),
                          ),
                          focusedBorder: OutlineInputBorder(
                            borderSide: BorderSide(color: Colors.grey),
                            borderRadius: BorderRadius.circular(12.0),
                          ),
                          prefixIcon: Icon(
                            FontAwesomeIcons.search,
                            color: Colors.black54,
                            size: 22,
                          ),
                          suffixIcon: Icon(
                            FontAwesomeIcons.solidTimesCircle,
                            color: Colors.black54,
                            size: 18,
                          ),
                          hintText: 'Lunch'),
                    ),
                  ),
                  GestureDetector(
                    onTap: () {},
                    child: Icon(
                      FontAwesomeIcons.map,
                      color: Colors.white,
                      size: 30.0,
                    ),
                  ),
                ],
              ),
            ),
            Container(
              height: 35.0,
              width: 250.0,
              decoration: BoxDecoration(
                color: Colors.white,
                borderRadius: BorderRadius.circular(12),
              ),
              child: TextField(
                decoration: InputDecoration(
                    contentPadding: EdgeInsets.all(2.0),
                    border: OutlineInputBorder(
                      borderSide: BorderSide(color: Colors.grey),
                      borderRadius: BorderRadius.circular(12.0),
                    ),
                    focusedBorder: OutlineInputBorder(
                      borderSide: BorderSide(color: Colors.grey),
                      borderRadius: BorderRadius.circular(12.0),
                    ),
                    prefixIcon: Icon(
                      FontAwesomeIcons.search,
                      color: Colors.black54,
                      size: 22,
                    ),
                    suffixIcon: Icon(
                      FontAwesomeIcons.solidTimesCircle,
                      color: Colors.black54,
                      size: 18,
                    ),
                    hintText: 'Near me'),
              ),
            ),
            SizedBox(
              height: 10.0,
            ),
            Container(
              alignment: Alignment.center,
              height: 35.0,
              child: ListView(
                padding: EdgeInsets.symmetric(horizontal: 5.0),
                scrollDirection: Axis.horizontal,
                children: <Widget>[
                  MyFilterChip(label: 'Open Now'),
                  MyFilterChip(label: 'Others'),
                  MyFilterChip(label: 'Nearest'),
                  MyFilterChip(label: 'Rated 3+'),
                  MyFilterChip(label: 'Deals'),
                ],
              ),
            ),
            // Row(
            //   mainAxisAlignment: MainAxisAlignment.spaceBetween,
            //   children: <Widget>[
            //     MyFilterChip(label: 'Open Now'),
            //     MyFilterChip(label: 'Others'),
            //     MyFilterChip(label: 'Nearest'),
            //     MyFilterChip(label: 'Rated 3+'),
            //     MyFilterChip(label: 'Deals'),
            //   ],
            // ),
            // SizedBox(
            //   height: 10.0,
            // ),
          ],
        ),
      );
    
  }
}
