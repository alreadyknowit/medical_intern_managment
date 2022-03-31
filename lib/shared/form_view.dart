import 'package:flutter/material.dart';
import 'package:internship_managing_system/models/form_data.dart';
import 'package:internship_managing_system/shared/constants.dart';

import 'constants.dart';

class FormView extends StatelessWidget {
  final FormData formData;

  const FormView({Key? key, required this.formData}) : super(key: key);
  void handleSubmit() {}
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: formViewBody(formData),
    );
  }
}

Widget formViewBody(FormData form) {
  Row studentFormPageRowInstance(String label, String content) {
    return Row(
      mainAxisSize: MainAxisSize.max,
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        Padding(
          padding: const EdgeInsets.all(8.0),
          child: Text('${label.toUpperCase()}:',
              overflow: TextOverflow.ellipsis, maxLines: 10, style: TEXT_STYLE),
        ),
        const SizedBox(
          width: 5,
        ),
        Expanded(
          child: Text(content, style: TEXT_STYLE),
        ),
      ],
    );
  }

  return SafeArea(
    child: Center(
      child: Container(
        decoration: BoxDecoration(
          color: BACKGROUND_COLOR,
          borderRadius: BorderRadius.circular(10),
        ),
        child: SingleChildScrollView(
          child: columnForm(studentFormPageRowInstance, form),
        ),
      ),
    ),
  );
}

Column columnForm(
    Row Function(String label, String content) studentFormPageRowInstance,
    FormData form) {
  return Column(
    mainAxisAlignment: MainAxisAlignment.center,
    children: [
      studentFormPageRowInstance('Kayit No', form.getKayitNo()),
      const SizedBox(
        height: 10,
      ),
      studentFormPageRowInstance('Staj Türü', form.getStajTuru()),
      const SizedBox(
        height: 10,
      ),
      studentFormPageRowInstance('Klinik Eğitici', form.getDoktor()),
      const SizedBox(
        height: 10,
      ),
      studentFormPageRowInstance('Hastanın Yaşı', form.getYas().toString()),
      const SizedBox(
        height: 10,
      ),
      form.getCinsiyet().isNotEmpty
          ? studentFormPageRowInstance('Cinsiyet', form.getCinsiyet())
          : Container(),
      const SizedBox(
        height: 10,
      ),
      studentFormPageRowInstance('Şikayet', form.getSikayet()),
      const SizedBox(
        height: 10,
      ),
      studentFormPageRowInstance('Ayırıcı Tanı', form.getAyiriciTani()),
      const SizedBox(
        height: 5,
      ),
      studentFormPageRowInstance('Kesin Tanı', form.getKesinTani()),
      const SizedBox(
        height: 10,
      ),
      studentFormPageRowInstance('Tedavi YÖNTEMİ', form.getTedaviYontemi()),
      const SizedBox(
        height: 10,
      ),
      studentFormPageRowInstance('Kapsamı', form.getKapsam()),
      const SizedBox(
        height: 10,
      ),
      studentFormPageRowInstance('Etkileşim Türü', form.getEtkilesimTuru()),
      const SizedBox(
        height: 10,
      ),
      studentFormPageRowInstance('Gerçekleştiği Ortam', form.getOrtam()),
      const SizedBox(
        height: 10,
      ),
      studentFormPageRowInstance('Tarih', form.getTarih().toString()),
    ],
  );
}
