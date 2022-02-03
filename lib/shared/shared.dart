import 'package:flutter/material.dart';
import 'package:internship_managing_system/shared/constants.dart';
import 'package:internship_managing_system/student/models/form_data.dart';
import 'package:internship_managing_system/student/side_bar.dart';

alertDraft(BuildContext context, String text) {
  return showDialog(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          backgroundColor: const Color(0xfffcba03),
          content: Text(
            text,
            style: kTextStyle.copyWith(color: Colors.white),
          ),
          actions: <Widget>[
            ElevatedButton(
              style: ButtonStyle(
                backgroundColor:
                    MaterialStateProperty.all<Color>(Colors.orange),
              ),
              child: Text(
                'Tamam',
                style: kTextStyle.copyWith(color: Colors.white),
              ),
              onPressed: () {
                Navigator.pushReplacement(context,
                    MaterialPageRoute(builder: (context) => SideBar()));
              },
            ),
          ],
        );
      });
}

alertSent(BuildContext context) {
  return showDialog(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          backgroundColor: const Color(0xfffcba03),
          content: Text('Başarıyla kaydedildi',
              style: kTextStyle.copyWith(color: Colors.white)),
          actions: <Widget>[
            ElevatedButton(
              style: ButtonStyle(
                backgroundColor:
                    MaterialStateProperty.all<Color>(Colors.orange),
              ),
              child: Text(
                'Tamam',
                style: kTextStyle.copyWith(color: Colors.white),
              ),
              onPressed: () {
                Navigator.pushReplacement(context,
                    MaterialPageRoute(builder: (builder) => const SideBar()));
              },
            ),
          ],
        );
      });
}

ListTile customListTile(Color color, Function onTap, FormData formData,
    int index, bool Function() onLongPressed) {
  return ListTile(
    contentPadding: EdgeInsets.all(20),
    onTap: () => onTap(formData),
    leading: Text(formData.getKayitNo()),
    title: Text(formData.getStajTuru()),
    subtitle: Text(formData.getDoktor()),
    isThreeLine: true,
    trailing: onLongPressed()
        ? const Icon(Icons.check)
        : const Icon(Icons.exit_to_app),
    onLongPress: () {},
  );
}
