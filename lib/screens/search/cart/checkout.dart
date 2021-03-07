import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:toast/toast.dart';
import 'package:WalkmanMobile/model/billingModel.dart';
import 'package:WalkmanMobile/screens/home/home.dart';
import 'package:WalkmanMobile/services/cart.dart';
import 'package:WalkmanMobile/util/colors.dart';
import './billingAddress.dart';
import 'package:WalkmanMobile/provider/cartProvider.dart';
import 'package:provider/provider.dart';
import 'package:WalkmanMobile/services/billingAddress.dart';

class CheckOut extends StatelessWidget {
  int addressIndex = 0;
  BillingModel _model;
  @override
  Widget build(BuildContext context) {
    final cartProvider = Provider.of<CartProvider>(context);
    final billingAddressProvider = Provider.of<BillingAddressProvider>(context);
    int totalPrice = 0;
    cartProvider.cartList.forEach((element) {
      totalPrice += int.parse(element.actprice.split(' ')[1]);
    });
    return Scaffold(
      resizeToAvoidBottomPadding: false,
      appBar: AppBar(
        backgroundColor: ThemeColor.darkGreen,
        title: Text('CHECKOUT'),
        elevation: 0,
      ),
      body: Column(
        children: [
          Container(
            height: 40,
            width: MediaQuery.of(context).size.width,
            margin: EdgeInsets.symmetric(horizontal: 10),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Text(
                  'Billing Address',
                  style: TextStyle(fontSize: 18, color: ThemeColor.darkGreen),
                ),
                FlatButton(
                    padding: EdgeInsets.zero,
                    onPressed: () {
                      Navigator.push(
                          context,
                          MaterialPageRoute(
                              builder: (context) => BillingAddress(
                                  _model.addrs[addressIndex].id,
                                  _model.addrs[addressIndex].fullName,
                                  _model.addrs[addressIndex].phoneNumber
                                      .toString(),
                                  _model.addrs[addressIndex].province,
                                  _model.addrs[addressIndex].city,
                                  _model.addrs[addressIndex].address)));
                    },
                    child: Text(
                      'EDIT',
                      style: TextStyle(
                          fontSize: 16,
                          color: ThemeColor.darkGreen,
                          fontWeight: FontWeight.w600),
                    ))
              ],
            ),
          ),
          FutureBuilder<BillingModel>(
              future: billingAddressProvider.getBillingAddress(),
              builder: (context, snapshot) {
                if (snapshot.hasError) {
                  return Center(
                    child: Text('Error Loading Billing Address. Try Again!'),
                  );
                }
                if (!snapshot.hasData) {
                  return CircularProgressIndicator();
                }
                _model = snapshot.data;
                return Container(
                  height: 150,
                  child: PageView.builder(
                      controller: PageController(viewportFraction: 0.9),
                      itemCount: snapshot.data.addrs.length,
                      onPageChanged: (int index) {
                        addressIndex = index;
                        print(snapshot.data.addrs[index].id);
                      },
                      itemBuilder: (context, int index) {
                        return Card(
                          child: Container(
                            padding: EdgeInsets.symmetric(horizontal: 10),
                            child: Column(
                              children: [
                                Row(
                                  mainAxisAlignment:
                                      MainAxisAlignment.spaceBetween,
                                  crossAxisAlignment: CrossAxisAlignment.center,
                                  children: [
                                    Text(
                                      'Full Name',
                                      style: TextStyle(
                                          fontWeight: FontWeight.w300,
                                          fontSize: 16),
                                    ),
                                    Text(
                                      snapshot.data.addrs[index].fullName,
                                      style: TextStyle(fontSize: 18),
                                    )
                                  ],
                                ),
                                SizedBox(height: 6),
                                Row(
                                  mainAxisAlignment:
                                      MainAxisAlignment.spaceBetween,
                                  crossAxisAlignment: CrossAxisAlignment.center,
                                  children: [
                                    Text(
                                      'Phone Number',
                                      style: TextStyle(
                                          fontWeight: FontWeight.w300,
                                          fontSize: 16),
                                    ),
                                    Text(
                                      snapshot.data.addrs[index].phoneNumber
                                          .toString(),
                                      style: TextStyle(fontSize: 18),
                                    )
                                  ],
                                ),
                                SizedBox(height: 6),
                                Row(
                                  mainAxisAlignment:
                                      MainAxisAlignment.spaceBetween,
                                  crossAxisAlignment: CrossAxisAlignment.center,
                                  children: [
                                    Text(
                                      'Province',
                                      style: TextStyle(
                                          fontWeight: FontWeight.w300,
                                          fontSize: 16),
                                    ),
                                    Text(
                                      snapshot.data.addrs[index].province,
                                      style: TextStyle(fontSize: 18),
                                    )
                                  ],
                                ),
                                SizedBox(height: 6),
                                Row(
                                  mainAxisAlignment:
                                      MainAxisAlignment.spaceBetween,
                                  crossAxisAlignment: CrossAxisAlignment.center,
                                  children: [
                                    Text(
                                      'City',
                                      style: TextStyle(
                                          fontWeight: FontWeight.w300,
                                          fontSize: 16),
                                    ),
                                    Text(
                                      snapshot.data.addrs[index].city,
                                      style: TextStyle(fontSize: 18),
                                    )
                                  ],
                                ),
                                SizedBox(height: 6),
                                Row(
                                  mainAxisAlignment:
                                      MainAxisAlignment.spaceBetween,
                                  crossAxisAlignment: CrossAxisAlignment.center,
                                  children: [
                                    Text(
                                      'Address',
                                      style: TextStyle(
                                          fontWeight: FontWeight.w300,
                                          fontSize: 16),
                                    ),
                                    Text(
                                      snapshot.data.addrs[index].address,
                                      style: TextStyle(fontSize: 18),
                                    )
                                  ],
                                ),
                                SizedBox(height: 6),
                              ],
                            ),
                          ),
                        );
                      }),
                );
              }),
          Container(
              margin: EdgeInsets.symmetric(horizontal: 20),
              child: Text(
                  'Please set billing address to deliver your product by sliding addresses.')),
          SizedBox(
            height: 16,
          ),
          Divider(
            thickness: 2,
            color: ThemeColor.darkGreen,
          ),
          SizedBox(
            height: 16,
          ),
          Container(
            margin: EdgeInsets.only(left: 10),
            alignment: Alignment.centerLeft,
            child: Text(
              'Your Items',
              style: TextStyle(
                  color: ThemeColor.darkGreen,
                  fontSize: 16,
                  fontWeight: FontWeight.bold),
            ),
          ),
          Expanded(
              child: Container(
            margin: EdgeInsets.only(top: 12),
            child: ListView.builder(
                itemCount: cartProvider.cartList.length + 1,
                itemBuilder: (context, int index) {
                  if (index == cartProvider.cartList.length) {
                    return Container(
                      padding: EdgeInsets.symmetric(vertical: 10),
                      height: 70,
                      decoration: BoxDecoration(color: Colors.white),
                      margin: EdgeInsets.symmetric(horizontal: 14),
                      child: Column(
                        children: [
                          Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                              Text(
                                'Subtotal(${cartProvider.cartList.length.toString()} item)',
                                style: TextStyle(fontSize: 16),
                              ),
                              Text('Rs. ' + totalPrice.toString(),
                                  style: TextStyle(fontSize: 16)),
                            ],
                          ),
                          SizedBox(height: 12),
                          Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                              Text('Shipping Fee',
                                  style: TextStyle(fontSize: 16)),
                              Text('FREE', style: TextStyle(fontSize: 16)),
                            ],
                          ),
                        ],
                      ),
                    );
                  }
                  return Card(
                    borderOnForeground: true,
                    elevation: 6,
                    margin: EdgeInsets.only(left: 12, right: 12, bottom: 10),
                    child: Container(
                      padding: EdgeInsets.only(left: 8, top: 8, bottom: 8),
                      child: Column(
                        mainAxisAlignment: MainAxisAlignment.start,
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          SizedBox(height: 8),
                          Row(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              CachedNetworkImage(
                                imageUrl:
                                    'https://peaceful-atoll-49860.herokuapp.com' +
                                        cartProvider.cartList[index].img,
                                fit: BoxFit.fill,
                                width: 100,
                                height: 80,
                              ),
                              SizedBox(width: 16),
                              Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  Text(
                                    cartProvider.cartList[index].name,
                                    style:
                                        TextStyle(fontWeight: FontWeight.w600),
                                  ),
                                  SizedBox(height: 4),
                                  Text(cartProvider.cartList[index].desc,
                                      style: TextStyle(
                                          fontWeight: FontWeight.w300)),
                                  SizedBox(height: 20),
                                  Container(
                                    width:
                                        MediaQuery.of(context).size.width - 180,
                                    child: Row(
                                      mainAxisAlignment:
                                          MainAxisAlignment.spaceBetween,
                                      children: [
                                        Text(cartProvider
                                            .cartList[index].actprice),
                                        Text(cartProvider
                                                .cartList[index].ratings +
                                            ' stars')
                                      ],
                                    ),
                                  )
                                ],
                              )
                            ],
                          )
                        ],
                      ),
                    ),
                  );
                }),
          )),
          SizedBox(height: 60),
        ],
      ),
      bottomSheet: Container(
          margin: EdgeInsets.symmetric(horizontal: 10),
          height: 50,
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    'Total Rs. ' + totalPrice.toString(),
                    style: TextStyle(color: ThemeColor.darkGreen, fontSize: 18),
                  ),
                  SizedBox(height: 4),
                  Text(
                    'VAT included where applicable',
                    style: TextStyle(fontWeight: FontWeight.w300),
                  )
                ],
              ),
              RaisedButton(
                elevation: 0,
                color: ThemeColor.darkGreen,
                shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(6)),
                onPressed: () {
                  final _cartService = Provider.of<CartService>(context);
                  _cartService.addToCart().then((value) {
                    if (value == true) {
                      Toast.show('Cart Updated!', context);
                      Navigator.pushReplacement(context,
                          MaterialPageRoute(builder: (context) => Home()));
                    } else {
                      Toast.show(
                          'Error adding on your cart. Try again!', context);
                    }
                  });
                },
                child: Text(
                  'Confirm',
                  style: TextStyle(color: Colors.white),
                ),
              )
            ],
          )),
    );
  }
}
