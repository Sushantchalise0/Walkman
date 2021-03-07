import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:responsive_grid/responsive_grid.dart';

class ALlVendorList extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Expanded(
      child: ResponsiveGridList(
          desiredItemWidth: 150,
          minSpacing: 10,
          children: [
            1,
            2,
            3,
            4,
            5,
            6,
            7,
          ].map((i) {
            return Card(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: <Widget>[
                  Container(
                    height: 200.0,
                    child: Stack(
                      children: <Widget>[
                        Image(
                          height: 200.0,
                          width: double.infinity,
                          fit: BoxFit.cover,
                          image: AssetImage('assets/images/deal1.jpg'),
                        ),
                        Positioned(
                          bottom: 5,
                          right: 5,
                          child: Container(
                            padding: EdgeInsets.symmetric(
                                vertical: 3.0, horizontal: 10.0),
                            decoration: BoxDecoration(
                              color: Colors.green,
                              borderRadius: BorderRadius.circular(10.0),
                            ),
                            child: Text(
                              '4.0',
                              style: TextStyle(
                                fontWeight: FontWeight.w700,
                                color: Colors.white,
                                fontSize: 13.0,
                              ),
                            ),
                          ),
                        ),
                      ],
                    ),
                  ),
                  SizedBox(
                    height: 5.0,
                  ),
                  Text(
                    'Fuji Bakery',
                    overflow: TextOverflow.ellipsis,
                    style: TextStyle(
                      fontWeight: FontWeight.w400,
                      fontSize: 18,
                    ),
                  ),
                  SizedBox(height: 2.0),
                  Row(
                    children: <Widget>[
                      Icon(
                        FontAwesomeIcons.mapMarkerAlt,
                        size: 10.0,
                        color: Colors.black87,
                      ),
                      SizedBox(width: 2.0),
                      Text(
                        'Patan Dhoka Road, Patan',
                        style: TextStyle(
                          color: Colors.black87,
                          fontSize: 12.0,
                        ),
                      ),
                    ],
                  ),
                  Row(
                    children: <Widget>[
                      Icon(
                        FontAwesomeIcons.utensils,
                        size: 10.0,
                        color: Colors.black54,
                      ),
                      SizedBox(width: 3.0),
                      Text(
                        'desserts',
                        style: TextStyle(
                          color: Colors.black54,
                          fontSize: 12.0,
                        ),
                      ),
                    ],
                  ),
                  SizedBox(
                    height: 2.0,
                  ),
                  Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 3.0),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: <Widget>[
                        Text(
                          'Open Now',
                          style: TextStyle(
                            fontSize: 14.0,
                            fontWeight: FontWeight.bold,
                            color: Theme.of(context).primaryColor,
                          ),
                        ),
                        Text('0.2km'),
                      ],
                    ),
                  ),
                  SizedBox(
                    height: 8.0,
                  ),
                ],
              ),
            );
          }).toList()),
    );
  }
}
