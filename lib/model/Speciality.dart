class Speciality {
  int id;
  String name;
  int courseId;

  Speciality({required this.id, required this.name, required this.courseId});

  factory Speciality.fromJSON(Map<String, dynamic> map) {
    return Speciality(
        id: map['id'], name: map['description'], courseId: map['courseId']);
  }
  Map<String, dynamic> toJson() =>
      {'id': id, 'description': name, 'courseId': courseId};
}
