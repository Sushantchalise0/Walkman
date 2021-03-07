import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:provider/provider.dart';
import 'package:WalkmanMobile/model/category.dart';

class AllVendorsGrid extends StatelessWidget {
  // final data;
  // AllVendorsGrid({@required this.data});
  @override
  Widget build(BuildContext context) {
  List<Category> categoryList= Provider.of<List<Category>>(context);
    return Expanded(
      child: Padding(
        padding: EdgeInsets.symmetric(horizontal: 2.0),
        child: OrientationBuilder(
          builder: (BuildContext context, Orientation orientation) {
            return GridView.builder(
              itemCount: categoryList.length,
              gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                crossAxisCount: (orientation == Orientation.portrait) ? 2 : 3,
                childAspectRatio: (orientation == Orientation.portrait)
                    ? MediaQuery.of(context).size.width /
                        (MediaQuery.of(context).size.height / 0.95)
                    : MediaQuery.of(context).size.width / 900.0,
              ),
              itemBuilder: (BuildContext context, int index) {
                return Card(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: <Widget>[
                      Container(
                        height: 200.0,
                        child: Stack(
                          children: <Widget>[
                            // Image(
                            //   height: 200.0,
                            //   fit: BoxFit.cover,
                            //   image: NetworkImage(
                            //     'https://static8.depositphotos.com/1000504/899/i/450/depositphotos_8993908-stock-photo-chocolate-cake-slice.jpg',
                            //   ),
                            // ),
                            Image.network('https://peaceful-atoll-49860.herokuapp.com'+categoryList[index].img,
                            fit: BoxFit.cover,height: 200,),
//                            FadeInImage.assetNetwork(
//                              height: 200,
//                              fit: BoxFit.cover,
//                              placeholder: 'assets/images/loading.gif',
//                              image:
//                                  "https://static8.depositphotos.com/1000504/899/i/450/depositphotos_8993908-stock-photo-chocolate-cake-slice.jpg",
//                            ),
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
                                  '48.0',
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
                        categoryList[index].catName,
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
                            categoryList[index].id,
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
                            categoryList[index].catName,
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
                    ],
                  ),
                );
              },
            );
          },
        ),
      ),
    );
  }
}
