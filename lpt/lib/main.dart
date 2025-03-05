import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:lpt/screen/login/login_screen.dart';

void main() {
  runApp(const Application());
}

class Application extends StatelessWidget {
  const Application({super.key});

  @override
  Widget build(BuildContext context) {
    return CupertinoApp(
      title: 'LPT',
      home: const LoginPage(),
      theme: CupertinoThemeData(brightness: Brightness.light, primaryColor: CupertinoColors.systemOrange),
      debugShowCheckedModeBanner: false,
    );
  }
}
