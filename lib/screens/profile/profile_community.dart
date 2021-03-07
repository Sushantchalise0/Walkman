import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../../provider/botton_click_provider.dart';
import '../../util/colors.dart';
import '../../util/styles.dart';

class ProfileCommunity extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    final buttonClick = Provider.of<BottonClickprovider>(context);
    return buttonClick.isClick == false
        ? Container(
          child: Padding(
            padding: const EdgeInsets.only(left: 20.0, right: 8.0),
            child: Column(crossAxisAlignment: CrossAxisAlignment.start,
                children: <Widget>[
                  Text(
                    'My Community',
                    style: ThemeText.titleStyle,
                  ),
                  SizedBox(height: 18.0),
                  Column(
                    mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                    children: <Widget>[
                      Container(
                        height: 60,
                        child: GestureDetector(
                          onTap:(){
                            Navigator.pushNamed(context, '/total-friends');
                          },
                          child: Container(
                            decoration: BoxDecoration(
                              color: Colors.grey[200],
  
                              borderRadius:
                              BorderRadius.all(
                                Radius.circular(10.0),
                              ),
                            ),
                            child: Row(
                              mainAxisAlignment: MainAxisAlignment.spaceAround,
                              children: <Widget>[
                                Text(
                                  'Total Friends',
                                  style: ThemeText.subTitle,
                                ),
                                SizedBox(width: 6.0),
                                Center(
                                  child: Text(
                                    '24',
                                    style: TextStyle(
                                      color: ThemeColor.blackColor,
                                      fontWeight: FontWeight.w500,
                                      fontSize: 14.0,
                                    ),
                                  ),
                                ),
                              ],
                            ),
                          ),
                        ),
                      ),
                      SizedBox(height: 10.0,),
                      GestureDetector(
                        onTap: (){
                          Navigator.pushNamed(context, '/total-invites');
                        },
                        child: Container(
  
                          height: 60,
                          child: Container(
                            decoration: BoxDecoration(
                              color: Colors.grey[200],
  
                              borderRadius:
                              BorderRadius.all(
                                Radius.circular(10.0),
                              ),
                            ),
                            child: Row(
                              mainAxisAlignment: MainAxisAlignment.spaceAround,
                              children: <Widget>[
                                Text(
                                  'Invites',
                                  style: ThemeText.subTitle,
                                ),
                                SizedBox(width: 6.0),
                                Container(
                                  height: 25,
                                  width: 35,
                                  decoration: BoxDecoration(
                                    color: ThemeColor.lightGreen,
                                    borderRadius:
                                    BorderRadius.all(
                                      Radius.circular(10.0),
                                    ),
                                  ),
                                  child: Center(
                                    child: Text(
                                      '3',
                                      style: TextStyle(
                                        color: ThemeColor.whiteColor,
                                        fontSize: 14.0,
                                      ),
                                    ),
                                  ),
                                ),
                              ],
                            ),
                          ),
                        ),
                      ),
                    ],
                  ),
//              Padding(
//                padding: const EdgeInsets.only(left: 20, right: 20),
//                child: Divider(
//                  color: Colors.grey[900],
//                ),
//              ),
                ],
              ),
          ),
        )
        : Container();
  }
}
