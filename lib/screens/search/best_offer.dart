import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:WalkmanMobile/util/colors.dart';

class BestOffer extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: EdgeInsets.symmetric(horizontal: 10.0),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: <Widget>[
          SizedBox(
            height: 20.0,
          ),
          Text(
            'Best offers',
            style: TextStyle(
              fontSize: 20.0,
              fontWeight: FontWeight.w600,
              color: Colors.black87,
            ),
          ),
          Text(
            'grab the offers before it gets cold',
            style: TextStyle(
              fontSize: 13.0,
              fontWeight: FontWeight.w500,
              color: Colors.black54,
            ),
          ),
          SizedBox(
            height: 10.0,
          ),
          GestureDetector(
            onTap: () {
              // Navigator.pushNamed(context, '/offers');
            },
            child: Stack(
              children: <Widget>[
                Container(
                  height: 150.0,
                  width: double.infinity,
                  decoration: BoxDecoration(
//                    borderRadius: BorderRadius.circular(8.0),
                    // border: Border.all(
                    //   color: Colors.black26,
                    //   width: 1.3,
                    // ),
                    image: DecorationImage(
                      image: AssetImage('assets/images/offer_banner.png'),
                      fit: BoxFit.fill,
                    ),
                  ),
                ),
                Positioned(
                  bottom: 5,
                  right: 5,
                  child: Container(
                    decoration: BoxDecoration(
                      color: ThemeColor.lightGreen,
                      borderRadius: BorderRadius.circular(5.0),
                    ),
                    padding:
                        EdgeInsets.symmetric(vertical: 5.0, horizontal: 10.0),
                    child: GestureDetector(
                      onTap: () {
                        Navigator.pushNamed(context, '/offers');
                      },
                      child: Row(
                        children: <Widget>[
                          Text(
                            'View offers',
                            style: TextStyle(
                              color: Colors.white,
                              fontSize: 14.0,
                              fontWeight: FontWeight.w600,
                            ),
                          ),
                          SizedBox(
                            width: 5.0,
                          ),
                          Icon(
                            FontAwesomeIcons.arrowRight,
                            size: 12.0,
                            color: Colors.white,
                          )
                        ],
                      ),
                    ),
                  ),
                )
              ],
            ),
          ),
          SizedBox(
            height: 35.0,
          ),
        ],
      ),
    );
  }
}
