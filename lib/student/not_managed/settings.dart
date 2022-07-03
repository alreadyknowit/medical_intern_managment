import 'package:flutter/material.dart';
import 'package:internship_managing_system/auth/Screens/Login/components/login.dart';
import 'package:internship_managing_system/main.dart';
import 'package:shared_preferences/shared_preferences.dart';

class Settings extends StatelessWidget {
  const Settings({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return TextButton(
      child: const Text('Çıkış'),
      onPressed: () async {
        SharedPreferences preferences = await SharedPreferences.getInstance();
        preferences.remove('newUser');
        preferences.remove('role');
        preferences.remove('oasisId');
        preferences.remove('id');
        preferences.remove('name');

        Navigator.pushReplacement(
          context,
          MaterialPageRoute(builder: (context) => Direct()),
        );
      },
    );
  }
}
