import 'package:flutter/material.dart';
import 'package:internship_managing_system/auth/Screens/Login/components/login.dart';
import 'package:internship_managing_system/main.dart';

import '../Screens/Signup/signup_screen.dart';

class AlreadyHaveAnAccountCheck extends StatelessWidget {
  final bool login=true;

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.center,
      children: <Widget>[
        Text(
          login
              ? "Şifreni mi unuttun?  "
              : "Zaten hesabın var mı? ",

        ),
        GestureDetector(
          onTap:(){
            Navigator.pushReplacement(
              context,
              MaterialPageRoute(
                  builder: (context)=> SignUpScreen()),
            );
          },
          child: Text(
            login ? "Kayıt" : "Giriş",
            style: const TextStyle(
              fontWeight: FontWeight.bold,
            ),
          ),
        ),
      ],
    );
  }
}

class AlreadyHaveAnAccountCheck2 extends StatelessWidget {
  final bool login=false;

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.center,
      children: <Widget>[
        Text(
          login
              ? "Şifreni mi unuttun?  "
              : "Zaten hesabın var mı? ",

        ),
        GestureDetector(
          onTap:(){
            Navigator.pushReplacement(
              context,
              MaterialPageRoute(
                  builder: (context)=> Direct()),
            );
          },
          child: Text(
            login ? "Kayıt" : "Giriş",
            style: const TextStyle(
              fontWeight: FontWeight.bold,
            ),
          ),
        ),
      ],
    );
  }
}
