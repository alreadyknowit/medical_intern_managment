import 'package:flutter/cupertino.dart';
import 'package:internship_managing_system/model/AttendingPhysician.dart';
import 'package:internship_managing_system/model/Coordinator.dart';
import 'package:internship_managing_system/model/Course.dart';
import 'package:internship_managing_system/model/Institute.dart';
import 'package:internship_managing_system/model/Speciality.dart';
import 'package:internship_managing_system/model/Student.dart';
import 'package:intl/intl.dart';

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

  Institute? get institute => _institute;

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
    attending,
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


   PatientLog fromJson(Map<String, dynamic> map) {
    PatientLog patientLog = PatientLog();

    patientLog.setId(map['id']);
    patientLog.setStudent(Student.fromJson(map['student'])); // mapper ekle
    patientLog.setCoordinator(Coordinator.fromJson(map['coordinator'])); // TODO:
    print(Speciality.fromJSON(map['speciality']));
    patientLog.setSpeciality(Speciality.fromJSON(map['speciality']));
    patientLog.setCourse(Course.fromJSON(map['course']));
    patientLog.setInstute(Institute(id: 1, instituteName: "EMOT")); //TODO
    patientLog.setAttendingPhysician(AttendingPhysician.fromJSON(map['attending']));
    patientLog.setKayitNo(map['kayitNo']);
    patientLog.setYas(map['yas'].toString());
    patientLog.setCinsiyet(map['cinsiyet']);
    patientLog.setSikayet(map['sikayet']);
    patientLog.setAyiriciTani(map['ayiriciTani']);
    patientLog.setKesinTani(map['kesinTani']);
    patientLog.setTedaviYontemi(map['tedaviYontemi']);
    patientLog.setEtkilesimTuru(map['etkilesimTuru']);
    patientLog.setKapsam(map['kapsam']);
    patientLog.setGerceklestigiOrtam(map['gerceklestigiOrtam']);
    patientLog.setStatus(map['status']);
    patientLog.setCreatedAt(map['createdAt']);
    return patientLog;
  }

  Map<String, dynamic> toMap() {
    return {
      SQFLiteHelper.columnId: id,
      SQFLiteHelper.columnInstituteId: institute?.id,
      SQFLiteHelper.columnSpecialityId: speciality?.id,
      SQFLiteHelper.columnCourseId: course?.id,
      SQFLiteHelper.columnCoordinatorId: coordinator?.id,
      SQFLiteHelper.columnAttendingPhysicianId: attendingPhysician?.id,
      SQFLiteHelper.columnKayitNo: kayitNo,
      SQFLiteHelper.columnSikayet: sikayet,
      SQFLiteHelper.columnCinsiyet: cinsiyet,
      SQFLiteHelper.columnEtkilesimTuru: etkilesimTuru,
      SQFLiteHelper.columnKapsam: kapsam,
      SQFLiteHelper.columnOrtam: gerceklestigiOrtam,
      SQFLiteHelper.columnYas: yas,
      SQFLiteHelper.columnAyiriciTani: ayiriciTani,
      SQFLiteHelper.columnKesinTani: kesinTani,
      SQFLiteHelper.columnTedaviYontemi: tedaviYontemi,
      SQFLiteHelper.columnTarih: createdAt,
      SQFLiteHelper.columnStatus: status
    };
  }

  void setInstute(Institute? value) {
    _institute = value;
    notifyListeners();
  }

  String? _createdAt;
  String? updatedAt;

  String? get createdAt => _createdAt;

  void setCreatedAt(String? value) {
    if(value != null) {
      var format = DateTime.parse(value);
      var formatter =DateFormat('d/M/y hh:mm').format(format);
      print(formatter);
      _createdAt = formatter.toString();
    }else{
      _createdAt = value;
    }
    notifyListeners();
  }

  String? get status => _status;

  void setStatus(String? value) {
    _status = value;
    notifyListeners();
  }

  String? get gerceklestigiOrtam => _gerceklestigiOrtam;

  void setGerceklestigiOrtam(String? value) {
    _gerceklestigiOrtam = value;
    notifyListeners();
  }

  String? get kapsam => _kapsam;

  void setKapsam(String? value) {
    _kapsam = value;
    notifyListeners();
  }

  String? get etkilesimTuru => _etkilesimTuru;

  void setEtkilesimTuru(String? value) {
    _etkilesimTuru = value;
    notifyListeners();
  }

  String? get tedaviYontemi => _tedaviYontemi;

  void setTedaviYontemi(String? value) {
    _tedaviYontemi = value;
    notifyListeners();
  }

  String? get kesinTani => _kesinTani;

  void setKesinTani(String? value) {
    _kesinTani = value;
    notifyListeners();
  }

  String? get ayiriciTani => _ayiriciTani;

  void setAyiriciTani(String? value) {
    _ayiriciTani = value;
    notifyListeners();
  }

  String? get sikayet => _sikayet;

  void setSikayet(String? value) {
    _sikayet = value;
    notifyListeners();
  }

  String? get cinsiyet => _cinsiyet;

  void setCinsiyet(String? value) {
    _cinsiyet = value;
    notifyListeners();
  }

  String? get yas => _yas.toString();

  void setYas(String? value) {
    _yas = value;
    notifyListeners();
  }

  String? get kayitNo => _kayitNo;

  void setKayitNo(String? value) {
    _kayitNo = value;
    notifyListeners();
  }

  Coordinator? get coordinator => _coordinator;

  void setCoordinator(Coordinator? value) {
    _coordinator = value;
    notifyListeners();
  }

  Student? get student => _student;

  void setStudent(Student? value) {
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

  void setSpecialityName(String val) {}

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

  @override
  String toString() {
    return 'PatientLog{_id: $_id, _course: $_course, _speciality: $_speciality, _attendingPhysician: $_attendingPhysician, _student: $_student, _coordinator: $_coordinator, _institute: $_institute, _kayitNo: $_kayitNo, _yas: $_yas, _cinsiyet: $_cinsiyet, _sikayet: $_sikayet, _ayiriciTani: $_ayiriciTani, _kesinTani: $_kesinTani, _tedaviYontemi: $_tedaviYontemi, _etkilesimTuru: $_etkilesimTuru, _kapsam: $_kapsam, _gerceklestigiOrtam: $_gerceklestigiOrtam, _status: $_status, _createdAt: $_createdAt, updatedAt: $updatedAt}';
  }



/*  PatientLog fromJson(Map<String,dynamic> map){
    PatientLog patientLog = PatientLog();
    patientLog.setId(map['id']);
    patientLog.setStudent(Student.fromJson(map['student'])); // mapper ekle
    patientLog.setAttendingPhysician(AttendingPhysician.fromJSON(map['attending']));
    patientLog.setCoordinator(Coordinator(1, "Coordinator1", 20162003)); // TODO:
    patientLog.setSpeciality(Speciality.fromJSON(map['speciality']));
    patientLog.setCourse(Course.fromJSON(map['course']));
    patientLog.setKayitNo(map['kayit_no']);
    patientLog.setYas(map['yas']);
    patientLog.setCinsiyet(map['cinsiyet']);
    patientLog.setSikayet(map['sikayet']);
    patientLog.setAyiriciTani(map['ayiriciTani']);
    patientLog.setKesinTani(map['kesinTani']);
    patientLog.setTedaviYontemi(map['tedaviYontemi']);
    patientLog.setEtkilesimTuru(map['etkilesimTuru']);
    patientLog.setKapsam(map['kapsam']);
    patientLog.setGerceklestigiOrtam(map['gerceklestigiOrtam']);
    patientLog.setStatus(map['status']);
    patientLog.setCreatedAt(map['createdAt']);
    return patientLog;
  }*/
}

