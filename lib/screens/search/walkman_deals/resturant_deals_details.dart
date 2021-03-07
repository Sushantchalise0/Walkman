import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:flutter_rating_bar/flutter_rating_bar.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:provider/provider.dart';
import 'package:toast/toast.dart';
import 'package:WalkmanMobile/model/walkdeals.dart';
import 'package:WalkmanMobile/provider/botton_click_provider.dart';
import 'package:WalkmanMobile/provider/cartProvider.dart';
import 'package:WalkmanMobile/services/cart.dart';
import '../../../util/colors.dart';
import '../../../util/styles.dart';
import 'package:qr_flutter/qr_flutter.dart';

class ResturantDealsDetails extends StatefulWidget {
  final Walkmandeals walkmandeals;
  ResturantDealsDetails({@required this.walkmandeals});

  @override
  _ResturantDealsDetailsState createState() => _ResturantDealsDetailsState();
}

class _ResturantDealsDetailsState extends State<ResturantDealsDetails> {
  double rating = 3.0;
  @override
  Widget build(BuildContext context) {
    final TextStyle textStyle = TextStyle(color: Colors.white);
    final provider = Provider.of<BottonClickprovider>(context);

    return Scaffold(
      body: SingleChildScrollView(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: <Widget>[
            _dealsHeader(context, textStyle),
            _itemDetails(context),
            _description(context),
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 10),
              child: Divider(
                color: Colors.grey[900],
              ),
            ),
            provider.isClick == false ? SizedBox() : _qrCode(context),
            Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: <Widget>[
                SizedBox(height: 20.0),
                Padding(
                  padding:
                      const EdgeInsets.only(left: 20, top: 10.0, right: 20),
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
                            'New Baneshwor',
                            style: TextStyle(
                                fontSize: 16, fontWeight: FontWeight.bold),
                          ),
                        ],
                      ),
                      ClipRRect(
                        borderRadius: BorderRadius.circular(12),
                        child: Container(
                          height: 300,
                          child: GoogleMap(
                              initialCameraPosition: CameraPosition(
                                  target: LatLng(double.parse('27.343'),
                                      double.parse('85.344243')),
                                  zoom: 12)),
                        ),
                      )
                    ],
                  ),
                )
              ],
            ),
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
                  widget.walkmandeals.img,
              width: MediaQuery.of(context).size.width,
              height: 400,
              fit: BoxFit.fill,
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
            padding: const EdgeInsets.only(top: 230.0, left: 10.0, right: 10.0),
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
          widget.walkmandeals.name,
          style: ThemeText.titleStyle,
        ),
        SizedBox(height: 12.0),
        _starRating(context),
        _price(context),
        SizedBox(height: 12.0),
        Row(
          mainAxisAlignment: MainAxisAlignment.center,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            (widget.walkmandeals.type == 1 || widget.walkmandeals.type == 3)
                ? _redeemNow(context)
                : Container(),
            SizedBox(width: 16),
            (widget.walkmandeals.type == 2 || widget.walkmandeals.type == 3)
                ? _addToCart(context)
                : Container()
          ],
        )
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
          RatingBar.builder(
            initialRating: 3,
            minRating: 1,
            direction: Axis.horizontal,
            allowHalfRating: true,
            itemCount: 5,
            itemPadding: EdgeInsets.symmetric(horizontal: 4.0),
            itemBuilder: (context, _) => Icon(
              Icons.star,
              color: ThemeColor.darkGreen,
            ),
            onRatingUpdate: (_rating) {
              setState(() {
                rating = _rating;
              });
            },
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
                'Price Before : ',
                style: ThemeText.subTitle,
              ),
              Text(
                widget.walkmandeals.actprice,
                style: TextStyle(
                    color: Colors.red,
                    fontSize: 20.0,
                    decoration: TextDecoration.lineThrough),
              ),
            ],
          ),
          Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: <Widget>[
              Text(
                'Price Now : ',
                style: ThemeText.subTitle,
              ),
              Text(
                '${widget.walkmandeals.discprice} + ',
                style: ThemeText.titleStyle,
              ),
              Text(
                '200 ',
                style: ThemeText.titleStyle,
              ),
              Image.asset(
                'assets/images/profile/MaskGroup.png',
                width: 16.0,
              )
            ],
          ),
        ],
      ),
    );
  }

  Widget _redeemNow(context) {
    final provider = Provider.of<BottonClickprovider>(context, listen: false);
    return Container(
      alignment: Alignment.center,
      child: RaisedButton.icon(
          padding: EdgeInsets.symmetric(horizontal: 20),
          color: ThemeColor.darkGreen,
          shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(6)),
          elevation: 0,
          onPressed: () {
            _showDialogContainer(context, provider);
          },
          icon: Icon(
            Icons.redeem_outlined,
            color: Colors.white,
          ),
          label: Text(
            'REDEEM NOW',
            style: TextStyle(color: Colors.white, fontSize: 18),
          )),
    );
  }

  Widget _description(context) {
    return Padding(
      padding: const EdgeInsets.only(left: 20.0),
      child: Column(
        // mainAxisAlignment: MainAxisAlignment.start,
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
              widget.walkmandeals.desc,
              style: ThemeText.subTitle,
            ),
          ),
          SizedBox(height: 10.0),
        ],
      ),
    );
  }

  Widget _addToCart(context) {
    final cartProvider = Provider.of<CartProvider>(context);
    final cartServiceProvider = Provider.of<CartService>(context);
    return Container(
      alignment: Alignment.center,
      child: RaisedButton.icon(
          padding: EdgeInsets.symmetric(horizontal: 20),
          color: ThemeColor.darkGreen,
          shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(6)),
          elevation: 0,
          onPressed: () {
            cartServiceProvider.addProduct(widget.walkmandeals.id);
            cartProvider.setcartList(widget.walkmandeals);
            Toast.show('Item Added to your cart', context,
                duration: 2, gravity: Toast.CENTER);
          },
          icon: Icon(
            Icons.add_shopping_cart,
            color: Colors.white,
          ),
          label: Text(
            'Add to Cart',
            style: TextStyle(color: Colors.white, fontSize: 18),
          )),
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
                            'REDEEM NOW?',
                            style: ThemeText.infoTitle,
                          ),
                        ],
                      ),
                      Container(
                        child: FittedBox(
                          child: Text(
                            'Your Green Coins will be decreased. Make sure to use QR code right away.',
                            maxLines: 2,
                            style: TextStyle(
                                color: Colors.black26,
                                decoration: TextDecoration.none),
                          ),
                        ),
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
                                ////// Decrease Green Coins from here making function call.
                                /// make a function in profile provider with parameter that take coin required to purchase this item
                                /// call this function here to decrease coins....
                                provider.isClick = true;
                                Navigator.pop(context);
                              },
                              child: FittedBox(
                                child: Text(
                                  'Yes, Right now.',
                                  style: ThemeText.subTitle,
                                ),
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
          SizedBox(height: 10.0),
          // Padding(
          //   padding: const EdgeInsets.only(left: 20, right: 20),
          //   child: Divider(
          //     color: Colors.grey[900],
          //   ),
          // ),
          Text(
            'QR Code',
            style: ThemeText.infoTitle,
          ),
          Center(
            child: Container(
                height: 180, child: QrImage(data: widget.walkmandeals.id)),
          ),
          // Center(
          //   child: RaisedButton(
          //     padding: EdgeInsets.symmetric(horizontal: 50),
          //     elevation: 0,
          //     shape: RoundedRectangleBorder(
          //       borderRadius: BorderRadius.circular(10),
          //     ),
          //     color: ThemeColor.darkGreen,
          //     onPressed: () {},
          //     child: Text('Buy Now', style: TextStyle(color: Colors.white)),
          //   ),
          // ),
          SizedBox(height: 10.0),
        ],
      ),
    );
  }
}
