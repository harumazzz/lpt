import 'package:firebase_auth/firebase_auth.dart';
import 'package:lpt/api/facebook_api.dart';

class FacebookRepository {
  final FacebookApi _facebookApi;

  const FacebookRepository(this._facebookApi);

  Future<UserCredential?> signIn() async {
    return await _facebookApi.signIn();
  }
}
