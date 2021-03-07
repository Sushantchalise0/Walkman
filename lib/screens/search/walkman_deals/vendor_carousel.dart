import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:WalkmanMobile/model/vendor.dart';
import 'package:WalkmanMobile/screens/search/walkman_deals/vendor_detail.dart';
import 'package:WalkmanMobile/util/constant.dart';

class VendorCarousel extends StatelessWidget {
  final title;
  final String subTitle;
  final List<Vendor> vendorList;

  const VendorCarousel(
      {Key key,
      @required this.title,
      @required this.subTitle,
      @required this.vendorList})
      : super(key: key);

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
          child: vendorList!= null ? ListView.builder(
            scrollDirection: Axis.horizontal,
            itemCount: vendorList.length,
            shrinkWrap: true,
            itemBuilder: (BuildContext context, int index) {
              Vendor vendors= vendorList[index];
              return VendorContainer(
                vendor: vendors,
              );
            },
          ): Center(
            child: CircularProgressIndicator(),
          ),
        )
      ],
    );
  }
}

class VendorContainer extends StatelessWidget {
  final Vendor vendor;

  const VendorContainer({Key key, @required this.vendor}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () {
        Navigator.push(context,
            MaterialPageRoute(builder: (context)=> VendorDealsDetails(vendorList: vendor,)));
      },
      child: Padding(
        padding: EdgeInsets.only(left: 8.0),
        child: Container(
          width: 200,
          decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(18.0),
          ),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: <Widget>[
              Container(
                child: Stack(
                  children: <Widget>[
                    Container(
                      height: 180,
                      width: 200,
                      decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(18.0),
                        // border: Border.all(
                        //   color: Colors.black26,
                        //   width: 1.3,
                        // ),
                        image: DecorationImage(
                          image: vendor.vendorIc == ''
                              ?AssetImage('assets/images/deals_fries.png')
                              : CachedNetworkImageProvider(
                              'https://peaceful-atoll-49860.herokuapp.com'+vendor.vendorIc
                          )
                        
                        )
                      ),
                      // child: Image.asset('assets/images/deals_fries.png'),
                    ),
                  ],
                ),
              ),
              SizedBox(
                height: 5.0,
              ),
              Text(
                vendor.vendorName,
                overflow: TextOverflow.ellipsis,
                style: ktitle,
              ),
              SizedBox(height: 2.5),
              Row(
                children: <Widget>[
                  SizedBox(width: 3.0),
                  Text(
                    vendor.vendorAddress,
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
