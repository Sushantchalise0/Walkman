import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:provider/provider.dart';
import 'package:WalkmanMobile/model/walkdeals.dart';
import 'package:WalkmanMobile/screens/search/walkman_deals/resturant_deals_details.dart';
import 'package:WalkmanMobile/util/constant.dart';

class AllGrid extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    List<Walkmandeals> walkmanDealList =
        Provider.of<List<Walkmandeals>>(context);

    return Padding(
      padding: EdgeInsets.all(8.0),
      child: OrientationBuilder(
          builder: (BuildContext context, Orientation orientation) {
        return GridView.builder(
          itemCount: walkmanDealList.length,
          gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
            crossAxisSpacing: 10,
            crossAxisCount: (orientation == Orientation.portrait) ? 2 : 3,
            childAspectRatio: (orientation == Orientation.portrait)
                ? MediaQuery.of(context).size.width *
                    1.3 /
                    (MediaQuery.of(context).size.height / 1)
                : MediaQuery.of(context).size.width / 900.0,
          ),
          itemBuilder: (BuildContext context, int index) {
            return GestureDetector(
              onTap: () {
                Navigator.push(
                    context,
                    MaterialPageRoute(
                        builder: (context) => ResturantDealsDetails(
                            walkmandeals: walkmanDealList[index])));
              },
              child: Container(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Container(
                      child: Padding(
                        padding: EdgeInsets.only(left: 2.0),
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: <Widget>[
                            SizedBox(
                              height: 15,
                            ),
                            Container(
                              child: Stack(
                                children: <Widget>[
                                  ClipRRect(
                                    borderRadius: BorderRadius.only(
                                        topLeft: Radius.circular(10),
                                        topRight: Radius.circular(10)),
                                    child: CachedNetworkImage(
                                      height: 160,
                                      width: double.infinity,
                                      imageUrl:
                                          'https://peaceful-atoll-49860.herokuapp.com' +
                                              walkmanDealList[index].img,
                                      fit: BoxFit.fill,
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
                                        mainAxisAlignment:
                                            MainAxisAlignment.center,
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
                                            walkmanDealList[index].coins,
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
                              walkmanDealList[index].name,
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
                                Flexible(
                                  child: Text(
                                    walkmanDealList[index].actprice,
                                    overflow: TextOverflow.ellipsis,
                                    style: ksubTitle,
                                  ),
                                ),
                              ],
                            ),
                            SizedBox(height: 2.5),
                            Row(
                              children: <Widget>[
                                Icon(
                                  FontAwesomeIcons.tag,
                                  size: 10.0,
                                  color: Colors.black54,
                                ),
                                SizedBox(width: 3.0),
                                Text(
                                  walkmanDealList[index].discprice,
                                  style: klightSubTitle,
                                ),
                              ],
                            ),
                            Row(
                              children: <Widget>[
                                Icon(
                                  FontAwesomeIcons.idBadge,
                                  size: 10.0,
                                  color: Colors.black54,
                                ),
                                SizedBox(width: 3.0),
                                // Flexible(
                                //   child: Text(
                                //     walkmanDealList[index].vendorid,
                                //     overflow: TextOverflow.ellipsis,
                                //     style: klightSubTitle,
                                //   ),
                                // ),
                              ],
                            ),
                          ],
                        ),
                      ),
                    )
                  ],
                ),
              ),
            );
          },
        );
      }),
    );
  }
}
