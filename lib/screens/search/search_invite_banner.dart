import 'package:flutter/material.dart';

class InviteBanner extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    // var width = MediaQuery.of(context).size.width;
    return Container(
      margin: EdgeInsets.symmetric(horizontal: 2.0),
      height: 150.0,
      width: double.infinity,
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(8.0),
        // color: Theme.of(context).primaryColor,
        // image: DecorationImage(
        //   image: AssetImage('assets/images/inviteBox.png'),
        //   fit: BoxFit.fill,
        // ),
      ),
      child: Image.asset(
        'assets/images/inviteBox.png',
        fit: BoxFit.fill,
      ),
      // child: Row(
      //   mainAxisAlignment: MainAxisAlignment.spaceAround,
      //   crossAxisAlignment: CrossAxisAlignment.center,
      //   children: <Widget>[
      //     Padding(
      //       padding: EdgeInsets.only(top: 20.0, bottom: 20.0, left: 5.0),
      //       child: Column(
      //         mainAxisAlignment: MainAxisAlignment.spaceBetween,
      //         crossAxisAlignment: CrossAxisAlignment.start,
      //         children: <Widget>[
      //           Text(
      //             'Invite your friends on Walkman & earn\nGreen Coins with every new Signup',
      //             style: TextStyle(
      //               color: Colors.white,
      //               fontSize: 12.0,
      //             ),
      //           ),
      //           Row(
      //             mainAxisAlignment: MainAxisAlignment.start,
      //             children: <Widget>[
      //               Text(
      //                 'START INVITING FRIENDS',
      //                 style: TextStyle(
      //                   color: Colors.white,
      //                   fontSize: 15.0,
      //                   fontWeight: FontWeight.w700,
      //                 ),
      //               ),
      //               SizedBox(
      //                 width: 10.0,
      //               ),
      //               IconButton(
      //                 icon: Icon(
      //                   FontAwesomeIcons.arrowCircleRight,
      //                   color: Colors.white,
      //                 ),
      //                 onPressed: () {},
      //               )
      //             ],
      //           ),
      //         ],
      //       ),
      //     ),
      //     Image.asset(
      //       'assets/images/gold_coin.png',
      //       // height: MediaQuery.of(context).size.height * 0.05,
      //       width: MediaQuery.of(context).size.height * 0.1,
      //     ),
      //     SizedBox(
      //       width: 5.0,
      //     ),
      //   ],
      // ),
    );
  }
}
