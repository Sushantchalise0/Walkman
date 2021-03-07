import 'package:flutter/material.dart';
import 'package:WalkmanMobile/util/colors.dart';

abstract class ThemeText {
  static const TextStyle titleStyle = TextStyle(
    color: ThemeColor.blackColor,
    fontSize: 18.0,
    fontWeight: FontWeight.bold,
  );
  static const TextStyle subTitle = TextStyle(
    color: ThemeColor.blackColor,
    fontSize: 15.0,
    fontWeight: FontWeight.normal,
    decorationColor: Colors.white,
  );
  static const TextStyle userNameText = TextStyle(
    fontSize: 18.0,
    fontWeight: FontWeight.w600,
    color: ThemeColor.whiteColor,
    fontFamily: 'Taile',
  );
  static const TextStyle countText = TextStyle(
    color: ThemeColor.whiteColor,
    fontSize: 16.0,
    fontWeight: FontWeight.normal,
  );
  static const TextStyle upperCaseText = TextStyle(
    color: ThemeColor.darkGreen,
    fontSize: 13.0,
    fontWeight: FontWeight.normal,
  );
  static const TextStyle userStepsTextCount = TextStyle(
    color: ThemeColor.darkGreen,
    fontSize: 22.0,
    fontWeight: FontWeight.bold,
  );
 
  static const TextStyle boldStepsCount = TextStyle(
    color: ThemeColor.blackColor,
    fontSize: 18.0,
    fontWeight: FontWeight.bold,
  );
  static const TextStyle leaderBoardListStyle = TextStyle(
      color: ThemeColor.darkGrey,
      fontSize: 18.0,
      fontWeight: FontWeight.normal,
    );
  static const TextStyle infoTitle = TextStyle(
    color: ThemeColor.darkGreen,
    fontSize: 20.0,
    fontWeight: FontWeight.w500,
    decorationColor: Colors.white,
  );
  static const TextStyle usertextStyle = TextStyle(
    color: ThemeColor.darkGrey,
      fontSize: 17.0,
      fontWeight: FontWeight.w400,
  );

}
