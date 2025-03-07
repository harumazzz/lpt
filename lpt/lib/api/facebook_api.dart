import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter_facebook_auth/flutter_facebook_auth.dart';

class FacebookApi {
  const FacebookApi();

  Future<UserCredential?> signIn() async {
    try {
      final LoginResult result = await FacebookAuth.instance.login();
      if (result.status == LoginStatus.success) {
        final accessToken = result.accessToken!;
        final credential = FacebookAuthProvider.credential(accessToken.tokenString);
        return await FirebaseAuth.instance.signInWithCredential(credential);
      }
    } catch (e) {
      debugPrint(e.toString());
      throw Exception('Log in failed');
    }
    return null;
  }
}
