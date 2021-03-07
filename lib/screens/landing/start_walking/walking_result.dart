import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:provider/provider.dart';
import 'package:WalkmanMobile/provider/botton_click_provider.dart';
import 'package:WalkmanMobile/util/colors.dart';
import 'package:WalkmanMobile/util/styles.dart';
import 'package:WalkmanMobile/widgets/app_bar.dart';

class WalkingResult extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    final buttonClick = Provider.of<BottonClickprovider>(context);

    return Scaffold(
      appBar: CustomAppBar(
        height: 60.0,
        bcolor: ThemeColor.whiteColor,
        aTitle: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: <Widget>[
            GestureDetector(
              onTap: () {
                buttonClick.isClick = !buttonClick.isClick;
                print(buttonClick.isClick);
                Navigator.pushNamed(context, '/landing');
              },
              child: Icon(
                Icons.arrow_back_ios,
                size: 26.0,
                color: ThemeColor.blackColor,
              ),
            ),
            Text(
              'JUST NOW',
              style: ThemeText.infoTitle,
            ),
            GestureDetector(
              onTap: () {},
              child: Icon(
                Icons.share,
                size: 26.0,
                color: ThemeColor.blackColor,
              ),
            ),
          ],
        ),
      ),
      body: SingleChildScrollView(
              child: Column(
          children: <Widget>[
            Container(
              padding: EdgeInsets.all(10.0),
              margin: EdgeInsets.all(6.0),
              width: MediaQuery.of(context).size.width,
              child: Card(
                elevation: 1.0,
                child: Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: Column(
                    // mainAxisAlignment: MainAxisAlignment.start,
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: <Widget>[
                      Text(
                        'Running',
                        style: ThemeText.infoTitle,
                      ),
                      SizedBox(height: 35.0),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceAround,
                        children: <Widget>[
                          SvgPicture.asset(
                            'assets/icons/leaderboard.svg',
                          ),
                          Text(
                            'Check out your rank',
                            style: ThemeText.titleStyle,
                          ),
                        ],
                      ),
                      SizedBox(height: 35.0),
                      Row(
                        children: <Widget>[
                          Column(
                            children: <Widget>[
                              Text(
                                '00:00:12',
                                style: ThemeText.boldStepsCount,
                              ),
                              Text(
                                'Duration',
                                style: ThemeText.titleStyle,
                              ),
                            ],
                          ),
                          SizedBox(width: 120.0),
                          Column(
                            children: <Widget>[
                              Text(
                                '0',
                                style: ThemeText.boldStepsCount,
                              ),
                              Text(
                                'Duration',
                                style: ThemeText.titleStyle,
                              ),
                            ],
                          ),
                        ],
                      ),
                      SizedBox(height: 15.0),
                    ],
                  ),
                ),
              ),
            ),
            Container(
              padding: EdgeInsets.all(10.0),
              margin: EdgeInsets.all(6.0),
              width: MediaQuery.of(context).size.width,
              child: Card(
                elevation: 1.0,
                child: Column(
                  // mainAxisAlignment: MainAxisAlignment.start,
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: <Widget>[
                    SizedBox(height: 20.0),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceAround,
                      children: <Widget>[
                        SvgPicture.asset(
                          'assets/icons/leaderboard.svg',
                        ),
                        Text(
                          'Avg Pace',
                          style: ThemeText.titleStyle,
                        ),
                        Text(
                          '00:00 min/km',
                          style: ThemeText.titleStyle,
                        ),
                      ],
                    ),
                    SizedBox(height: 20.0),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceAround,
                      children: <Widget>[
                        SvgPicture.asset(
                          'assets/icons/leaderboard.svg',
                        ),
                        Text(
                          'Avg Pace',
                          style: ThemeText.titleStyle,
                        ),
                        Text(
                          '00:00 min/km',
                          style: ThemeText.titleStyle,
                        ),
                      ],
                    ),
                    SizedBox(height: 20.0),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceAround,
                      children: <Widget>[
                        SvgPicture.asset(
                          'assets/icons/leaderboard.svg',
                        ),
                        Text(
                          'Avg Pace',
                          style: ThemeText.titleStyle,
                        ),
                        Text(
                          '00:00 min/km',
                          style: ThemeText.titleStyle,
                        ),
                      ],
                    ),
                    SizedBox(height: 20.0),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceAround,
                      children: <Widget>[
                        SvgPicture.asset(
                          'assets/icons/leaderboard.svg',
                        ),
                        Text(
                          'Avg Pace',
                          style: ThemeText.titleStyle,
                        ),
                        Text(
                          '00:00 min/km',
                          style: ThemeText.titleStyle,
                        ),
                      ],
                    ),
                    SizedBox(height: 20.0),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceAround,
                      children: <Widget>[
                        SvgPicture.asset(
                          'assets/icons/leaderboard.svg',
                        ),
                        Text(
                          'Avg Pace',
                          style: ThemeText.titleStyle,
                        ),
                        Text(
                          '00:00 min/km',
                          style: ThemeText.titleStyle,
                        ),
                      ],
                    ),
                    SizedBox(height: 20.0),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceAround,
                      children: <Widget>[
                        SvgPicture.asset(
                          'assets/icons/leaderboard.svg',
                        ),
                        Text(
                          'Avg Pace',
                          style: ThemeText.titleStyle,
                        ),
                        Text(
                          '00:00 min/km',
                          style: ThemeText.titleStyle,
                        ),
                      ],
                    ),
                    SizedBox(height: 20.0),
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
