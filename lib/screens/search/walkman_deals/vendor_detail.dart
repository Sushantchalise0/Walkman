import 'package:WalkmanMobile/services/vendorProducts.dart';
import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:flutter_rating_bar/flutter_rating_bar.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:provider/provider.dart';
import 'package:WalkmanMobile/model/vendor.dart';
import 'package:WalkmanMobile/model/walkdeals.dart';
import 'package:WalkmanMobile/screens/search/walkman_deals/walkmandeals_carousel.dart';
import '../../../util/colors.dart';
import '../../../util/styles.dart';

class VendorDealsDetails extends StatefulWidget {
  final Vendor vendorList;
  VendorDealsDetails({@required this.vendorList});

  @override
  _VendorDealsDetailsState createState() => _VendorDealsDetailsState();
}

class _VendorDealsDetailsState extends State<VendorDealsDetails> {
  VendorProductsServices _vendorProductsServices = VendorProductsServices();
  @override
  Widget build(BuildContext context) {
    final TextStyle textStyle = TextStyle(
      color: Colors.white,
    );
//    final provider = Provider.of<BottonClickprovider>(context);
    List<Walkmandeals> walkdealsList = Provider.of<List<Walkmandeals>>(context);

    return Scaffold(
      body: SingleChildScrollView(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: <Widget>[
            _dealsHeader(context, textStyle),
            _itemDetails(context),
            Divider(
              thickness: 2.0,
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              children: [
                CircleAvatar(
                  child: Icon(
                    Icons.call,
                  ),
                  backgroundColor: ThemeColor.greyWhite,
                  foregroundColor: ThemeColor.darkGrey,
                ),
                CircleAvatar(
                  child: Icon(FontAwesomeIcons.facebookF),
                  backgroundColor: ThemeColor.greyWhite,
                  foregroundColor: ThemeColor.darkGrey,
                ),
                CircleAvatar(
                  child: Icon(FontAwesomeIcons.google),
                  backgroundColor: ThemeColor.greyWhite,
                  foregroundColor: ThemeColor.darkGrey,
                ),
                CircleAvatar(
                  child: Icon(FontAwesomeIcons.instagram),
                  backgroundColor: ThemeColor.greyWhite,
                  foregroundColor: ThemeColor.darkGrey,
                ),
                CircleAvatar(
                  child: Icon(FontAwesomeIcons.shareAlt),
                  backgroundColor: ThemeColor.greyWhite,
                  foregroundColor: ThemeColor.darkGrey,
                ),
              ],
            ),
            Divider(
              thickness: 2.0,
            ),
            FutureBuilder(
                future: _vendorProductsServices
                    .getWalkmanDeals(widget.vendorList.id),
                builder: (context, snapshot) {
                  if (!snapshot.hasData) {
                    return Center(child: CircularProgressIndicator());
                  }
                  if (snapshot.hasError) {
                    return Center(child: Text('Error Loading Vendor Products'));
                  }
                  return WalkmanDealCarousel(
                    title: 'Products',
                    subTitle: 'Grab the offers before it gets cold',
                    walkmanDeals: snapshot.data,
                    isDeal: false,
                  );
                }),
            _info(context),
          ],
        ),
      ),
    );
  }

  Widget _dealsHeader(context, textStyle) {
    return Stack(
      children: <Widget>[
        Container(
          width: double.infinity,
          child: Hero(
            tag: 'resturant-img',
            child: CachedNetworkImage(
              imageUrl: 'https://peaceful-atoll-49860.herokuapp.com' +
                  widget.vendorList.vendorIc,
              fit: BoxFit.cover,
              placeholder: (context, url) =>
                  Center(child: Center(child: CircularProgressIndicator())),
              errorWidget: (context, url, error) => Icon(Icons.error),
            ),
          ),
        ),
        Positioned(
          top: 30.0,
          left: 15.0,
          child: GestureDetector(
            onTap: () => Navigator.pop(context),
            child: Icon(
              Icons.arrow_back,
              color: Colors.white,
            ),
          ),
        ),
        Align(
          child: Padding(
            padding: const EdgeInsets.only(top: 120.0, left: 10.0, right: 10.0),
            child: Row(
              mainAxisSize: MainAxisSize.max,
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: <Widget>[
                GestureDetector(
                  onTap: () {},
                  child: Container(
                    height: 24,
                    width: 30,
                    color: Colors.grey.withOpacity(0.5),
                    child: Icon(
                      Icons.arrow_back_ios,
                      size: 16.0,
                    ),
                  ),
                ),
                GestureDetector(
                  onTap: () {},
                  child: Container(
                    height: 24,
                    width: 30,
                    color: Colors.grey.withOpacity(0.5),
                    child: Icon(
                      Icons.arrow_forward_ios,
                      size: 16.0,
                    ),
                  ),
                )
              ],
            ),
          ),
        ),
      ],
    );
  }

  Widget _itemDetails(context) {
    return Column(
      children: <Widget>[
        SizedBox(height: 12.0),
        Text(
          widget.vendorList.vendorName,
          style: ThemeText.titleStyle,
        ),
        SizedBox(height: 12.0),
        _price(context),
      ],
    );
  }

  Widget _starRating(context) {
    return Container(
      width: MediaQuery.of(context).size.width,
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceAround,
        children: <Widget>[
          Container(
            height: 1.0,
            width: 30.0,
            color: Colors.grey,
          ),
          RatingBar(
            initialRating: 3,
            minRating: 1,
            direction: Axis.horizontal,
            allowHalfRating: true,
            itemCount: 5,
            itemPadding: EdgeInsets.symmetric(horizontal: 0.0),
            onRatingUpdate: (rating) {
              print(rating);
            },
            ratingWidget: null,
          ),
          Container(
            height: 25.0,
            width: 35.0,
            decoration: BoxDecoration(
              color: ThemeColor.lightGreen,
              borderRadius: BorderRadius.all(
                Radius.circular(10.0),
              ),
            ),
            child: Center(
              child: Text('4.0'),
            ),
          ),
          Container(
            height: 1.0,
            width: 30.0,
            color: Colors.grey,
          ),
        ],
      ),
    );
  }

  Widget _price(context) {
    return Container(
      child: Column(
        children: <Widget>[
          Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: <Widget>[
              Text(
                '${widget.vendorList.vendorAddress}  ',
                style: TextStyle(fontWeight: FontWeight.w400, fontSize: 16),
              ),
            ],
          ),
        ],
      ),
    );
  }

  Widget _description(context) {
    return Padding(
      padding: const EdgeInsets.only(left: 20.0),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: <Widget>[
          SizedBox(height: 20.0),
          Text(
            'Description',
            style: ThemeText.infoTitle,
          ),
          Padding(
            padding: const EdgeInsets.only(left: 14.0),
            child: Text(
              widget.vendorList.longitude,
              style: ThemeText.subTitle,
            ),
          )
        ],
      ),
    );
  }

  Widget _info(context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: <Widget>[
        SizedBox(height: 20.0),
        Container(
          child: Divider(
            thickness: 2.0,
          ),
        ),
        Padding(
          padding: const EdgeInsets.only(left: 20, top: 10.0, right: 20),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: <Widget>[
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Text(
                    'Location',
                    style: TextStyle(color: Colors.grey, fontSize: 16),
                  ),
                  Text(
                    widget.vendorList.vendorAddress,
                    style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold),
                  ),
                ],
              ),
              ClipRRect(
                borderRadius: BorderRadius.circular(12),
                child: Container(
                  height: 300,
                  child: GoogleMap(
                      initialCameraPosition: CameraPosition(
                          target: LatLng(
                              double.parse(widget.vendorList.lattitude),
                              double.parse(widget.vendorList.longitude)),
                          zoom: 12)),
                ),
              )
            ],
          ),
        )
      ],
    );
  }

  Widget _infoDesc(String title, String subTitle) {
    return Padding(
      padding: const EdgeInsets.only(bottom: 8.0),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: <Widget>[
          Text(
            title,
            style: ThemeText.subTitle,
          ),
          Padding(
            padding: const EdgeInsets.only(left: 10.0),
            child: Text(subTitle),
          )
        ],
      ),
    );
  }

  void _showDialogContainer(context, provider) {
    showGeneralDialog(
      barrierColor: Colors.white.withOpacity(0.75),
      transitionBuilder: (context, a1, a2, widget) {
        return Transform.scale(
          scale: a1.value,
          child: Opacity(
            opacity: a1.value,
            child: Column(
              mainAxisSize: MainAxisSize.max,
              mainAxisAlignment: MainAxisAlignment.end,
              children: <Widget>[
                Container(
                  decoration: BoxDecoration(
                    color: Colors.white.withOpacity(0.8),
                    border: Border.all(
                      color: Colors.black,
                    ),
                  ),
                  width: MediaQuery.of(context).size.width,
                  height: 130,
                  child: Column(
                    children: <Widget>[
                      Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: <Widget>[
                          Text(
                            '?',
                            style: ThemeText.subTitle,
                          ),
                        ],
                      ),
                      SizedBox(height: 10.0),
                      Padding(
                        padding: const EdgeInsets.only(left: 20.0),
                        child: Row(
                          children: <Widget>[
                            Container(
                              height: 25.0,
                              width: 25.0,
                              decoration: BoxDecoration(
                                // color: Colors.red,
                                borderRadius: BorderRadius.all(
                                  Radius.circular(50.0),
                                ),
                                border: Border.all(color: ThemeColor.darkGreen),
                              ),
                              child: Icon(
                                Icons.check,
                                size: 16.0,
                                color: ThemeColor.darkGreen,
                              ),
                            ),
                            SizedBox(width: 16.0),
                            GestureDetector(
                              onTap: () {
                                print(provider.isClick);
                                provider.isClick = !provider.isClick;
                                print(provider.isClick);
                                Navigator.pop(context);
                              },
                              child: Text(
                                'Yes, Right now',
                                style: ThemeText.subTitle,
                              ),
                            ),
                          ],
                        ),
                      ),
                      SizedBox(height: 16.0),
                      Padding(
                        padding: const EdgeInsets.only(left: 20.0),
                        child: Row(
                          children: <Widget>[
                            Container(
                              height: 25.0,
                              width: 25.0,
                              decoration: BoxDecoration(
                                color: Colors.red,
                                borderRadius: BorderRadius.all(
                                  Radius.circular(50.0),
                                ),
                                // border: Border.all(color: ThemeColor.darkGreen),
                              ),
                              child: Icon(
                                Icons.clear,
                                size: 16.0,
                                color: ThemeColor.whiteColor,
                              ),
                            ),
                            SizedBox(width: 16.0),
                            GestureDetector(
                              onTap: () {
                                Navigator.pop(context);
                              },
                              child: Text(
                                'I am Having Second Thoughts',
                                style: ThemeText.subTitle,
                              ),
                            ),
                          ],
                        ),
                      ),
                    ],
                  ),
                ),
                SizedBox(height: 4),
              ],
            ),
          ),
        );
      },
      transitionDuration: Duration(milliseconds: 200),
      barrierDismissible: true,
      barrierLabel: '',
      context: context,
      pageBuilder: (context, animation1, animation2) {
        return null;
      },
    );
  }

  Widget _qrCode(context) {
    return Padding(
      padding: const EdgeInsets.only(left: 20.0),
      child: Column(
        // mainAxisAlignment: MainAxisAlignment.start,
        crossAxisAlignment: CrossAxisAlignment.start,
        children: <Widget>[
          // SizedBox(height: 20.0),
          Padding(
            padding: const EdgeInsets.only(left: 20, right: 20),
            child: Divider(
              color: Colors.grey[900],
            ),
          ),
          Text(
            'QR Code',
            style: ThemeText.infoTitle,
          ),
          Center(
            child: Image.asset(
              'assets/images/qr_code.png',
              height: 180.0,
            ),
          ),
          Padding(
            padding: const EdgeInsets.only(left: 20, right: 20),
            child: Divider(
              color: Colors.grey[900],
            ),
          ),
        ],
      ),
    );
  }
}
