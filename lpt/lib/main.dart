import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/cupertino.dart';
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
    return CupertinoApp(
      title: 'LPT',
      home: const LoginScreen(),
      theme: CupertinoThemeData(brightness: Brightness.light, primaryColor: CupertinoColors.systemOrange),
      debugShowCheckedModeBanner: false,
    );
  }
}
