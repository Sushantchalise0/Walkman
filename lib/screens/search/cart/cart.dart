import 'package:badges/badges.dart';
import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:provider/provider.dart';
import 'package:WalkmanMobile/provider/cartProvider.dart';
import 'package:WalkmanMobile/util/styles.dart';
import 'package:WalkmanMobile/widgets/app_bar.dart';
import 'package:toast/toast.dart';
import './checkout.dart';
import 'package:WalkmanMobile/util/colors.dart';

class Cart extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    final cartProvider = Provider.of<CartProvider>(context);
    int totalPrice = 0;
    cartProvider.cartList.forEach((element) {
      totalPrice += int.parse(element.actprice.split(' ')[1]);
    });
    return Scaffold(
      appBar: CustomAppBar(
        height: 50.0,
        aTitle: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: <Widget>[
            GestureDetector(
              onTap: () {
                Navigator.pop(context);
              },
              child: Icon(Icons.arrow_back_ios),
            ),
            Text('CART'),
            GestureDetector(
              onTap: () {},
              child: Badge(
                badgeContent: Text(
                  '3',
                  style: TextStyle(
                    color: Colors.white,
                    fontWeight: FontWeight.bold,
                  ),
                ),
                child: SvgPicture.asset(
                  "assets/icons/bell.svg",
                  height: 25.0,
                ),
                position: BadgePosition.topStart(start: 10),
              ),
            ),
          ],
        ),
      ),
      body: Container(
        child: cartProvider.cartList.length == 0
            ? Center(
                child: Text('No item added to Cart!'),
              )
            : ListView.builder(
                itemCount: cartProvider.cartList.length,
                itemBuilder: (context, int index) {
                  return ListTile(
                    shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(10)),
                    leading: Container(
                      width: 60,
                      child: CachedNetworkImage(
                          imageUrl:
                              'https://peaceful-atoll-49860.herokuapp.com' +
                                  cartProvider.cartList[index].img),
                    ),
                    title: Text(cartProvider.cartList[index].name),
                    subtitle: Text(cartProvider.cartList[index].actprice),
                    trailing: IconButton(
                      icon: Icon(Icons.delete),
                      onPressed: () {
                        cartProvider.removeCartItem(index);
                      },
                    ),
                  );
                }),
      ),
      bottomSheet: BottomSheet(
        onClosing: () {},
        builder: (context) {
          return Container(
              alignment: Alignment.center,
              padding: EdgeInsets.symmetric(horizontal: 20),
              height: 60,
              decoration:
                  BoxDecoration(borderRadius: BorderRadius.circular(12)),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        'Amount',
                        style: ThemeText.subTitle,
                      ),
                      Text(
                        'Rs. ' + totalPrice.toString(),
                        style: ThemeText.infoTitle,
                      )
                    ],
                  ),
                  RaisedButton.icon(
                      padding: EdgeInsets.symmetric(horizontal: 16),
                      color: ThemeColor.darkGreen,
                      shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(6)),
                      elevation: 0,
                      onPressed: cartProvider.cartList.length == 0
                          ? () {
                              return Toast.show(
                                  'Please add item to the cart first!',
                                  context);
                            }
                          : () {
                              Navigator.push(
                                  context,
                                  MaterialPageRoute(
                                      builder: (context) => CheckOut()));
                            },
                      icon: Icon(
                        Icons.shopping_cart_rounded,
                        color: Colors.white,
                      ),
                      label: Text('Checkout',
                          style: TextStyle(color: Colors.white, fontSize: 18)))
                ],
              ));
        },
      ),
    );
  }
}
