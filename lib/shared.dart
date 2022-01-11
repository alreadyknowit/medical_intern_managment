import 'package:flutter/material.dart';
import 'package:internship_managing_system/student/drafts.dart';

alertDialog( BuildContext context) {
  return showDialog(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(

          content:const Text('Başarıyla kaydedildi'),
          actions: <Widget>[
            TextButton(
              child: const Text('Tamam'),
              onPressed: () {
                Navigator.pushReplacement(context, MaterialPageRoute(builder: (builder)=>Drafts()));
              },
            ),
          ],
        );
      });
}