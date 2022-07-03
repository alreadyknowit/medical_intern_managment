import 'package:internship_managing_system/model/Course.dart';

class Student {
  int id;
  String studentName;
  int oasisId;
  List<Course>? course=[];


  Student({required this.id,required this.studentName, required this.oasisId, required this.course});

  Map<String, dynamic> toMap() => {
    'student_id': id,
    'student_name': studentName,
    'oasis_id': oasisId,
  };

  factory Student.fromJson(Map<String, dynamic> map)=>
      Student(id: map['id'], studentName: map['name'], oasisId: map['oasisID'], course: null);

  @override
  String toString() {
    return '{id: $id, studentName: $studentName, oasisId: $oasisId, course: $course}';
  }


}
