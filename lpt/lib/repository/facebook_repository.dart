import 'package:lpt/api/facebook_api.dart';
import 'package:lpt/model/system_user.dart';

class FacebookRepository {
  final FacebookApi _facebookApi;

  const FacebookRepository(this._facebookApi);

  Future<SystemUser?> signIn() async {
    return await _facebookApi.signIn();
  }
}
