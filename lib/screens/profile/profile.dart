import 'package:WalkmanMobile/model/stepCountodel.dart';
import 'package:WalkmanMobile/services/stepCount.dart';
import 'package:WalkmanMobile/util/styles.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:provider/provider.dart';
import 'package:WalkmanMobile/provider/botton_click_provider.dart';
import '../../screens/profile/profile_header.dart';

class Profile extends StatefulWidget {
  @override
  _ProfileState createState() => _ProfileState();
}

class _ProfileState extends State<Profile> {
  StepCount _stepCount = StepCount();
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SingleChildScrollView(
        child: ChangeNotifierProvider<BottonClickprovider>(
          create: (BuildContext context) => BottonClickprovider(),
          child: Column(
            children: [
              ProfileHeader(),
              FutureBuilder<StepCountModel>(
                  future: _stepCount.getStepCount(),
                  builder: (context, snapshot) {
                    if (!snapshot.hasData) {
                      return Center(
                        child: CircularProgressIndicator(),
                      );
                    }
                    if (snapshot.hasError) {
                      return Center(child: Text('Error Loading Data'));
                    }
                    return Column(
                      children: [
                        Container(
                          height: 100,
                          child: Row(
                            mainAxisAlignment: MainAxisAlignment.spaceAround,
                            children: [
                              Container(
                                height: 120.0,
                                child: Column(
                                  children: <Widget>[
                                    SizedBox(height: 20.0),
                                    Text(
                                      'YOUR TOTAL STEPS',
                                      style: ThemeText.upperCaseText,
                                    ),
                                    SizedBox(height: 8.0),
                                    Text(
                                      snapshot.data.userStep.toString(),
                                      style: ThemeText.userStepsTextCount,
                                    )
                                  ],
                                ),
                              ),
                              Container(
                                height: 120.0,
                                child: Column(
                                  children: <Widget>[
                                    SizedBox(height: 20.0),
                                    Text(
                                      'TOTAL USER STEPS',
                                      style: ThemeText.upperCaseText,
                                    ),
                                    SizedBox(height: 8.0),
                                    Text(
                                      snapshot.data.totalStep.toString(),
                                      style: ThemeText.userStepsTextCount,
                                    )
                                  ],
                                ),
                              ),
                            ],
                          ),
                        ),
                        Container(
                          child: Row(
                            mainAxisAlignment: MainAxisAlignment.spaceAround,
                            children: [
                              Column(
                                children: <Widget>[
                                  Image.asset(
                                    'assets/images/profile/trophy.png',
                                    width: 40,
                                  ),
                                  SizedBox(height: 4.0),
                                  Text(
                                    snapshot.data.position.toString(),
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
                                  SvgPicture.asset(
                                    'assets/icons/Greencoin.svg',
                                    color: Colors.lightGreen,
                                    width: 40.0,
                                  ),
                                  SizedBox(height: 4.0),
                                  Text(
                                    snapshot.data.userCoins.toString(),
                                    style: ThemeText.boldStepsCount,
                                  ),
                                  SizedBox(height: 4.0),
                                  Text(
                                    'Green Coins',
                                    style: ThemeText.subTitle,
                                  ),
                                ],
                              ),
                              Column(
                                children: <Widget>[
                                  SvgPicture.asset(
                                    'assets/icons/Greencoin.svg',
                                    color: Colors.lightGreen,
                                    width: 40.0,
                                  ),
                                  SizedBox(height: 4.0),
                                  Text(
                                    snapshot.data.position.toString(),
                                    style: ThemeText.boldStepsCount,
                                  ),
                                  SizedBox(height: 4.0),
                                  Text(
                                    'Carbon Reduction',
                                    style: ThemeText.subTitle,
                                  ),
                                ],
                              ),
                            ],
                          ),
                        )
                      ],
                    );
                  }),
              // SizedBox(height: 10.0),
              // ProfilePosition(),
              // SizedBox(height: 10.0),
              // ProfileCommunity(),
            ],
          ),
        ),
      ),
    );
  }
}

// Row(
//                       children: [
//                         Column(
//                           children: <Widget>[
// Expanded(
//   child: Container(
//     height: 100.0,
//     child: Column(
//       children: <Widget>[
//         SizedBox(height: 20.0),
//         Text(
//           'YOUR TOTAL STEPS',
//           style: ThemeText.upperCaseText,
//         ),
//         SizedBox(height: 8.0),
//         Text(
//           snapshot.data.userStep.toString(),
//           style: ThemeText.userStepsTextCount,
//         )
//       ],
//     ),
//   ),
// ),
//                             VerticalDivider(
//                               thickness: 2,
//                               width: 20,
//                               color: Color(0xFF005A21),
//                             ),
//                             Expanded(
//                               child: Container(
//                                 // width: MediaQuery.of(context).size.width * 0.5,
//                                 height: 100.0,
//                                 child: Column(
//                                   children: <Widget>[
//                                     SizedBox(height: 20.0),
//                                     Text(
//                                       'TOTAL USERS STEPS',
//                                       style: ThemeText.upperCaseText,
//                                     ),
//                                     SizedBox(height: 8.0),
//                                     Text(
//                                       snapshot.data.totalStep.toString(),
//                                       style: ThemeText.userStepsTextCount,
//                                     )
//                                   ],
//                                 ),
//                               ),
//                             ),

//                           ],
//                         ),
//                       ],
//                     );
