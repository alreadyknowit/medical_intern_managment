import 'package:flutter/material.dart';
import 'package:internship_managing_system/shared/constants.dart';

import '../model/PatientLog.dart ';
import 'constants.dart';

class FormView extends StatelessWidget {
  final PatientLog formData;

  const FormView({Key? key, required this.formData}) : super(key: key);
  void handleSubmit() {}
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: formViewBody(formData),
    );
  }
}

Widget formViewBody(PatientLog form) {
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
    PatientLog form) {
  return Column(
    mainAxisAlignment: MainAxisAlignment.center,
    children: [
      studentFormPageRowInstance('Kayit No', form.kayitNo.toString()),
      const SizedBox(
        height: 10,
      ),
      studentFormPageRowInstance('Institute', form.instute.toString()),
      const SizedBox(
        height: 10,
      ),
      studentFormPageRowInstance('Course', form.course.toString()),
      const SizedBox(
        height: 10,
      ),
      studentFormPageRowInstance('Speciality', form.speciality.toString()),
      const SizedBox(
        height: 10,
      ),
      studentFormPageRowInstance(
          'Klinik Eğitici', form.attendingPhysician.toString()),
      const SizedBox(
        height: 10,
      ),
      studentFormPageRowInstance('Hastanın Yaşı', form.yas.toString()),
      const SizedBox(
        height: 10,
      ),
      studentFormPageRowInstance('Cinsiyet', form.cinsiyet.toString()),
      const SizedBox(
        height: 10,
      ),
      studentFormPageRowInstance('Şikayet', form.sikayet.toString()),
      const SizedBox(
        height: 10,
      ),
      studentFormPageRowInstance('Ayırıcı Tanı', form.ayiriciTani.toString()),
      const SizedBox(
        height: 5,
      ),
      studentFormPageRowInstance('Kesin Tanı', form.kesinTani.toString()),
      const SizedBox(
        height: 10,
      ),
      studentFormPageRowInstance(
          'Tedavi YÖNTEMİ', form.tedaviYontemi.toString()),
      const SizedBox(
        height: 10,
      ),
      studentFormPageRowInstance('Kapsamı', form.kapsam.toString()),
      const SizedBox(
        height: 10,
      ),
      studentFormPageRowInstance(
          'Etkileşim Türü', form.etkilesimTuru.toString()),
      const SizedBox(
        height: 10,
      ),
      studentFormPageRowInstance(
          'Gerçekleştiği Ortam', form.gerceklestigiOrtam.toString()),
      const SizedBox(
        height: 10,
      ),
      studentFormPageRowInstance('Tarih', form.createdAt.toString()),
    ],
  );
}
