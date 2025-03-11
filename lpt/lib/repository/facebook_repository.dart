import 'package:lpt/api/facebook_api.dart';

class FacebookRepository {
  final FacebookApi _facebookApi;

  const FacebookRepository(this._facebookApi);

  Future<Map<String, dynamic>?> signIn() async {
    return await _facebookApi.signIn();
  }
}
