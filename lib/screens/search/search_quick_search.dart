import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:WalkmanMobile/model/category.dart';
import 'package:WalkmanMobile/services/categorylist_services.dart';
import 'package:WalkmanMobile/util/constant.dart';

class QuickSearch extends StatefulWidget {
  @override
  _QuickSearchState createState() => _QuickSearchState();
}

class _QuickSearchState extends State<QuickSearch> {
  CategoryListServices categoryListServices = CategoryListServices();

  @override
  Widget build(BuildContext context) {
    List<Category> _categoryList = Provider.of<List<Category>>(context);

    return Container(
      padding: EdgeInsets.symmetric(vertical: 20.0, horizontal: 4.0),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: <Widget>[
          Text(
            'Quick Searches',
            style: kheading,
          ),
          Text(
            'Discover types of meals and resturants',
            style: ksubHeading,
          ),
          Container(
            margin: EdgeInsets.only(top: 10.0),
            height: 100.0,
            child: _categoryList != null
                ? ListView.builder(
                    scrollDirection: Axis.horizontal,
                    itemCount: _categoryList.length,
                    itemBuilder: (BuildContext context, int index) {
                      return GestureDetector(
                        onTap: () =>
                            Navigator.pushNamed(context, '/show-all-vendors'),
                        child: Padding(
                          padding: EdgeInsets.symmetric(
                              vertical: 8.0, horizontal: 16.0),
                          child: Column(
                            children: <Widget>[
                              Container(
                                height: 50.0,
                                width: 50.0,
                                child: CachedNetworkImage(
                                  imageUrl:
                                      'https://peaceful-atoll-49860.herokuapp.com' +
                                          _categoryList[index].img,
                                  placeholder: (context, url) => Center(
                                      child: CircularProgressIndicator()),
                                  errorWidget: (context, url, error) =>
                                      Icon(Icons.error),
                                ),
                              ),
                              SizedBox(height: 10.0),
                              Text(_categoryList[index].catName)
                            ],
                          ),
                        ),
                      );
                    },
                  )
                : Center(
                    child: CircularProgressIndicator(),
                  ),
          )
        ],
      ),
    );
  }
}
