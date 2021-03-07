import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:provider/provider.dart';
import 'package:responsive_grid/responsive_grid.dart';
import 'package:WalkmanMobile/model/walkdeals.dart';
import 'package:WalkmanMobile/util/constant.dart';

class ViewAllGrid extends StatelessWidget {
  // final data;
  // ViewAllGrid({@required this.data});
  @override
  Widget build(BuildContext context) {
    List<Walkmandeals> walkmanDealList =
        Provider.of<List<Walkmandeals>>(context);
    return ResponsiveGridList(
      desiredItemWidth: 150,
      minSpacing: 10,
      children: [for (int i = 0; i < walkmanDealList.length; i++) {}].map(
        (i) {
          for (var index = 0; index <= walkmanDealList.length; index++) {
            return Container(
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(20.0),
              ),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: <Widget>[
                  SizedBox(
                    height: 15,
                  ),
                  GestureDetector(
                    onTap: () {
                      Navigator.pushNamed(context, '/resturant-details');
                    },
                    child: Container(
                      child: Stack(
                        children: <Widget>[
                          Container(
                            height: 175,
                            width: double.infinity,
                            decoration: BoxDecoration(
                              borderRadius: BorderRadius.circular(10.0),
                              image: DecorationImage(
                                image: NetworkImage(
                                    'https://peaceful-atoll-49860.herokuapp.com' +
                                        walkmanDealList[index].img),
                                fit: BoxFit.fill,
                              ),
                            ),
                          ),
                          Positioned(
                            bottom: 5,
                            right: 5,
                            child: Container(
                              height: 20,
                              width: 55,
                              color: Color(0xFF84BE2D),
                              child: Row(
                                mainAxisAlignment: MainAxisAlignment.center,
                                children: <Widget>[
                                  Icon(
                                    FontAwesomeIcons.coins,
                                    size: 15.0,
                                    color: Colors.white,
                                  ),
                                  SizedBox(
                                    width: 5.0,
                                  ),
                                  Text(
                                    '12g0',
                                    style: TextStyle(
                                      color: Colors.white,
                                      fontWeight: FontWeight.w500,
                                      fontSize: 14.0,
                                    ),
                                  ),
                                ],
                              ),
                            ),
                          ),
                        ],
                      ),
                    ),
                  ),
                  SizedBox(
                    height: 10.0,
                  ),
                  Text(
                    walkmanDealList[index].name,
                    overflow: TextOverflow.ellipsis,
                    style: ktitle,
                  ),
                  Row(
                    children: <Widget>[
                      Icon(
                        FontAwesomeIcons.mapMarkerAlt,
                        size: 10.0,
                        color: Colors.black87,
                      ),
                      SizedBox(width: 2.0),
                      Text(
                        walkmanDealList[index].vendorid,
                        overflow: TextOverflow.ellipsis,
                        style: ksubTitle,
                      ),
                    ],
                  ),
                  SizedBox(height: 2.5),
                  Row(
                    children: <Widget>[
                      Icon(
                        FontAwesomeIcons.utensils,
                        size: 10.0,
                        color: Colors.black54,
                      ),
                      SizedBox(width: 3.0),
                      Text(
                        walkmanDealList[index].ratings,
                        style: klightSubTitle,
                      ),
                    ],
                  ),
                  SizedBox(
                    height: 10,
                  ),
                ],
              ),
            );
          }
        },
      ).toList(),
    );
  }
}
