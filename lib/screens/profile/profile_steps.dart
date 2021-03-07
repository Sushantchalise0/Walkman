import 'package:flutter/material.dart';
import 'package:flutter_secure_storage/flutter_secure_storage.dart';
import 'package:provider/provider.dart';
import '../../util/colors.dart';
import '../../util/styles.dart';
import '../../provider/botton_click_provider.dart';

// ignore: must_be_immutable
class ProfileSteps extends StatefulWidget {
  @override
  _ProfileStepsState createState() => _ProfileStepsState();
}

class _ProfileStepsState extends State<ProfileSteps> {
  FlutterSecureStorage _flutterSecureStorage = FlutterSecureStorage();
  @override
  void initState() {
    super.initState();
    loadStorage();
    // ignore: deprecated_member_use
//    FirebaseUser user;
    // ignore: deprecated_member_use
    // Firestore.instance.collection('UserInfo').document('user')
    //     // ignore: deprecated_member_use
    //     .setData({
    //   'name': name,
    //   'email': email,
    //   'imgUrl': imageUrl,
    //   'age': null,
    //   'phone': null,
    //   'gender': null,
    // });
  }

  GlobalKey<FormState> _key = GlobalKey();

  bool _validate = false;
  List<DropdownMenuItem<int>> genderList = [];

  void loadGenderList() {
    genderList = [];
    genderList.add(new DropdownMenuItem(
      child: new Text('Male'),
      value: 0,
    ));
    genderList.add(new DropdownMenuItem(
      child: new Text('Female'),
      value: 1,
    ));
  }

  Map<String, dynamic> storageData;

  loadStorage() async {
    await _flutterSecureStorage.readAll().then((value) {
      setState(() {
        storageData = value;
      });
    });
  }

  TextEditingController name2 = TextEditingController();
  TextEditingController email2 = TextEditingController();
  TextEditingController phone1 = TextEditingController();
  TextEditingController age1 = TextEditingController();

  String name1, email1, phone, age;
  int _selectedGender;
  var radioValue = -1;
  @override
  Widget build(BuildContext context) {
    // loadGenderList();
    final buttonClick = Provider.of<BottonClickprovider>(context);
    return buttonClick.isClick == false
        ? IntrinsicHeight(
            child: Padding(
              padding: const EdgeInsets.only(top: 10),
              child: Row(
                children: <Widget>[
                  Expanded(
                    child: Container(
                      height: 100.0,
                      child: Column(
                        children: <Widget>[
                          SizedBox(height: 20.0),
                          Text(
                            'YOUR TOTAL STEPS',
                            style: ThemeText.upperCaseText,
                          ),
                          SizedBox(height: 8.0),
                          Text(
                            '12K',
                            style: ThemeText.userStepsTextCount,
                          )
                        ],
                      ),
                    ),
                  ),
                  VerticalDivider(
                    thickness: 2,
                    width: 20,
                    color: Color(0xFF005A21),
                  ),
                  Expanded(
                    child: Container(
                      // width: MediaQuery.of(context).size.width * 0.5,
                      height: 100.0,
                      child: Column(
                        children: <Widget>[
                          SizedBox(height: 20.0),
                          Text(
                            'TOTAL USERS STEPS',
                            style: ThemeText.upperCaseText,
                          ),
                          SizedBox(height: 8.0),
                          Text(
                            '5M',
                            style: ThemeText.userStepsTextCount,
                          )
                        ],
                      ),
                    ),
                  ),
                ],
              ),
            ),
          )
        : _myInformation(context, buttonClick);
  }

  Widget _myInformation(context, buttonClick) {
    return Column(
      children: <Widget>[
        SizedBox(height: 8.0),
        _infoHeader(context, buttonClick),
        _labelTextField(context, buttonClick),
      ],
    );
  }

  Widget _infoHeader(context, buttonClick) {
    return Padding(
      padding: const EdgeInsets.only(left: 12.0, right: 12.0),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: <Widget>[
          Text(
            'PERSONAL INFO',
            style: ThemeText.infoTitle,
          ),
        ],
      ),
    );
  }

  Widget _labelTextField(context, buttonClick) {
    return Padding(
      padding: const EdgeInsets.only(top: 15.0, left: 12.0),
      child: Form(
        key: _key,
        // ignore: deprecated_member_use
        autovalidate: _validate,
        child: Container(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.end,
            mainAxisAlignment: MainAxisAlignment.start,
            children: <Widget>[
              Row(
                children: <Widget>[
                  Text(
                    'Full Name :',
                    style: ThemeText.subTitle,
                  ),
                  SizedBox(width: 12.0),
                  Container(
                    height: 30.0,
                    width: 250.0,
                    child: TextFormField(
                      autofocus: true,
                      controller: name2,
                      decoration: InputDecoration(
//                        border: OutlineInputBorder(),
                          ),
                      validator: (String value) {
                        if (value.isEmpty) {
                          return 'Name is Required';
                        }
                        return null;
                      },
                      onSaved: (String value) {
                        name1 = value;
                      },
                    ),
                  ),
                ],
              ),
              SizedBox(height: 25.0),
              Row(
                children: <Widget>[
                  Text(
                    'Phone :',
                    style: ThemeText.subTitle,
                  ),
                  SizedBox(width: 38.0),
                  Container(
                    height: 30.0,
                    width: 250.0,
                    child: TextFormField(
                      autofocus: true,
                      controller: phone1,
                      decoration: InputDecoration(
//                        border: OutlineInputBorder(),

                          ),
                      validator: (String value) {
                        if (value.isEmpty) {
                          return 'Phone Number is Required';
                        }
                        if (value.length < 10) {
                          return 'Must be more than 10 digits';
                        }
                        return null;
                      },
                      onSaved: (String value) {
                        phone = value;
                      },
                      keyboardType: TextInputType.phone,
                    ),
                  ),
                ],
              ),
              SizedBox(
                height: 25.0,
              ),
              Row(
                children: <Widget>[
                  Text(
                    'Email id :',
                    style: ThemeText.subTitle,
                  ),
                  SizedBox(width: 28.0),
                  Container(
                    height: 30.0,
                    width: 250.0,
                    child: TextFormField(
                      autofocus: true,
                      controller: email2,
                      decoration: InputDecoration(
//                        border: OutlineInputBorder(),
                          ),
                      validator: (String value) {
                        if (value.isEmpty) {
                          // The form is empty
                          return 'Enter email address';
                        }
                        // This is just a regular expression for email addresses
                        const String p = '[a-zA-Z0-9\+\.\_\%\-\+]{1,256}' +
                            '\\@' +
                            '[a-zA-Z0-9][a-zA-Z0-9\\-]{0,64}' +
                            '(' +
                            '\\.' +
                            '[a-zA-Z0-9][a-zA-Z0-9\\-]{0,25}' +
                            ')+';
                        final RegExp regExp = RegExp(p);

                        if (regExp.hasMatch(value)) {
                          // So, the email is valid
                          return null;
                        }

                        // The pattern of the email didn't match the regex above.
                        return 'Email is not valid';
                      },
                      onSaved: (String value) {
                        email1 = value;
                      },
                    ),
                  ),
                ],
              ),
              SizedBox(height: 25.0),
              Row(
                children: <Widget>[
                  Text(
                    'Gender :',
                    style: ThemeText.subTitle,
                  ),
                  SizedBox(width: 15.0),
                  Flexible(
                    child: Container(
                      width: 150.0,
                      child: DropdownButton(
                          hint: Text('Select Gender'),
                          items: genderList,
                          value: _selectedGender,
                          onChanged: (value) {
                            setState(() {
                              _selectedGender = value;
                            });
                          },
                          elevation: 2,
                          isDense: true,
                          isExpanded: true),
                    ),
                  ),
                  SizedBox(width: 20.0),
                  Row(
                    children: <Widget>[
                      Text(
                        'Age :',
                        style: ThemeText.subTitle,
                      ),
                      SizedBox(width: 8.0),
                      Container(
                        width: 50.0,
                        height: 25.0,
                        child: Center(
                          child: TextFormField(
                            autofocus: true,
                            controller: age1,
                            validator: (String value) {
                              if (value.length == 0 ||
                                  double.parse(value) >= 100) {
                                return ('Required age');
                              }
                              return null;
                            },
                            onSaved: (String value) {
                              age = value;
                            },
                            decoration: InputDecoration(
//                              border: OutlineInputBorder(),

                                ),
                            keyboardType: TextInputType.phone,
                          ),
                        ),
                      ),
                    ],
                  ),
                ],
              ),
              SizedBox(height: 25.0),
              Align(
                alignment: Alignment.bottomLeft,
                child: Row(
                  children: [
                    GestureDetector(
                      onTap: () {
                        print(buttonClick.isClick);
                        if (_key.currentState.validate()) {
                          if (_selectedGender != 0 || _selectedGender == 1) {
                            Scaffold.of(context).showSnackBar(
                              SnackBar(
                                content: Text('Please Select Gender.'),
                              ),
                            );
                          } else {
                            // ignore: deprecated_member_use
//                  FirebaseUser user;
                            _key.currentState.save();
                            // ignore: deprecated_member_use
                            // Firestore.instance
                            //     .collection('UserInfo')
                            //     .document('user')
                            //     .update({
                            //   'name': name1,
                            //   'email': email1,
                            //   'phone': phone,
                            //   'age': age,
                            //   'gender': _selectedGender,
                            // });
                            buttonClick.isClick = !buttonClick.isClick;
                          }
                        }
                      },
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
                            'save',
                            style: TextStyle(
                              color: ThemeColor.darkGreen,
                            ),
                          ),
                        ),
                      ),
                    ),
                    SizedBox(
                      width: 5,
                    ),
                    GestureDetector(
                      onTap: () {
                        buttonClick.isClick = !buttonClick.isClick;
                        print(buttonClick.isClick);
                      },
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
                            'Back',
                            style: TextStyle(
                              color: ThemeColor.darkGreen,
                            ),
                          ),
                        ),
                      ),
                    ),
                  ],
                ),
              )
            ],
          ),
        ),
      ),
    );
  }
}
