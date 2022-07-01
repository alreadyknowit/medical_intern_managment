import 'package:internship_managing_system/model/Institute.dart';

import '../student/services/StudentDatabaseHelper.dart';

Future getInstitues() async {
  List<Institute> institutes = [];
  String? selectedInstitute = "Ins1";
  await StudentDatabaseHelper().fetchInstitute().then((response) {
//      print(data);

    institutes = response;
    selectedInstitute = institutes[0].instituteName;

    /*  institutes.forEach((element) {
        print(element.instituteName);
      });*/
  });
}
