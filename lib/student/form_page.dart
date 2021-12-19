import 'package:flutter/material.dart';
import 'package:internship_managing_system/constants.dart';
import 'package:internship_managing_system/models/form_data.dart';

class FormPage extends StatelessWidget {
FormData formData= FormData();
FormPage({Key? key, required this.formData}) : super(key: key);
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.grey[850],
      appBar: AppBar(
        titleSpacing: 1.5,
        centerTitle: true,
        title:  Text(
          formData.kayitNo,
          style: kTextStyle,
        ),
      ),
      body: Container(
        decoration: const BoxDecoration(
          color: Colors.deepPurple,
        ),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            studentFormPageRowInstance('Kayit No', formData.kayitNo),
            studentFormPageRowInstance('Staj Türü', formData.stajTuru),
            studentFormPageRowInstance('Klinik Eğitici', formData.doktor), //TODO implement attending physician
            studentFormPageRowInstance('Hastanın Yaşı', formData.yas),
            studentFormPageRowInstance('Cinsiyet', formData.cinsiyet),
            studentFormPageRowInstance('Şikayet', formData.sikayet),
            studentFormPageRowInstance('Ayırıcı Tanı', formData.ayiriciTani),
            studentFormPageRowInstance('Kesin Tanı', formData.kesinTani),
            studentFormPageRowInstance('Tedavi Yönetimi', formData.tedaviYontemi),
            studentFormPageRowInstance('Kapsamı', formData.kapsam),
            studentFormPageRowInstance('Etkileşim Türü', formData.etkilesimTuru),
            studentFormPageRowInstance('Gerçekleştiği Ortam', formData.gerceklestigiOrtam),
            studentFormPageRowInstance('Tarih', '10.12.2021'), // TODO implement date
          ],
        ),
      ),
    );
  }

  Row studentFormPageRowInstance(String label, String content) {
    return Row(
      mainAxisSize: MainAxisSize.max,
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        Padding(
          padding: const EdgeInsets.all(8.0),
          child: Text(
            '$label:',
            style: kTextStyle.copyWith(
              fontSize: 12,
            ),
          ),
        ),
        const SizedBox(
          width: 5,
        ),
        Text(
          content.toUpperCase(),
          style: kTextStyle.copyWith(fontSize: 20),
        ),
      ],
    );
  }
}
