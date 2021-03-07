import 'package:flutter/material.dart';
import 'package:WalkmanMobile/model/vendor.dart';
import 'package:WalkmanMobile/model/walkdeals.dart';
import 'package:WalkmanMobile/screens/search/walkman_deals/vendor_carousel.dart';
import 'package:WalkmanMobile/screens/search/walkman_deals/walkmandeals_carousel.dart';
import 'search_invite_banner.dart';
import 'search_quick_search.dart';
import 'search_appbar.dart';
import 'package:provider/provider.dart';

class Search extends StatefulWidget {
  @override
  _SearchState createState() => _SearchState();
}

class _SearchState extends State<Search> {
  @override
  Widget build(BuildContext context) {
    List<Vendor> _vendorList = Provider.of<List<Vendor>>(context);
    List<Walkmandeals> walkdealsList = Provider.of<List<Walkmandeals>>(context);
    return GestureDetector(
      onTap: () {
        FocusScope.of(context).requestFocus(new FocusNode());
      },
      child: Scaffold(
        body: CustomScrollView(
          slivers: <Widget>[
            SearchAppbar(),
            SliverToBoxAdapter(
              child: Padding(
                padding: const EdgeInsets.only(left: 5.0),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: <Widget>[
                    QuickSearch(),
                    InviteBanner(),
                    VendorCarousel(
                      title: 'WalkMan Partners',
                      subTitle: 'Green Partners and their products',
                      vendorList: _vendorList,
                    ),
                    WalkmanDealCarousel(
                        isDeal: true,
                        title: 'Walkman Deals',
                        subTitle: 'Get best deals here on resturants',
                        walkmanDeals: walkdealsList),
                    WalkmanDealCarousel(
                        isDeal: false,
                        title: 'Trending this week',
                        subTitle: 'Grab the offers before it gets cold',
                        walkmanDeals: walkdealsList),
                  ],
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
