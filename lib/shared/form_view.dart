import 'package:flutter/material.dart';
import 'package:internship_managing_system/shared/constants.dart';
import 'package:internship_managing_system/models/form_data.dart';

class FormView extends StatelessWidget {
  final FormData formData;
  const FormView({Key? key, required this.formData}) : super(key: key);
  @override
  Widget build(BuildContext context) {
    return  Container(
      decoration:  BoxDecoration(
       color: BACKGROUND_COLOR,
        borderRadius: BorderRadius.circular(10),
      ),
      child: SingleChildScrollView(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            studentFormPageRowInstance('Kayit No', formData.getKayitNo()),
            const SizedBox(height: 10,),
            studentFormPageRowInstance('Staj Türü', formData.getStajTuru()),
            const SizedBox(height: 10,),
            studentFormPageRowInstance('Klinik Eğitici', formData.getDoktor()),
            const SizedBox(height: 10,),
            studentFormPageRowInstance('Hastanın Yaşı', formData.getYas().toString()),
            const SizedBox(height: 10,),
            studentFormPageRowInstance('Cinsiyet', formData.getCinsiyet()),
            const SizedBox(height: 10,),
            studentFormPageRowInstance('Şikayet', formData.getSikayet()),
            const SizedBox(height: 10,),
            studentFormPageRowInstance('Ayırıcı Tanı', formData.getAyiriciTani()),
            const SizedBox(height: 5,),
            studentFormPageRowInstance('Kesin Tanı', formData.getKesinTani()),
            const SizedBox(height: 10,),
            studentFormPageRowInstance('Tedavi YÖNTEMİ', formData.getTedaviYontemi()),
            const SizedBox(height: 10,),
            studentFormPageRowInstance('Kapsamı', formData.getKapsam()),
            const SizedBox(height: 10,),
            studentFormPageRowInstance(
                'Etkileşim Türü', formData.getEtkilesimTuru()),
            const SizedBox(height: 10,),
            studentFormPageRowInstance(
                'Gerçekleştiği Ortam', formData.getOrtam()),
            const SizedBox(height: 10,),
            studentFormPageRowInstance(
                'Tarih', formData.getTarih()!),
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
            '${label.toUpperCase()}:',
            overflow: TextOverflow.ellipsis,
            maxLines: 10,
            style: TEXT_STYLE
          ),
        ),
        const SizedBox(
          width: 5,
        ),
        Expanded(
          child: Text(
            content,
            style: TEXT_STYLE

          ),
        ),
      ],
    );
  }
}
