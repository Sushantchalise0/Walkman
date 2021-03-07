import 'package:flutter/material.dart';
import '../../../util/colors.dart';
import '../../../util/styles.dart';
import '../../../widgets/app_bar.dart';

class CreateImage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: CustomAppBar(
        bcolor: ThemeColor.whiteColor,
        height: 60.0,
        aTitle: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: <Widget>[
            GestureDetector(
              onTap: () {
                Navigator.pushNamed(context, '/walking-result');
              },
              child: Icon(
                Icons.clear,
                size: 28.0,
                color: ThemeColor.blackColor,
              ),
            ),
            Text(
              'Create Image',
              style: ThemeText.infoTitle,
            ),
            Text(
              'Share',
              style: ThemeText.usertextStyle,
            ),
          ],
        ),
      ),
      body: Column(
        children: <Widget>[
          Stack(
            children: <Widget>[
              Container(
                width: MediaQuery.of(context).size.width,
                child: Image.asset(
                  'assets/images/walking/createimg.png',
                  fit: BoxFit.cover,
                ),
              ),
              Positioned(
                bottom: 70.0,
                left: 20.0,
                child: Text(
                  'Running',
                  style: ThemeText.userNameText,
                ),
              ),
              Positioned(
                bottom: 40.0,
                left: 10.0,
                child: Row(
                  children: <Widget>[
                    Icon(
                      Icons.timer,
                      color: ThemeColor.whiteColor,
                    ),
                    SizedBox(width: 5.0),
                    Text(
                      '00:43:10',
                      style: ThemeText.userNameText,
                    ),
                  ],
                ),
              ),
            ],
          ),
        ],
      ),
    );
  }
}
