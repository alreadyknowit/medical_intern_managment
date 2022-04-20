import 'package:internship_managing_system/model/Course.dart';

class Student {
  int _id;
  String _studentName;
  int _oasisId;
  List<Course> _course;

  Student(this._id, this._studentName, this._oasisId, this._course);

  List<Course> get course => _course;

  set course(List<Course> value) {
    _course = value;
  }

  int get oasisId => _oasisId;

  set oasisId(int value) {
    _oasisId = value;
  }

  String get studentName => _studentName;

  set studentName(String value) {
    _studentName = value;
  }

  int get id => _id;

  set id(int value) {
    _id = value;
  }
}
