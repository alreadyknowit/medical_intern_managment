import 'package:flutter/cupertino.dart';

import '../student/services/SQFLiteHelper.dart';
import 'AttendingPhysician.dart';
import 'Coordinator.dart';
import 'Course.dart';
import 'Institute.dart';
import 'Speciality.dart';
import 'Student.dart';

class ProcedureLog with ChangeNotifier {
  int? _id;
  Course? _course;
  Speciality? _speciality;
  AttendingPhysician? _attendingPhysician;
  Student? _student;
  Coordinator? _coordinator;
  Institute? _institute;
  String? _kayitNo;
  String? _disKurum;
  String? _tibbiUygulama;
  String? _etkilesimTuru;
  String? _gerceklestigiOrtam;
  String? _status;
  ProcedureLog({
    kayitNo,
    status,
    tarih,
    id,
    institute,
    course,
    speciality,
    doktor,
    tibbiUygulama,
    etkilesimTuru,
    disKurum,
    gerceklestigiOrtam,
  });
  factory ProcedureLog.fromJson(Map<String, dynamic> myMap) {
    return ProcedureLog(
      id: checkID(myMap['id']),
      kayitNo: myMap['kayit_no'],
      institute: myMap['instituteId'],
      speciality: myMap['specialityId'],
      course: myMap['coursesId'],
      doktor: myMap['attending_physicianId'],
      etkilesimTuru: myMap['etkilesim_turu'],
      gerceklestigiOrtam: myMap['tibbi_ortam'],
      tibbiUygulama: myMap['tibbi_uygulama'],
      disKurum: myMap['dis_kurum'],
    );
  }

  static checkID(var id) {
    return id is int ? id : int.parse(id);
  }

  factory ProcedureLog.fromMap(Map<String, dynamic> myMap) => ProcedureLog(
        id: myMap['id'],
        kayitNo: myMap['kayit_no'],
        institute: myMap['instituteId'],
        speciality: myMap['specialityId'],
        course: myMap['coursesId'],
        doktor: myMap['attending_physicianId'],
        etkilesimTuru: myMap['etkilesim_turu'],
        gerceklestigiOrtam: myMap['tibbi_ortam'],
        tibbiUygulama: myMap['tibbi_uygulama'],
        disKurum: myMap['dis_kurum'],
      );

  Map<String, dynamic> toMap() {
    return {
      SQFLiteHelper.columnKayitNo: kayitNo,
      SQFLiteHelper.columnId: id,
      // SQFLiteHelper.columnSpecialitiesId: speciality,
      SQFLiteHelper.columnAttendingPhysicianId: attendingPhysician,
      SQFLiteHelper.columnCoursesId: course,
      SQFLiteHelper.columnInstituteId: instute,
      SQFLiteHelper.columntibbiOrtam: gerceklestigiOrtam,
      SQFLiteHelper.columntibbiUygulama: tibbiUygulama,
      SQFLiteHelper.columnTibbiEtkilesimTuru: etkilesimTuru,
      SQFLiteHelper.columndisKurum: disKurum,
      SQFLiteHelper.columnTarih: createdAt,
      SQFLiteHelper.columnStatus: status
    };
  }

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

  String? get etkilesimTuru => _etkilesimTuru;

  void setEtkilesimTuru(String value) {
    _etkilesimTuru = value;
    notifyListeners();
  }

  String? get tibbiUygulama => _tibbiUygulama;

  void setTibbiUygulama(String value) {
    _tibbiUygulama = value;
    notifyListeners();
  }

  String? get disKurum => _disKurum;

  void setDisKurum(String value) {
    _disKurum = value;
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
