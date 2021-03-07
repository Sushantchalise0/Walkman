import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:provider/provider.dart';
import '../../util/styles.dart';
import '../../provider/botton_click_provider.dart';

class ProfilePosition extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    final buttonClick = Provider.of<BottonClickprovider>(context);
    return buttonClick.isClick == false ? Container(
      child: Column(
        children: <Widget>[
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceAround,
            children: <Widget>[
              Column(
                children: <Widget>[
                  Image.asset('assets/images/profile/trophy.png', width: 50,),
                  SizedBox(height: 4.0),
                  Text(
                    '8',
                    style: ThemeText.boldStepsCount,
                  ),
                  SizedBox(height: 4.0),
                  Text(
                    'Position',
                    style: ThemeText.subTitle,
                  ),
                ],
              ),
              Column(
                children: <Widget>[
  
                  IconButton(
                    onPressed: () {
                    },
                    icon: SvgPicture.asset(
                      'assets/icons/Greencoin.svg',
                      color: Colors.lightGreen,
                      width: 50.0,
                    ),
                  ),
                  SizedBox(height: 4.0),
                  Text(
                    '2093',
                    style: ThemeText.boldStepsCount,
                  ),
                  SizedBox(height: 4.0),
                  Text(
                    'Coins',
                    style: ThemeText.subTitle,
                  ),
                ],
              ),
              // Column(
              //   children: <Widget>[
              //     IconButton(
              //       onPressed: () {
              //         Navigator.pushNamed(context, '/scan-qr');
              //       },
              //       icon: SvgPicture.asset(
              //         'assets/icons/carbon.svg',
              //         color: Colors.lightGreen,
              //         width: 50.0,
              //       ),
    
              //       // icon: Icon(
              //       //   FontAwesomeIcons.qrcode,
              //       //   size: 25.0,
              //       // ),
              //     ),
                  
              //     SizedBox(height: 4.0),
              //     Text(
              //       '23',
              //       style: ThemeText.boldStepsCount,
              //     ),
              //     SizedBox(height: 4.0),
              //     Text(
              //       'Position',
              //       style: ThemeText.subTitle,
              //     ),
              //   ],
              // ),
            ],
          ),
          Padding(
                padding: const EdgeInsets.only(left: 20, right: 20),
                child: Divider(
                  color: Colors.grey[900],
                ),
              ),
        ],
      ),
    ) : _myInterest(context);
  }

  Widget _myInterest(context){
    return Container();
  }
}