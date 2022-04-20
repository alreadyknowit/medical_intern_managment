import 'package:internship_managing_system/model/Institute.dart';
import 'package:internship_managing_system/model/Speciality.dart';

class AttendingPhysician {
  int id;
  String attendingName;
  String phoneNo;
  Speciality speciality;
  Institute institute;

  AttendingPhysician(
      {required this.id,
      required this.attendingName,
      required this.phoneNo,
      required this.speciality,
      required this.institute});

  factory AttendingPhysician.fromJSON(Map<String, dynamic> map) {
    return AttendingPhysician(
        id: map['id'],
        attendingName: map['attendingName'],
        speciality: Speciality.fromJSON(map['speciality']),
        institute: Institute.fromJSON(map['institute']),
        phoneNo: map['phoneNo']);
  }
  Map<String, dynamic> toJson() => {
        'id': id,
        'attendingName': attendingName,
        'speciality': speciality,
        'institute': institute,
        'phoneNo': phoneNo
      };
}
