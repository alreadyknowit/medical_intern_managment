import 'package:flutter/material.dart';
import 'package:internship_managing_system/models/tibbi_form_data.dart';
import 'package:internship_managing_system/shared/constants.dart';

import 'constants.dart';

class TibbiFormView extends StatelessWidget {
  final TibbiFormData tibbiFormData;

  const TibbiFormView({Key? key, required this.tibbiFormData})
      : super(key: key);
  void handleSubmit() {}
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: TibbiformViewBody(tibbiFormData),
    );
  }
}

Widget TibbiformViewBody(TibbiFormData form) {
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
    TibbiFormData form) {
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
      studentFormPageRowInstance('Ortam', form.getTibbiOrtam()),
      const SizedBox(
        height: 10,
      ),
      Container(),
      const SizedBox(
        height: 10,
      ),
      studentFormPageRowInstance('Dış Kurum', form.getDisKurum()),
      const SizedBox(
        height: 10,
      ),
      studentFormPageRowInstance(
          'Etkileşim Türü', form.getTibbiEtkilesimTuru()),
      const SizedBox(
        height: 5,
      ),
      studentFormPageRowInstance('Tibbi Uygulama', form.getTibbiUygulama()),
      const SizedBox(
        height: 10,
      ),
      studentFormPageRowInstance('Tarih', form.getTarih().toString()),
    ],
  );
}
