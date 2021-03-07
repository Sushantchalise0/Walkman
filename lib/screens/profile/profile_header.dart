import 'dart:io';

import 'package:flutter/material.dart';
import 'package:flutter_secure_storage/flutter_secure_storage.dart';
import 'package:provider/provider.dart';
import '../../provider/botton_click_provider.dart';
import '../../util/styles.dart';

class ProfileHeader extends StatefulWidget {
  @override
  _ProfileHeaderState createState() => _ProfileHeaderState();
}

class _ProfileHeaderState extends State<ProfileHeader> {
  FlutterSecureStorage _flutterSecureStorage = FlutterSecureStorage();
  File _pickedImage;

  // _loadPicker(ImageSource source) async {
  //   // ignore: deprecated_member_use
  //   File picked = await ImagePicker.pickImage(source: source);
  //   if (picked == null) {
  //     _cropImage(picked);
  //   }
  //   Navigator.pop(context);
  // }
// 
  // _cropImage(File picked) async {
  //   File cropped = await ImageCropper.cropImage(
  //       sourcePath: picked.path,
  //       aspectRatio: CropAspectRatio(ratioX: 1.0, ratioY: 1.0),
  //       aspectRatioPresets: [
  //         CropAspectRatioPreset.original,
  //         CropAspectRatioPreset.ratio16x9,
  //         CropAspectRatioPreset.ratio4x3,
  //       ]);
  //   if (cropped != null) {
  //     setState(() {
  //       _pickedImage = cropped;
  //     });
  //   }
  // }

  // void _showPickOptionDialog(BuildContext context) {
  //   showDialog(
  //       context: context,
  //       builder: (context) => AlertDialog(
  //             title: Text('Make a Choice'),
  //             content: Column(
  //               mainAxisSize: MainAxisSize.min,
  //               children: [
  //                 ListTile(
  //                   title: Text('Pick From Gallery'),
  //                   onTap: () {
  //                     _loadPicker(ImageSource.gallery);
  //                   },
  //                 ),
  //                 ListTile(
  //                   title: Text('Take a Picture'),
  //                   onTap: () {
  //                     _loadPicker(ImageSource.camera);
  //                   },
  //                 ),
  //               ],
  //             ),
  //           ));
  // }

  Map<String, dynamic> storageData;

  loadStorage() async {
    await _flutterSecureStorage.readAll().then((value) {
      setState(() {
        storageData = value;
      });
    });
  }

  @override
  void initState() {
    loadStorage();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    final buttonClick = Provider.of<BottonClickprovider>(context);

    return Stack(
      children: <Widget>[
        Container(
          height: 250.0,
          color: Colors.black,
          // width: MediaQuery.of(context).size.width,
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
                  backgroundImage: _pickedImage != null
                      ? FileImage(_pickedImage)
                      : NetworkImage(storageData['photoUrl'] ?? ''),
                  radius: 60,
                ),
              ),
            ),
          ),
        ),
        Align(
          child: Padding(
            padding: const EdgeInsets.only(top: 170.0),
            child: Text(
              storageData['displayName'] ?? '',
              style: ThemeText.userNameText,
            ),
          ),
        ),
        // Align(
        //   child: Padding(
        //     padding: const EdgeInsets.only(top: 200.0, left: 50.0, right: 50.0),
        //     child: FAProgressBar(
        //       progressColor: ThemeColor.lightGreen,
        //       backgroundColor: ThemeColor.darkGrey,
        //       borderRadius: 5.0,
        //       size: 18.0,
        //       currentValue: 70,
        //       displayText: '',
        //     ),
        //   ),
        // ),
        // buttonClick.isClick == false
            // ? Align(
            //     child: Padding(
            //       padding: const EdgeInsets.only(top: 140.0, left: 90.0),
            //       child: GestureDetector(
            //         onTap: () {
            //           buttonClick.isClick = !buttonClick.isClick;
            //           print(buttonClick.isClick);
            //         },
            //         child: CircleAvatar(
            //           radius: 15.0,
            //           backgroundColor: ThemeColor.darkGreen,
            //           child: Icon(
            //             Icons.edit,
            //             size: 10,
            //             color: ThemeColor.whiteColor,
            //           ),
            //         ),
            //       ),
            //     ),
            //   )
            // : Container(),
      ],
    );
  }
}
