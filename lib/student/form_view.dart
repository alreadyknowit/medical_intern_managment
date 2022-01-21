import 'package:flutter/material.dart';
import 'package:internship_managing_system/shared/constants.dart';
import 'package:internship_managing_system/models/form_data.dart';

class FormView extends StatelessWidget {
final FormData formData;
const FormView({Key? key, required this.formData}) : super(key: key);
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        titleSpacing: 1.5,
        centerTitle: true,
        title:  Text(
          formData.getKayitNo(),
          style: kTextStyle,
        ),
      ),
      body: Container(
        decoration: const BoxDecoration(
          color: Colors.white,
        ),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            studentFormPageRowInstance('Kayit No', formData.getKayitNo()),
            studentFormPageRowInstance('Staj Türü', formData.getStajTuru()),
            studentFormPageRowInstance('Klinik Eğitici', formData.getDoktor()),
            studentFormPageRowInstance('Hastanın Yaşı', formData.getYas()),
            studentFormPageRowInstance('Cinsiyet', formData.getCinsiyet()),
            studentFormPageRowInstance('Şikayet', formData.getSikayet()),
            studentFormPageRowInstance('Ayırıcı Tanı', formData.getAyiriciTani()),
            studentFormPageRowInstance('Kesin Tanı', formData.getKesinTani()),
            studentFormPageRowInstance('Tedavi Yönetimi', formData.getTedaviYontemi()),
            studentFormPageRowInstance('Kapsamı', formData.getKapsam()),
            studentFormPageRowInstance('Etkileşim Türü', formData.getEtkilesimTuru()),
            studentFormPageRowInstance('Gerçekleştiği Ortam', formData.getOrtam()),
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
