import 'package:flutter/material.dart';
import 'package:internship_managing_system/shared/constants.dart';
import 'package:internship_managing_system/student/drafts.dart';
import 'package:internship_managing_system/student/sent_forms.dart';
import 'package:internship_managing_system/models/form_data.dart';
import 'package:internship_managing_system/student/side_bar.dart';




alertDraft( BuildContext context,String text) {
  return showDialog(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          backgroundColor: const Color(0xfffcba03),
          content: Text(text, style: kTextStyle.copyWith(color: Colors.white),),
          actions: <Widget>[
            ElevatedButton(
              style: ButtonStyle(
                backgroundColor:MaterialStateProperty.all<Color>(Colors.orange),
              ),
              child:  Text('Tamam', style: kTextStyle.copyWith(color: Colors.white),),
             onPressed: (){
                Navigator.push(context, MaterialPageRoute(builder:(context)=>SideBar()));
        },

            ),
          ],
        );
      });
}
alertSent( BuildContext context) {
  return showDialog(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          backgroundColor: const Color(0xfffcba03),
          content: Text('Başarıyla kaydedildi', style: kTextStyle.copyWith(color: Colors.white)),
          actions: <Widget>[
            ElevatedButton(
              style: ButtonStyle(
                backgroundColor:MaterialStateProperty.all<Color>(Colors.orange),
              ),
              child:  Text('Tamam', style: kTextStyle.copyWith(color: Colors.white),),
              onPressed:() {
                Navigator.push(context, MaterialPageRoute(builder: (builder)=>const SideBar()));
              },
            ),
          ],
        );
      });
}


ListTile customListTile(Color color, Function onTap, FormData formData,int index,bool Function() onLongPressed) {
  return ListTile(
    hoverColor: Colors.orange,
      onTap: ()=>onTap(formData),
    leading:Text(formData.getKayitNo()) ,
    title: Text(formData.getStajTuru()),
    subtitle: Text(formData.getDoktor()),
    isThreeLine: true,
    trailing:  onLongPressed() ? const Icon(Icons.check) : const Icon(Icons.exit_to_app),
    onLongPress:(){

    },
  );
  }