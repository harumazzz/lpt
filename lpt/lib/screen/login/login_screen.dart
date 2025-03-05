import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class LoginPage extends StatelessWidget {
  const LoginPage({super.key});

  Widget _loginFacebook() {
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
      onPressed: () {},
    );
  }

  Widget _fixedLogo() {
    return Column(
      mainAxisAlignment: MainAxisAlignment.start,
      crossAxisAlignment: CrossAxisAlignment.start,
      spacing: 10.0,
      children: <Widget>[
        const SizedBox.shrink(),
        Center(child: Image.asset('assets/splash_logo.png', width: 50.0, height: 50.0)),
        const SizedBox.shrink(),
        const Center(
          child: Text(
            'LỊCH PHONG THỦY 2019',
            style: TextStyle(color: Color(0xFF0C6A1B), fontWeight: FontWeight.w600, fontSize: 24.0),
          ),
        ),
        const SizedBox(height: 10.0),
      ],
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
            Flexible(flex: 2, child: Center(child: _loginFacebook())),
            Flexible(flex: 1, child: SizedBox.shrink()),
          ],
        ),
      ),
    );
  }
}
