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
}
