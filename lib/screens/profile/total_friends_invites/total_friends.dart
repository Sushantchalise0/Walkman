import 'package:flutter/material.dart';

import '../../../widgets/app_bar.dart';

class TotalFriends extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: CustomAppBar(
        height: 50.0,
        aTitle: Row(
          children: <Widget>[
            GestureDetector(
              onTap: () {
                Navigator.pop(context);
              },
              child: Icon(Icons.arrow_back_ios),
            ),
            SizedBox(width: 100.0),
            Text('MY FRIENDS'),
          ],
        ),
      ),
      body: Column(
        children: <Widget>[
          _myFriends(context),
        ],
      ),
    );
  }

  Widget _myFriends(context) {
    return Expanded(
      child: ListView.builder(
        physics: ScrollPhysics(),
        itemCount: friends.length,
        itemBuilder: (context, index) {
          var users = friends[index];
          return Card(
            elevation: 0.0,
            child: GestureDetector(
              onTap: () {
                print('Users');
              },
              child: Container(
                padding: EdgeInsets.only(
                    left: 15.0, right: 15.0, top: 10.0, bottom: 10.0),
                child: Column(
                  children: <Widget>[
                    Row(
                      children: <Widget>[
                        Image.asset(
                          users.image,
                          height: 40.0,
                        ),
                        SizedBox(width: 14.0),
                        Text(
                          users.name,
                          style: TextStyle(
                            color: Colors.grey[700],
                            fontSize: 20.0,
                          ),
                        ),
                      ],
                    ),
                  ],
                ),
              ),
            ),
          );
        },
      ),
    );
  }
}

class MyFriends {
  final String image;
  final String name;

  MyFriends({this.image, this.name});
}

final List<MyFriends> friends = [
  MyFriends(image: 'assets/images/leader_board.png', name: 'Ganesh oli'),
  MyFriends(image: 'assets/images/leader_board.png', name: 'Roshan Aryal'),
  MyFriends(image: 'assets/images/leader_board.png', name: 'Roshan Aryal'),
  MyFriends(image: 'assets/images/leader_board.png', name: 'Ganesh oli'),
  MyFriends(image: 'assets/images/leader_board.png', name: 'Ganesh oli'),
  MyFriends(image: 'assets/images/leader_board.png', name: 'Ganesh oli'),
  MyFriends(image: 'assets/images/leader_board.png', name: 'Ganesh oli'),
  MyFriends(image: 'assets/images/leader_board.png', name: 'Dipak oli'),
  MyFriends(image: 'assets/images/leader_board.png', name: 'Ganesh oli'),
  MyFriends(image: 'assets/images/leader_board.png', name: 'Ganesh oli'),
];
