import 'package:flutter/cupertino.dart';
import 'package:intl/intl.dart';

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
    gerceklestigiOrtam,
  });

  static checkID(var id) {
    return id is int ? id : int.parse(id);
  }

  ProcedureLog fromJson(Map<String, dynamic> map) {
    ProcedureLog procedureLog = ProcedureLog();

    procedureLog.setId(map['id']);
    procedureLog.setStudent(Student.fromJson(map['student'])); // mapper ekle
    procedureLog
        .setCoordinator(Coordinator.fromJson(map['coordinator'])); // TODO:
    procedureLog.setSpeciality(Speciality.fromJSON(map['speciality']));
    procedureLog.setCourse(Course.fromJSON(map['course']));
    procedureLog.setInstute(Institute(id: 1, instituteName: "EMOT"));
    procedureLog
        .setAttendingPhysician(AttendingPhysician.fromJSON(map['attending']));
    procedureLog.setKayitNo(map['kayitNo']);
    procedureLog.setEtkilesimTuru(map['etkilesimTuru']);
    procedureLog.setGerceklestigiOrtam(map['gerceklestigiOrtam']);
    procedureLog.setTibbiUygulama(map['tibbiUygulama']);
    procedureLog.setStatus(map['status']);
    procedureLog.setCreatedAt(map['createdAt']);
    return procedureLog;
  }

  Map<String, dynamic> toMap() {
    return {
      SQFLiteHelper.columnKayitNo: kayitNo,
      SQFLiteHelper.columnId: id,
      SQFLiteHelper.columnSpecialityId: speciality?.id,
      SQFLiteHelper.columnAttendingPhysicianId: attendingPhysician?.id,
      SQFLiteHelper.columnCourseId: course?.id,
      SQFLiteHelper.columnInstituteId: institute?.id,
      SQFLiteHelper.columnOrtam: gerceklestigiOrtam,
      SQFLiteHelper.columnTibbiEtkilesimTuru: etkilesimTuru,
      SQFLiteHelper.columnTarih: createdAt,
      SQFLiteHelper.columnStatus: status
    };
  }

  Institute? get institute => _institute;

  void setInstute(Institute? value) {
    _institute = value;
    notifyListeners();
  }

  String? _createdAt;
  String? updatedAt;

  String? get createdAt => _createdAt;

  void setCreatedAt(String? value) {
    if (value != null) {
      var format = DateTime.parse(value);
      var formatter = DateFormat('d/M/y hh:mm').format(format);
      _createdAt = formatter.toString();
    } else {
      _createdAt = value;
    }
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

  void setAttendingPhysician(AttendingPhysician? value) {
    _attendingPhysician = value;
    notifyListeners();
  }

  Speciality? get speciality => _speciality;

  void setSpeciality(Speciality? value) {
    _speciality = value;
    notifyListeners();
  }

  Course? get course => _course;

  void setCourse(Course? value) {
    _course = value;
    notifyListeners();
  }

  int? get id => _id;

  void setId(int? value) {
    _id = value;
    notifyListeners();
  }
}
