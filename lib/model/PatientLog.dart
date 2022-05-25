import 'package:flutter/cupertino.dart';
import 'package:internship_managing_system/model/AttendingPhysician.dart';
import 'package:internship_managing_system/model/Coordinator.dart';
import 'package:internship_managing_system/model/Course.dart';
import 'package:internship_managing_system/model/Institute.dart';
import 'package:internship_managing_system/model/Speciality.dart';
import 'package:internship_managing_system/model/Student.dart';

import '../student/services/SQFLiteHelper.dart';

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
  String? _cinsiyet;
  String? _sikayet;
  String? _ayiriciTani;
  String? _kesinTani;
  String? _tedaviYontemi;
  String? _etkilesimTuru;
  String? _kapsam;
  String? _gerceklestigiOrtam;
  String? _status;

  Institute? get instute => _institute;

  static checkID(var id) {
    return id is int ? id : int.parse(id);
  }

  PatientLog({
    coordinator,
    institute,
    speciality,
    tarih,
    id,
    kayitNo,
    course,
    doktor,
    yas,
    cinsiyet,
    sikayet,
    ayiriciTani,
    kesinTani,
    tedaviYontemi,
    etkilesimTuru,
    kapsam,
    gerceklestigiOrtam,
  });

  factory PatientLog.fromJson(Map<String, dynamic> myMap) {
    return PatientLog(
      id: checkID(myMap['id']),
      kayitNo: myMap['kayit_no'],
      institute: myMap['instituteId'],
      speciality: myMap['specialityId'],
      course: myMap['coursesId'],
      doktor: myMap['attending_physicianId'],
      yas: myMap['yas'],
      cinsiyet: myMap['cinsiyet'],
      sikayet: myMap['sikayet'],
      ayiriciTani: myMap['ayirici_tani'],
      kesinTani: myMap['kesin_tani'],
      tedaviYontemi: myMap['tedavi_yontemi'],
      etkilesimTuru: myMap['etkilesim_turu'],
      kapsam: myMap['kapsam'],
      gerceklestigiOrtam: myMap['ortam'],
    );
  }

  factory PatientLog.fromMap(Map<String, dynamic> myMap) => PatientLog(
        id: myMap['id'],
        kayitNo: myMap['kayit_no'],
        institute: myMap['instituteId'],
        speciality: myMap['specialityId'],
        course: myMap['coursesId'],
        doktor: myMap['attending_physicianId'],
        yas: myMap['yas'],
        cinsiyet: myMap['cinsiyet'],
        sikayet: myMap['sikayet'],
        ayiriciTani: myMap['ayirici_tani'],
        kesinTani: myMap['kesin_tani'],
        tedaviYontemi: myMap['tedavi_yontemi'],
        etkilesimTuru: myMap['etkilesim_turu'],
        kapsam: myMap['kapsam'],
        gerceklestigiOrtam: myMap['ortam'],
      );

  Map<String, dynamic> toMap() {
    return {
      SQFLiteHelper.columnKayitNo: kayitNo,
      SQFLiteHelper.columnId: id,
      //SQFLiteHelper.columnSpecialitiesId: speciality,
      SQFLiteHelper.columnYas: yas,
      SQFLiteHelper.columnAttendingPhysicianId: attendingPhysician,
      SQFLiteHelper.columnCoursesId: course,
      SQFLiteHelper.columnInstituteId: instute,
      SQFLiteHelper.columnCinsiyet: cinsiyet,
      SQFLiteHelper.columnSikayet: sikayet,
      SQFLiteHelper.columnAyiriciTani: ayiriciTani,
      SQFLiteHelper.columnKesinTani: kesinTani,
      SQFLiteHelper.columnTedaviYontemi: tedaviYontemi,
      SQFLiteHelper.columnEtkilesimTuru: etkilesimTuru,
      SQFLiteHelper.columnOrtam: gerceklestigiOrtam,
      SQFLiteHelper.columnKapsam: kapsam,
      SQFLiteHelper.columnTarih: createdAt,
      SQFLiteHelper.columnStatus: status
    };
  }

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

  String? get cinsiyet => _cinsiyet;

  void setCinsiyet(String value) {
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

  void setSpecialityName(String val) {}

  Course? get course => _course;

  void setCourse(Course value) {
    _course = value;
    //_course?.courseName=value as String; denenebilir
    notifyListeners();
  }

  int? get id => _id;

  void setId(int value) {
    _id = value;
    notifyListeners();
  }
}

enum Cinsiyet { ERKEK, KADIN, DIGER }
