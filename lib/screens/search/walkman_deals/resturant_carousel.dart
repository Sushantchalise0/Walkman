import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:WalkmanMobile/model/resturant.dart';
import 'package:WalkmanMobile/util/constant.dart';

class ResturantCarousel extends StatelessWidget {
  final bool isDeal;
  final String title;
  final String subTitle;
  final List<Resturant> resturants;

  const ResturantCarousel({
    Key key,
    @required this.title,
    @required this.subTitle,
    @required this.resturants,
    this.isDeal,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: <Widget>[
        SizedBox(
          height: 30.0,
        ),
        Padding(
          padding: EdgeInsets.symmetric(horizontal: 10.0),
          child: Text(
            title,
            style: kheading,
          ),
        ),
        Padding(
          padding: EdgeInsets.symmetric(horizontal: 10.0),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: <Widget>[
              Text(
                subTitle,
                style: ksubHeading,
              ),
              GestureDetector(
                onTap: () {
                  Navigator.pushNamed(context, '/view-all');
                },
                child: Text(
                  'View all',
                  style: TextStyle(color: Theme.of(context).primaryColor),
                ),
              )
            ],
          ),
        ),
        SizedBox(height: 10.0),
        Container(
            height: 250.0,
            child: Container(
              height: 250.0,
              child: resturants.length == null
                  ? CircularProgressIndicator()
                  : ListView.builder(
                      scrollDirection: Axis.horizontal,
                      itemCount: resturants.length,
                      shrinkWrap: true,
                      itemBuilder: (BuildContext context, int index) {
                        Resturant resturant = resturants[index];
                        return ResturantContainer(
                          isDeal: isDeal,
                          resturant: resturant,
                        );
                      },
                    ),
            ))
      ],
    );
  }
}

class ResturantContainer extends StatelessWidget {
  const ResturantContainer({
    Key key,
    @required this.isDeal,
    @required this.resturant,
  }) : super(key: key);

  final bool isDeal;
  final Resturant resturant;

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () {
        // Navigator.pushNamed(context, '/resturant-details');
      },
      child: Padding(
        padding: EdgeInsets.only(left: 8.0),
        child: Container(
          width: 205,
          decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(12.0),
          ),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: <Widget>[
              Container(
                child: Stack(
                  children: <Widget>[
                    Container(
                      height: 175,
                      width: 200,
                      decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(18.0),
                        // border: Border.all(
                        //   color: Colors.black26,
                        //   width: 1.3,
                        // ),
                        image: DecorationImage(
                          image: resturant.imgUrl == ""
                              ? AssetImage('assets/images/deals_fries.png')
                              : NetworkImage(
                                  resturant.imgUrl,
                                ),
                          fit: BoxFit.fill,
                        ),
                      ),
                      // child: Image.asset('assets/images/deals_fries.png'),
                    ),
                    isDeal
                        ? Positioned(
                            bottom: 5,
                            left: 5,
                            child: Text(
                              'Offers walkman deals',
                              style: TextStyle(
                                color: Colors.white,
                                fontWeight: FontWeight.w800,
                                fontSize: 12.5,
                              ),
                            ),
                          )
                        : Text(''),
                    isDeal
                        ? Positioned(
                            bottom: 5,
                            right: 5,
                            child: Container(
                              height: 20,
                              width: 55,
                              decoration: BoxDecoration(
                                  color: Color(0xFF84BE2D),
                                  borderRadius: BorderRadius.circular(10.0)),
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
                                    '120',
                                    style: TextStyle(
                                      color: Colors.white,
                                      fontWeight: FontWeight.w500,
                                      fontSize: 14.0,
                                    ),
                                  ),
                                ],
                              ),
                            ),
                          )
                        : Text(''),
                  ],
                ),
              ),
              SizedBox(
                height: 10.0,
              ),
              Text(
                resturant.name,
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
                    resturant.location,
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
                    resturant.foodAvailabel,
                    style: klightSubTitle,
                  ),
                ],
              ),
            ],
          ),
        ),
      ),
    );
  }
}
