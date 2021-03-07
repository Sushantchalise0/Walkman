import 'package:flutter_secure_storage/flutter_secure_storage.dart';
import 'package:google_sign_in/google_sign_in.dart';

class GoogleLogin {
  Future googleLogin() async {
    try {
      GoogleSignIn _googleSignIn = GoogleSignIn();

      await _googleSignIn.signIn().then((value) async {
        FlutterSecureStorage _flutterSecureStorage = FlutterSecureStorage();
        await _flutterSecureStorage.write(
            key: 'displayName', value: value.displayName);
        await _flutterSecureStorage.write(key: 'email', value: value.email);
        await _flutterSecureStorage.write(
            key: 'photoUrl', value: value.photoUrl);
        return true;
      });
    } catch (error) {
      return false;
    }
  }
}

// 'https://graph.facebook.com/v2.12/me?fields=name,first_name,last_name,email&access_token=${token}'