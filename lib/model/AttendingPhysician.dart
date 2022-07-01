class AttendingPhysician {
  int id;
  String attendingName;
  int specialityId;
  int instituteId;

  AttendingPhysician(
      {required this.id,
      required this.attendingName,
      required this.specialityId,
      required this.instituteId});

  factory AttendingPhysician.fromJSON(Map<String, dynamic> map) {
    return AttendingPhysician(
        id: map['id'],
        attendingName: map['attendingName'],
        specialityId: map['specialityId'],
        instituteId: map['instituteId']);
  }
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
        instituteId: map['institute_id']);
  }


}
