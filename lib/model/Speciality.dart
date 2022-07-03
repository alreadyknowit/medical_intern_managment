import 'Course.dart';

class Speciality {
  int id;
  String name;
  int courseId;

  Speciality({required this.id, required this.name, required this.courseId});

  factory Speciality.fromJSON(Map<String, dynamic> map) {
    return Speciality(
        id: map['id'], name: map['description'], courseId:map['courseId'] ??Course.fromJSON(map['course']).id );
  }

  Map<String, dynamic> toJson() =>
      {'id': id, 'description': name, 'courseId': courseId};

  Map<String, dynamic> toMap() =>
      {'speciality_id':id, 'description': name, 'course_id': courseId};

  factory Speciality.fromMap(Map<String, dynamic> map) {
    return Speciality(
        id: map['speciality_id'], name: map['description'], courseId:map['course_id'] );
  }

  @override
  String toString() {
    return '{id: $id, name: $name, courseId: $courseId}';
  }
}
