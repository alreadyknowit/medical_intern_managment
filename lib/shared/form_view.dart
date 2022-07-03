import 'package:flutter/material.dart';
import 'package:internship_managing_system/shared/constants.dart';

import '../model/PatientLog.dart';
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
      studentFormPageRowInstance('Danışman', form.coordinator!.coordinatorName),
      const SizedBox(
        height: 5,
      ),
      studentFormPageRowInstance(
          'Doktor', form.attendingPhysician!.attendingName),
      const SizedBox(
        height: 5,
      ),
      studentFormPageRowInstance('Student', form.student!.studentName),
      const SizedBox(
        height: 5,
      ),
      studentFormPageRowInstance('Kurum', form.institute!.instituteName),
      const SizedBox(
        height: 5,
      ),
      studentFormPageRowInstance('Kurs', form.course!.courseName),
      const SizedBox(
        height: 5,
      ),
      studentFormPageRowInstance('Uzmanlık', form.speciality!.name),
      const SizedBox(
        height: 5,
      ),
      studentFormPageRowInstance('Kayit No', form.kayitNo!),
      const SizedBox(
        height: 5,
      ),
      studentFormPageRowInstance('Hastanın Yaşı', form.yas.toString()),
      const SizedBox(
        height: 5,
      ),
      studentFormPageRowInstance('Cinsiyet', form.cinsiyet.toString()),
      const SizedBox(
        height: 5,
      ),
      studentFormPageRowInstance('Şikayet', form.sikayet.toString()),
      const SizedBox(
        height: 5,
      ),
      studentFormPageRowInstance('Ayırıcı Tanı', form.ayiriciTani.toString()),
      const SizedBox(
        height: 5,
      ),
      studentFormPageRowInstance('Kesin Tanı', form.kesinTani.toString()),
      const SizedBox(
        height: 5,
      ),
      studentFormPageRowInstance(
          'Tedavi yöntemi', form.tedaviYontemi.toString()),
      const SizedBox(
        height: 5,
      ),
      studentFormPageRowInstance('Kapsam', form.kapsam.toString()),
      const SizedBox(
        height: 5,
      ),
      studentFormPageRowInstance(
          'Etkileşim Türü', form.etkilesimTuru.toString()),
      const SizedBox(
        height: 5,
      ),
      studentFormPageRowInstance(
          'Gerçekleştiği Ortam', form.gerceklestigiOrtam.toString()),
      const SizedBox(
        height: 5,
      ),
      studentFormPageRowInstance('Tarih', form.createdAt.toString()),
    ],
  );
}
