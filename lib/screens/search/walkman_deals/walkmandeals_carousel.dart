import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:WalkmanMobile/model/walkdeals.dart';
import 'package:WalkmanMobile/screens/search/walkman_deals/resturant_deals_details.dart';
import 'package:WalkmanMobile/util/constant.dart';

class WalkmanDealCarousel extends StatelessWidget {
  final bool isDeal;
  final String title;
  final String subTitle;
  final List<Walkmandeals> walkmanDeals;

  const WalkmanDealCarousel({
    Key key,
    @required this.title,
    @required this.subTitle,
    @required this.walkmanDeals,
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
              child: walkmanDeals != null
                  ? ListView.builder(
                      scrollDirection: Axis.horizontal,
                      itemCount: walkmanDeals.length > 6 ? walkmanDeals.length ~/ 2 : walkmanDeals.length,
                      shrinkWrap: true,
                      itemBuilder: (BuildContext context, int index) {
                        Walkmandeals walkmanDeal = walkmanDeals[index];
                        return WalkmanDealContainer(
                          isDeal: isDeal,
                          walkmandeals: walkmanDeal,
                        );
                      },
                    )
                  : Center(child: CircularProgressIndicator()),
            ))
      ],
    );
  }
}

class WalkmanDealContainer extends StatelessWidget {
  const WalkmanDealContainer({
    Key key,
    @required this.isDeal,
    @required this.walkmandeals,
  }) : super(key: key);

  final bool isDeal;
  final Walkmandeals walkmandeals;

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () {
        Navigator.push(
            context,
            MaterialPageRoute(
                builder: (context) =>
                    ResturantDealsDetails(walkmandeals: walkmandeals)));
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
                        borderRadius: BorderRadius.only(
                            topLeft: Radius.circular(16),
                            topRight: Radius.circular(16)),
                        image: DecorationImage(
                          image: walkmandeals.img == ""
                              ? AssetImage('assets/images/deals_fries.png')
                              : CachedNetworkImageProvider(
                                  'https://peaceful-atoll-49860.herokuapp.com' +
                                      walkmandeals.img,
                                ),
                          fit: BoxFit.fill,
                        ),
                      ),
                    ),
                    isDeal
                        ? Positioned(
                            right: 5,
                            top: 5,
                            child: Container(
                              padding: EdgeInsets.symmetric(
                                  horizontal: 8, vertical: 4),
                              decoration: BoxDecoration(
                                  color: Color(0xFF84BE2D),
                                  borderRadius: BorderRadius.circular(4)),
                              child: Text(
                                'Deal',
                                style: TextStyle(
                                  color: Colors.white,
                                  fontWeight: FontWeight.w800,
                                  fontSize: 12.5,
                                ),
                              ),
                            ),
                          )
                        : Text(''),
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
                              walkmandeals.coins ?? '0',
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
              SizedBox(
                height: 10.0,
              ),
              Text(
                walkmandeals.name,
                overflow: TextOverflow.ellipsis,
                style: ktitle,
              ),
              Row(
                children: <Widget>[
                  Icon(
                    FontAwesomeIcons.tag,
                    size: 10.0,
                    color: Colors.black87,
                  ),
                  SizedBox(width: 2.0),
                  Text(
                    walkmandeals.actprice,
                    style: ksubTitle,
                  ),
                ],
              ),
              SizedBox(height: 2.5),
            ],
          ),
        ),
      ),
    );
  }
}
