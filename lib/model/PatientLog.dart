import 'package:flutter/cupertino.dart';
import 'package:internship_managing_system/model/AttendingPhysician.dart';
import 'package:internship_managing_system/model/Coordinator.dart';
import 'package:internship_managing_system/model/Course.dart';
import 'package:internship_managing_system/model/Institute.dart';
import 'package:internship_managing_system/model/Speciality.dart';
import 'package:internship_managing_system/model/Student.dart';

class PatientLog with ChangeNotifier {
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

  Institute? get instute => _institute;

  void setInstute(Institute value) {
    _institute = value;
    notifyListeners();
  }

  DateTime? _createdAt;
  DateTime? updatedAt;

  DateTime? get createdAt => _createdAt;

  void setCreatedAt(DateTime value) {
    _createdAt = value;
    notifyListeners();
  }

  String? get status => _status;

  void setStatus(String value) {
    _status = value;
    notifyListeners();
  }

  String? get gerceklestigiOrtam => _gerceklestigiOrtam;

  void setGerceklestigiOrtam(String value) {
    _gerceklestigiOrtam = value;
    notifyListeners();
  }

  String? get kapsam => _kapsam;

  void setKapsam(String value) {
    _kapsam = value;
    notifyListeners();
  }

  String? get etkilesimTuru => _etkilesimTuru;

  void setEtkilesimTuru(String value) {
    _etkilesimTuru = value;
    notifyListeners();
  }

  String? get tedaviYontemi => _tedaviYontemi;

  void setTedaviYontemi(String value) {
    _tedaviYontemi = value;
    notifyListeners();
  }

  String? get kesinTani => _kesinTani;

  void setKesinTani(String value) {
    _kesinTani = value;
    notifyListeners();
  }

  String? get ayiriciTani => _ayiriciTani;

  void setAyiriciTani(String value) {
    _ayiriciTani = value;
    notifyListeners();
  }

  String? get sikayet => _sikayet;

  void setSikayet(String value) {
    _sikayet = value;
    notifyListeners();
  }

  Cinsiyet? get cinsiyet => _cinsiyet;

  void setCinsiyet(Cinsiyet value) {
    _cinsiyet = value;
    notifyListeners();
  }

  String? get yas => _yas.toString();

  void setYas(String value) {
    _yas = value;
    notifyListeners();
  }

  String? get kayitNo => _kayitNo;

  void setKayitNo(String value) {
    _kayitNo = value;
    notifyListeners();
  }

  Coordinator? get coordinator => _coordinator;

  void setCoordinator(Coordinator value) {
    _coordinator = value;
    notifyListeners();
  }

  Student? get student => _student;

  void setStudent(Student value) {
    _student = value;
    notifyListeners();
  }

  AttendingPhysician? get attendingPhysician => _attendingPhysician;

  void setAttendingPhysician(AttendingPhysician value) {
    _attendingPhysician = value;
    notifyListeners();
  }

  Speciality? get speciality => _speciality;

  void setSpeciality(Speciality value) {
    _speciality = value;
    notifyListeners();
  }

  Course? get course => _course;

  void setCourse(Course value) {
    _course = value;
    notifyListeners();
  }

  int? get id => _id;

  void setId(int value) {
    _id = value;
    notifyListeners();
  }
}

enum Cinsiyet { ERKEK, KADIN, DIGER }
