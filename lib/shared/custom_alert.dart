import 'package:flutter/material.dart';
import 'package:internship_managing_system/shared/constants.dart';

Future<void> showMyDialog(BuildContext context) async {
  return showDialog<void>(
    context: context,
    barrierDismissible: false, // user must tap button!
    builder: (BuildContext context) {
      return AlertDialog(
        title: const Text('Hata'),
        content: SingleChildScrollView(
          child: ListBody(
            children: [
              Text(
                'Bir hata oluştu!',
                style: TEXT_STYLE,
              ),
              Text(
                'Lütfen tekrar deneyin.',
                style: TEXT_STYLE,
              ),
            ],
          ),
        ),
        actions: <Widget>[
          TextButton(
            style: TextButton.styleFrom(backgroundColor: PRIMARY_BUTTON_COLOR),
            child:  Text('Tekrar dene', style: TEXT_STYLE.copyWith(color: Colors.white)),
            onPressed: () {
              Navigator.of(context).pop();
            },
          ),
        ],
      );
    },
  );
}
