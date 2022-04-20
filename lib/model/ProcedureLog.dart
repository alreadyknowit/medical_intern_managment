import 'AttendingPhysician.dart';
import 'Coordinator.dart';
import 'Course.dart';
import 'Institute.dart';
import 'Speciality.dart';
import 'Student.dart';

class ProcedureLog {
  int? _id;
  Course? _course;
  Speciality? _speciality;
  AttendingPhysician? _attendingPhysician;
  Student? _student;
  Coordinator? _coordinator;
  Institute? _institute;
  String? _kayitNo;
  String? _yas;
  Cinsiyet? _cinsiyet;
  String? _sikayet;
  String? _ayiriciTani;
  String? _kesinTani;
  String? _tedaviYontemi;
  String? _etkilesimTuru;
  String? _kapsam;
  String? _gerceklestigiOrtam;
  String? _status;
}

enum Cinsiyet { ERKEK, KADIN, DIGER }
