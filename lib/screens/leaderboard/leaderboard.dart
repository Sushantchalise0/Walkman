import 'package:flutter/material.dart';
import 'package:WalkmanMobile/screens/leaderboard/leader_board_header.dart';
import 'package:WalkmanMobile/util/colors.dart';
import 'package:WalkmanMobile/util/styles.dart';
import 'package:WalkmanMobile/services/leaderBoardService.dart';
import 'package:WalkmanMobile/model/leaderBoardModel.dart';

class Leaderboard extends StatefulWidget {
  @override
  _LeaderboardState createState() => _LeaderboardState();
}

class _LeaderboardState extends State<Leaderboard> {
  LeaderBoardService _leaderBoardService = LeaderBoardService();
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Column(
        children: <Widget>[
          LeaderBoardHeader(),
          // LeaderBoardTabBar(),
          _leaderBoardTabBar(context),
        ],
      ),
    );
  }

  Widget _leaderBoardTabBar(context) {
    return Expanded(
      child: DefaultTabController(
        length: 2,
        child: Column(
          children: <Widget>[
            // Container(
            //   width: 200.0,
            //   height: 25.0,
            //   margin: EdgeInsets.symmetric(vertical: 20.0),
            //   decoration: BoxDecoration(
            //     border: Border.all(
            //       color: ThemeColor.darkGreen,
            //     ),
            //     borderRadius: BorderRadius.circular(3.0),
            //   ),
            //   child: TabBar(
            //     labelPadding: EdgeInsets.all(1),
            //     labelColor: ThemeColor.whiteColor,
            //     unselectedLabelColor: ThemeColor.darkGreen,
            //     indicator: BoxDecoration(
            //       borderRadius: BorderRadius.circular(3.0),
            //       color: ThemeColor.darkGreen,
            //     ),
            //     tabs: [
            //       // Tab(
            //       //   child: Text('FRIENDS'),
            //       // ),
            //       Tab(
            //         child: Text('ALL'),
            //       ),
            //       Tab(
            //         child: Text('WEEKLY'),
            //       ),
            //     ],
            //   ),
            // ),
            // Container(
            //   padding: EdgeInsets.only(left: 20.0, right: 20.0),
            //   height: 40.0,
            //   child: TextField(
            //     decoration: InputDecoration(
            //       prefixIcon: Icon(
            //         Icons.search,
            //         color: Colors.black,
            //       ),
            //       hintText: 'Search Here',
            //       contentPadding: EdgeInsets.all(4.0),
            //       border: OutlineInputBorder(
            //         borderSide: BorderSide(color: Colors.black87),
            //         borderRadius: BorderRadius.all(
            //           Radius.circular(20.0),
            //         ),
            //       ),
            //     ),
            //   ),
            // ),
            Expanded(
              child: TabBarView(children: [
                // _boardUser(context),
                _boardUser(context),
                _boardUser(context),
              ]),
            )
          ],
        ),
      ),
    );
  }

  Widget _boardUser(context) {
    return FutureBuilder<LeaderBoardModel>(
      future: _leaderBoardService.getLeaderBoard(),
      builder: (context, snapshot) {
        if (!snapshot.hasData) {
          return Center(child: CircularProgressIndicator());
        }
        if (snapshot.data.users.length == 0) {
          return Center(child: Text('No Leaderboard Data Available!'));
        }
        return ListView.builder(
          itemCount: snapshot.data.users.length,
          itemBuilder: (context, index) {
            return Card(
              elevation: 0.0,
              child: Container(
                padding: EdgeInsets.only(
                    left: 15.0, right: 15.0, top: 10.0, bottom: 10.0),
                child: Column(
                  children: <Widget>[
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: <Widget>[
                        Row(
                          children: <Widget>[
                            Text(
                              (index + 1).toString(),
                              style: ThemeText.usertextStyle,
                            ),
                            SizedBox(width: 20.0),
                            Image.network(
                              snapshot.data.users[index].detail.userImg,
                              height: 30.0,
                            ),
                            SizedBox(width: 20.0),
                            Text(
                              snapshot.data.users[index].detail.userName,
                              style: ThemeText.usertextStyle,
                            ),
                          ],
                        ),
                        Text(
                          snapshot.data.users[index].distance.toString() +
                              ' step',
                          style: ThemeText.usertextStyle,
                        )
                      ],
                    )
                  ],
                ),
              ),
            );
          },
        );
      },
    );
  }

  void _inviteUsers(context) {
    showGeneralDialog(
      barrierColor: Colors.black.withOpacity(0.5),
      transitionBuilder: (context, a1, a2, widget) {
        return Transform.scale(
          scale: a1.value,
          child: Opacity(
            opacity: a1.value,
            child: AlertDialog(
              shape:
                  OutlineInputBorder(borderRadius: BorderRadius.circular(16.0)),
              title: Text('Hello, Do you want to invite?'),
              content: Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: <Widget>[
                  GestureDetector(
                    onTap: () {
                      print('User invited');
                      Navigator.pop(context);
                    },
                    child: Container(
                      decoration: BoxDecoration(
                          color: Colors.blue,
                          borderRadius:
                              BorderRadius.all(Radius.circular(10.0))),
                      padding: EdgeInsets.all(5.0),
                      child: Text(
                        'Invite',
                        style: ThemeText.subTitle,
                      ),
                    ),
                  ),
                  SizedBox(width: 14.0),
                  GestureDetector(
                    onTap: () {
                      Navigator.pop(context);
                    },
                    child: Container(
                      decoration: BoxDecoration(
                          color: Colors.red,
                          borderRadius:
                              BorderRadius.all(Radius.circular(10.0))),
                      padding: EdgeInsets.all(5.0),
                      child: Text(
                        'Cancel',
                        style: ThemeText.subTitle,
                      ),
                    ),
                  ),
                ],
              ),
            ),
          ),
        );
      },
      transitionDuration: Duration(milliseconds: 200),
      barrierDismissible: true,
      barrierLabel: '',
      context: context,
      pageBuilder: (context, animation1, animation2) {
        return null;
      },
    );
  }
}

class LeaderBoardUser {
  final int id;
  final String image;
  final String name;
  final int stepCount;

  LeaderBoardUser({this.id, this.image, this.name, this.stepCount});
}

List<LeaderBoardUser> leaderBoardUser = [
  LeaderBoardUser(
    id: 1,
    image: 'assets/images/leader_board.png',
    name: 'Ganesh oli',
    stepCount: 1234,
  ),
  LeaderBoardUser(
    id: 2,
    image: 'assets/images/leader_board.png',
    name: 'Roshan Aryal',
    stepCount: 5678,
  ),
  LeaderBoardUser(
    id: 3,
    image: 'assets/images/leader_board.png',
    name: 'Rajesh Hamal',
    stepCount: 9101,
  ),
  LeaderBoardUser(
    id: 4,
    image: 'assets/images/leader_board.png',
    name: 'Ganesh oli',
    stepCount: 1213,
  ),
  LeaderBoardUser(
    id: 5,
    image: 'assets/images/leader_board.png',
    name: 'Ganesh oli',
    stepCount: 1213,
  ),
  LeaderBoardUser(
    id: 6,
    image: 'assets/images/leader_board.png',
    name: 'Ganesh oli',
    stepCount: 1213,
  ),
  LeaderBoardUser(
    id: 7,
    image: 'assets/images/leader_board.png',
    name: 'Ganesh oli',
    stepCount: 1213,
  ),
  LeaderBoardUser(
    id: 8,
    image: 'assets/images/leader_board.png',
    name: 'Ganesh oli',
    stepCount: 1213,
  ),
  LeaderBoardUser(
    id: 9,
    image: 'assets/images/leader_board.png',
    name: 'Dipak oli',
    stepCount: 1213,
  ),
];
