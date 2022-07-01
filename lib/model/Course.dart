import 'package:flutter/cupertino.dart';

class Course with ChangeNotifier {
  int id;
  String courseName;

  Course({required this.id, required this.courseName});

  factory Course.fromJSON(Map<String, dynamic> map) {
    return Course(id: map['id'], courseName: map['name']);
  }

  //server
  Map<String, dynamic> toJson() => {'id': id, 'name': courseName};

  //sqlite
  Map<String, dynamic> toMap() =>{
    'course_id':id,
    'course_name':courseName
  };
  factory Course.fromMap(Map<String, dynamic> map) {
    return Course(id: map['course_id'], courseName: map['course_name']);
  }
}
