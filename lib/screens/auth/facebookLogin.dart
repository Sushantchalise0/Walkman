import 'dart:convert';

import 'package:flutter_facebook_login/flutter_facebook_login.dart';
import 'package:flutter_secure_storage/flutter_secure_storage.dart';
import 'package:http/http.dart' as http;

Future<int> login() async {
  final FacebookLogin facebookSignIn = new FacebookLogin();
  final FacebookLoginResult result = await facebookSignIn.logIn(['email']);

  switch (result.status) {
    case FacebookLoginStatus.loggedIn:
      final FacebookAccessToken accessToken = result.accessToken;
      int resultValue = await loginuser(accessToken.token);
      return resultValue;
    case FacebookLoginStatus.cancelledByUser:
      return 1;
    case FacebookLoginStatus.error:
      return 2;
  }
}

Future<int> loginuser(String token) async {
  try {
    await http
        .get(
            "https://graph.facebook.com/v2.12/me?fields=name,first_name,last_name,email,picture&access_token=" +
                token)
        .then((value) async {
      final responseBody = json.decode(value.body);
      await http.post('https://peaceful-atoll-49860.herokuapp.com/userExists',
          body: {"email_id": responseBody["email"]}).then((value) async {
        if (value.body == 'false') {
          await http.post(
              'https://peaceful-atoll-49860.herokuapp.com/details/registration',
              body: {
                "user_img": responseBody["picture"]["data"]["url"],
                "email_id": responseBody["email"],
                "user_name": responseBody["name"]
              }).then((value) async {
            if (value.statusCode == 200) {
              var resData = json.decode(value.body);
              FlutterSecureStorage _flutterSecureStorage =
                  FlutterSecureStorage();
              await _flutterSecureStorage.write(
                  key: 'detail', value: resData['_id']);
              await _flutterSecureStorage.write(
                  key: 'displayName', value: resData['user_name']);
              await _flutterSecureStorage.write(
                  key: 'email', value: resData['email_id']);
              await _flutterSecureStorage.write(
                  key: 'photoUrl', value: resData['user_img']);
            }
          });
        } else {
          await http.post(
              'https://peaceful-atoll-49860.herokuapp.com/details/getDetails',
              body: {"fb_id": responseBody["email"]}).then((value) async {
            if (value.statusCode == 200) {
              var resData = json.decode(value.body);
              FlutterSecureStorage _flutterSecureStorage =
                  FlutterSecureStorage();
              await _flutterSecureStorage.write(
                  key: 'detail', value: resData['_id']);
              await _flutterSecureStorage.write(
                  key: 'displayName', value: resData['user_name']);
              await _flutterSecureStorage.write(
                  key: 'email', value: resData['email_id']);
              await _flutterSecureStorage.write(
                  key: 'photoUrl', value: resData['user_img']);
              print(await _flutterSecureStorage.readAll());
            }
          });
        }
      });
    });
    return 0;
  } catch (e) {
    return 2;
  }
}
