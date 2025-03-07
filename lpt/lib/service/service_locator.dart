import 'package:get_it/get_it.dart';
import 'package:lpt/api/facebook_api.dart';
import 'package:lpt/repository/facebook_repository.dart';

class ServiceLocator {
  static final _getIt = GetIt.asNewInstance();

  const ServiceLocator._();

  static void register<T extends Object>(T object) {
    if (!_getIt.isRegistered<T>()) {
      _getIt.registerSingleton(object);
    }
  }

  static void injectEnvironment() {
    register<FacebookRepository>(const FacebookRepository(FacebookApi()));
  }

  static T value<T extends Object>() {
    assert(_getIt.isRegistered<T>(), '$T is not registered');
    return _getIt.get<T>();
  }
}
