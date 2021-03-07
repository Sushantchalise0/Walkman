import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:provider/provider.dart';
import 'package:grouped_buttons/grouped_buttons.dart';

import '../../provider/botton_click_provider.dart';
import '../../util/colors.dart';
import '../../util/styles.dart';

class ProfileInterest extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    final buttonClick = Provider.of<BottonClickprovider>(context);
    return Column(
      children: <Widget>[
        _buildInterest(context, buttonClick),
        SizedBox(height: 10.0),
      ],
    );
  }
  
  Widget _buildInterest(BuildContext context, buttonClick) {
    final List<Widget> widgets = interests
        .map(
          (interest) => Padding(
        padding: EdgeInsets.only(right: 8.0, left: 8.0),
        child: _buildInterestChip(context, interest),
      ),
    )
        .toList();
    
    return Column(
      children: <Widget>[
        _buildMyInterestHeading(buttonClick, context),
        Wrap(children: widgets),
      ],
    );
  }
  
  Widget _buildMyInterestHeading(buttonClick, context) {
    return buttonClick.isClick == false
        ? Text(
      'My Interests',
      style: ThemeText.titleStyle,
    )
        : Padding(
      padding: EdgeInsets.only(left: 12.0, bottom: 10.0, right: 12.0),
      child: _infoInterest(context),
    );
  }
  
  Widget _buildInterestChip(BuildContext context, String interest) {
    return Chip(
      backgroundColor: ThemeColor.darkGrey,
      label: Text(
        interest,
        style: TextStyle(
          color: ThemeColor.whiteColor,
          fontSize: 14.0,
        ),
      ),
    );
  }
  
  Widget _infoInterest(context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: <Widget>[
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: <Widget>[
            Text(
              'My Interests',
              style: ThemeText.infoTitle,
            ),
            GestureDetector(
              onTap: () {},
              child: Container(
                width: 40.0,
                height: 20.0,
                decoration: BoxDecoration(
                  border: Border.all(
                    color: ThemeColor.darkGreen,
                  ),
                ),
                child: Center(
                  child: Text(
                    'Save',
                    style: TextStyle(
                      color: ThemeColor.darkGreen,
                    ),
                  ),
                ),
              ),
            ),
          ],
        ),
        SizedBox(height: 6.0),
        GestureDetector(
          onTap: () {
            _alertDialog(context);
          },
          child: Padding(
            padding: const EdgeInsets.only(left: 20.0),
            child: Row(
              children: <Widget>[
                Icon(
                  FontAwesomeIcons.plus,
                  size: 14.0,
                  color: ThemeColor.darkGreen,
                ),
                SizedBox(width: 4.0),
                Text(
                  'what are your Interests?',
                  style: TextStyle(color: Colors.grey),
                ),
              ],
            ),
          ),
        ),
      ],
    );
  }
  
  void _alertDialog(context) async {
    return await showDialog(
      context: context,
      builder: (context) {
        return AlertDialog(
          title: _infoInterest(context),
          content: SingleChildScrollView(
            child: Column(
              children: <Widget>[
                CheckboxGroup(
                  labels: <String>[
                    'Beer',
                    'Chiya',
                    'Mo:Mo',
                    'Newari Khaja',
                    'T-shirts',
                    'Electronics',
                    'Engineer',
                    'Shoes',
                    'Girls Wear',
                    'Antique',
                    'Beauty',
                    'Fashion'
                  ],
                  disabled: ['Beer', 'Mo:Mo', 'Fashion', 'Shoes'],
                  onChange: (bool isChecked, String label, int index) =>
                      print('$isChecked'),
                  onSelected: (List<String> checked) =>
                      print('${checked.toString()}'),
                )
              ],
            ),
          ),
          actions: <Widget>[
            FlatButton(
              onPressed: () {
                Navigator.of(context, rootNavigator: true).pop(false);
              },
              child: Text(
                'Cancel',
                style: TextStyle(
                  color: ThemeColor.darkGreen,
                ),
              ),
            ),
            FlatButton(
              onPressed: () {
                Navigator.of(context, rootNavigator: true).pop(true);
              },
              child: Text(
                'Ok',
                style: TextStyle(
                  color: ThemeColor.darkGreen,
                ),
              ),
            ),
          ],
        );
      },
    );
  }
  
  final interests = [
    'chiya',
    'Mo:Mo',
    'Choila',
    'Bara',
    'Sekuwa',
    'Home Decore',
    'Shoes',
    'Beuty',
    'Fashion'
  ];
}

// class MyInterests {
//   final String interest;

//   MyInterests({this.interest});
// }

// final List<MyInterests> myInterest = [
//   MyInterests(interest: 'Chiya'),
//   MyInterests(interest: 'Mo:Mo'),
//   MyInterests(interest: 'Choila'),
//   MyInterests(interest: 'Bara'),
//   MyInterests(interest: 'Sekuwa'),
//   MyInterests(interest: 'Home Decore'),
//   MyInterests(interest: 'Shoes'),
//   MyInterests(interest: 'Beuty'),
//   MyInterests(interest: 'Fashion'),
// ];