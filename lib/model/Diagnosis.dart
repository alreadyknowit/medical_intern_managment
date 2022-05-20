import 'package:internship_managing_system/model/Speciality.dart';

class Diagnosis {
  int id;
  String diagnosisName;
  Speciality speciality;

  Diagnosis(
      {required this.id,
      required this.diagnosisName,
      required this.speciality});

  factory Diagnosis.fromJSON(Map<String, dynamic> map) {
    return Diagnosis(
        id: map['id'],
        diagnosisName: map['name'],
        speciality: map['speciality']);
  }
}
