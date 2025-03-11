import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter_facebook_auth/flutter_facebook_auth.dart';
import 'dart:developer' as developer;

class FacebookApi {
  const FacebookApi();

  Future<Map<String, dynamic>?> signIn() async {
    try {
      final LoginResult result = await FacebookAuth.instance.login(
        permissions: ['email', 'public_profile', 'user_birthday'],
      );
      if (result.status == LoginStatus.success) {
        final accessToken = result.accessToken!;
        final credential = FacebookAuthProvider.credential(accessToken.tokenString);
        await FirebaseAuth.instance.signInWithCredential(credential);
        final userData = await FacebookAuth.instance.getUserData(fields: 'id, name, birthday');
        return userData;
      }
    } catch (e) {
      developer.log('Error found: $e');
      throw Exception('Log in failed');
    }
    return null;
  }
}
