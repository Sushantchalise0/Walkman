import 'package:flutter/material.dart';
import 'package:flutter_secure_storage/flutter_secure_storage.dart';

class LeaderBoardHeader extends StatefulWidget {
  @override
  _LeaderBoardHeaderState createState() => _LeaderBoardHeaderState();
}

class _LeaderBoardHeaderState extends State<LeaderBoardHeader> {
  FlutterSecureStorage _flutterSecureStorage = FlutterSecureStorage();
  Map<String, dynamic> storage;
  @override
  void initState() {
    super.initState();
    loadStorage();
  }

  loadStorage() async {
    await _flutterSecureStorage.readAll().then((value) {
      setState(() {
        storage = value;
      });
    });
  }

  @override
  Widget build(BuildContext context) {
    return Stack(
      children: <Widget>[
        Container(
          height: 220.0,
          color: Colors.black,
          width: double.infinity,
          child: Image.asset(
            'assets/images/profile/NoPath.png',
            fit: BoxFit.cover,
          ),
        ),
        Align(
          child: Padding(
            padding: const EdgeInsets.only(top: 50.0),
            child: Container(
              child: Center(
                child: CircleAvatar(
                  backgroundImage: NetworkImage(storage['photoUrl'] ?? ''),
                  radius: 60,
                ),
              ),
            ),
          ),
        ),
        Padding(
          padding: const EdgeInsets.only(
            top: 180.0,
          ),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: <Widget>[
              Text(
                storage['displayName'] ?? "",
                style: TextStyle(
                    fontSize: 18,
                    fontWeight: FontWeight.bold,
                    color: Colors.white),
              ),
              // SizedBox(width: 5.0),
              // Container(
              //   width: 60.0,
              //   height: 20.0,
              //   decoration: BoxDecoration(
              //     color: ThemeColor.lightGreen,
              //     borderRadius: BorderRadius.all(
              //       Radius.circular(16.0),
              //     ),
              //   ),
              //   child: Row(
              //     mainAxisAlignment: MainAxisAlignment.center,
              //     children: <Widget>[
              //       // SizedBox(width: 8.0),
              //       Image.asset(
              //         'assets/images/database1.png',
              //       ),
              //       Image.asset(
              //         'assets/images/database.png',
              //       ),
              //       SizedBox(
              //         width: 4.0,
              //       ),
              //       Text(
              //         '0',
              //         style: ThemeText.countText,
              //       ),
              //     ],
              //   ),
              // ),
            ],
          ),
        ),
      ],
    );
  }
}
