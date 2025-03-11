import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:lpt/repository/facebook_repository.dart';
import 'package:lpt/screen/home/home_screen.dart';
import 'package:lpt/service/service_locator.dart';
import 'dart:developer' as developer;

class LoginScreen extends StatelessWidget {
  const LoginScreen({super.key});

  Widget _loginFacebook(BuildContext context) {
    return TextButton(
      style: ElevatedButton.styleFrom(
        backgroundColor: Color(0xFF4666B3),
        padding: const EdgeInsets.symmetric(vertical: 20.0, horizontal: 12.0),
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.all(Radius.circular(8.0))),
      ),

      child: Text(
        'Đăng nhập bằng Facebook',
        style: TextStyle(color: Colors.white, fontWeight: FontWeight.normal, fontSize: 16.0),
      ),
      onPressed: () async {
        toHome() => Navigator.of(context).push(MaterialPageRoute(builder: (context) => HomeScreen()));
        final userCredential = await ServiceLocator.value<FacebookRepository>().signIn();
        if (userCredential != null) {
          developer.log('Credential: $userCredential');
          toHome();
        }
      },
    );
  }

  Widget _fixedLogo() {
    return SingleChildScrollView(
      child: Column(
        mainAxisAlignment: MainAxisAlignment.start,
        crossAxisAlignment: CrossAxisAlignment.start,
        spacing: 10.0,
        children: <Widget>[
          const SizedBox.shrink(),
          Center(child: Image.asset('assets/logo.png', width: 80.0, height: 80.0)),
          const SizedBox.shrink(),
          const Center(
            child: Text(
              'LỊCH PHONG THỦY 2025',
              style: TextStyle(color: Color(0xFF0C6A1B), fontWeight: FontWeight.w600, fontSize: 24.0),
            ),
          ),
          const SizedBox(height: 10.0),
        ],
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return CupertinoPageScaffold(
      child: SafeArea(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.start,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Flexible(flex: 1, child: _fixedLogo()),
            Flexible(flex: 2, child: Center(child: _loginFacebook(context))),
            const Flexible(flex: 1, child: SizedBox.shrink()),
          ],
        ),
      ),
    );
  }
}
