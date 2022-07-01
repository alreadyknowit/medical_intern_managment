import 'package:flutter/cupertino.dart';

class Course with ChangeNotifier {
  int id;
  String courseName;

  Course({
    required this.id,
    required this.courseName,
  });

  factory Course.fromJSON(Map<String, dynamic> map) {
    return Course(id: map['id'], courseName: map['name']);
  }

  Map<String, dynamic> toJson() => {
        'id': id,
        'name': courseName,
      };
}
