import 'package:flutter/material.dart';
import 'package:internship_managing_system/shared/constants.dart';
import 'package:internship_managing_system/student/screens/side_bar.dart';

alertDraft(BuildContext context, String text) {
  return showDialog(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          content: Text(
            text,
            style: TEXT_STYLE,
          ),
          actions: <Widget>[
            ElevatedButton(
              style: ButtonStyle(
                backgroundColor:
                    MaterialStateProperty.all<Color>(PRIMARY_BUTTON_COLOR),
              ),
              child: const Text(
                'Tamam',
                style: TEXT_STYLE,
              ),
              onPressed: () {
                Navigator.pushReplacement(context,
                    MaterialPageRoute(builder: (context) => const SideBar()));
              },
            ),
          ],
        );
      });
}

