import 'dart:convert';
import 'package:google_sign_in/google_sign_in.dart';
import 'package:flutter_secure_storage/flutter_secure_storage.dart';
import 'package:http/http.dart' as http;

Future<bool> signInWithGoogle() async {
  try {
    GoogleSignIn _googleSignIn = GoogleSignIn(
      scopes: [
        'email',
      ],
    );

    final user = await _googleSignIn.signIn();

    await http.post('https://peaceful-atoll-49860.herokuapp.com/userExists',
        body: {"email_id": user.email}).then((value) async {
      if (value.body == 'false') {
        await http.post(
            'https://peaceful-atoll-49860.herokuapp.com/details/registration',
            body: {
              "user_img": user.photoUrl,
              "email_id": user.email,
              "user_name": user.displayName
            }).then((value) async {
          if (value.statusCode == 200) {
            var resData = json.decode(value.body);
            FlutterSecureStorage _flutterSecureStorage = FlutterSecureStorage();
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
            body: {"fb_id": user.email}).then((value) async {
          if (value.statusCode == 200) {
            var resData = json.decode(value.body);
            FlutterSecureStorage _flutterSecureStorage = FlutterSecureStorage();
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
    return true;
  } catch (e) {
    print(e);
    return false;
  }
}
