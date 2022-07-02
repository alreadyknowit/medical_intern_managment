import 'package:internship_managing_system/model/Institute.dart';
import 'package:internship_managing_system/model/Speciality.dart';

class AttendingPhysician {
  int id;
  String attendingName;
  int specialityId;
  int instituteId;
  String phoneNo;


  AttendingPhysician({
    required this.id, required this.attendingName, required this.specialityId, required this.instituteId,
    required this.phoneNo
}
     );

  factory AttendingPhysician.fromJSON(Map<String, dynamic> map) {
    return AttendingPhysician(
        id: map['id'],
        phoneNo: map['phoneNo'],
        attendingName: map['attendingName'],
        specialityId: map['specialityId'] ?? Speciality.fromJSON(map['speciality']).id,
        instituteId:map['instituteId'] ?? Institute.fromJSON(map['institute']).id);
  }
/*   AttendingPhysician fromJSON2(Map<String, dynamic> map) {
    AttendingPhysician attending = AttendingPhysician(
      id: map['id'],
      attendingName: map['attendingName'],
      specialityId: map['speciality'],
      inst

    );
      id= map['id'];
     attendingName= map['attendingName'];
     specialityId= map['specialityId'];
     instituteId= map['instituteId'];

     return attending;
  }*/
  Map<String, dynamic> toJson() => {
        'id': id,
        'attendingName': attendingName,
        'specialityId': specialityId,
        'instituteId': instituteId,
      };

  Map<String, dynamic> toMap() => {
    'attending_id':id,
    'attending_name': attendingName,
    'speciality_id': specialityId,
    'institute_id': instituteId,
  };
  factory AttendingPhysician.fromMap(Map<String, dynamic> map) {
    return AttendingPhysician(
        id: map['attending_id'],
        attendingName: map['attending_name'],
        specialityId: map['speciality_id'],
        phoneNo: map['phoneNo'],
        instituteId: map['institute_id']);
  }


}
