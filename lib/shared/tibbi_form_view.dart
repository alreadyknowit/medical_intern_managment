import 'package:flutter/material.dart';
import 'package:internship_managing_system/model/ProcedureLog.dart';
import 'package:internship_managing_system/shared/constants.dart';

import 'constants.dart';

class TibbiFormView extends StatelessWidget {
  final ProcedureLog tibbiFormData;

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

Widget TibbiformViewBody(ProcedureLog form) {
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
    child: Scaffold(
        appBar: AppBar(
          centerTitle: true,
          title: const Text('Tibbi Uygulama Formu'),
        ),
        body: Center(
          child: Container(
            decoration: BoxDecoration(
              color: BACKGROUND_COLOR,
              borderRadius: BorderRadius.circular(10),
            ),
            child: SingleChildScrollView(
              child: columnForm(studentFormPageRowInstance, form),
            ),
          ),
        )),
  );
}

Column columnForm(
    Row Function(String label, String content) studentFormPageRowInstance,
    ProcedureLog form) {
  return Column(
    mainAxisAlignment: MainAxisAlignment.center,
    children: [
      studentFormPageRowInstance('Kayit No', form.kayitNo.toString()),
      const SizedBox(
        height: 10,
      ),
      studentFormPageRowInstance('Kurs', form.course!.courseName),
      const SizedBox(
        height: 10,
      ),
      studentFormPageRowInstance('Staj T??r??', form.speciality!.name),
      const SizedBox(
        height: 10,
      ),
      studentFormPageRowInstance(
          'Tibbi Uygulama', form.tibbiUygulama.toString()),
      const SizedBox(
        height: 10,
      ),
      studentFormPageRowInstance(
          'Etkile??im T??r??', form.etkilesimTuru.toString()),
      const SizedBox(
        height: 10,
      ),
      studentFormPageRowInstance(
          'Ger??ekle??ti??i Ortam', form.gerceklestigiOrtam.toString()),
      const SizedBox(
        height: 10,
      ),
      studentFormPageRowInstance('Tarih', form.createdAt.toString()),
      const SizedBox(
        height: 10,
      ),
      studentFormPageRowInstance(
          'Klinik E??itici', form.attendingPhysician!.attendingName),
      const SizedBox(
        height: 10,
      ),
      Container(),
      const SizedBox(
        height: 10,
      ),
      const SizedBox(
        height: 5,
      ),
    ],
  );
}
