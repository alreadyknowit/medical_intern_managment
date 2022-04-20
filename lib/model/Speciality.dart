import 'package:internship_managing_system/model/Course.dart';

class Speciality {
  int id;
  String name;
  Course course;

  Speciality({required this.id, required this.name, required this.course});

  factory Speciality.fromJSON(Map<String, dynamic> map) {
    return Speciality(
        id: map['id'],
        name: map['description'],
        course: Course.fromJSON(map['course']));
  }
  Map<String, dynamic> toJson() =>
      {'id': id, 'description': name, 'course': course};
}
