import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:lpt/bloc/auth_bloc/auth_bloc.dart';
import 'package:lpt/repository/facebook_repository.dart';
import 'package:lpt/screen/login/login_screen.dart';
import 'package:lpt/service/service_locator.dart';

Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp();
  ServiceLocator.injectEnvironment();
  runApp(const Application());
}

class Application extends StatelessWidget {
  const Application({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocProvider<AuthBloc>(
      create:
          (context) => AuthBloc(
            facebookRepository: ServiceLocator.value<FacebookRepository>(),
          ),
      child: CupertinoApp(
        title: 'LPT',
        home: const LoginScreen(),
        theme: CupertinoThemeData(brightness: Brightness.light),
        debugShowCheckedModeBanner: false,
      ),
    );
  }
}
