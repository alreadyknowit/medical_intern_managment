import 'package:internship_managing_system/model/AttendingPhysician.dart';
import 'package:internship_managing_system/model/Coordinator.dart';
import 'package:internship_managing_system/model/Institute.dart';
import 'package:internship_managing_system/model/PatientLogDto.dart';
import 'package:internship_managing_system/model/Speciality.dart';
import 'package:path/path.dart';
import 'package:sqflite/sqflite.dart';

import '../../model/Course.dart';
import '../../model/PatientLog.dart';
import '../../model/ProcedureLog.dart';

class SQFLiteHelper {
  final _databaseName = 'taslak.db';
  final _databaseVersion = 1;
  final _tablePatientLog = 'patient_log_tbl';
  //TODO: Procedure Log table ekle
  final _tableCourse = 'course';
  final _tableAttending = 'attending';
  final _tableDiagnosis = 'diagnosis';
  final _tableCoordinator = 'coordinator';
  final _tableInstitute = 'institute';
  final _tableSpeciality = 'speciality';
  final _tableStudent = 'student';
  static const columnId = 'id';
  static const columnInstituteId = 'institute_id';
  static const columnCourseId = 'course_id';
  static const columnSpecialityId = 'speciality_id';
  static const columnAttendingPhysicianId = 'attending_id';
  static const columnKayitNo = 'kayit_no';
  static const columnSikayet = 'sikayet';
  static const columnCinsiyet = 'cinsiyet';
  static const columnEtkilesimTuru = 'etkilesim_turu';
  static const columnKapsam = 'kapsam';
  static const columnOrtam = 'ortam';
  static const columnYas = 'yas';
  static const columnAyiriciTani = 'ayirici_tani';
  static const columnKesinTani = 'kesin_tani';
  static const columnTedaviYontemi = 'tedavi_yontemi';
  static const columnTarih = 'tarih';
  static const columnTibbiEtkilesimTuru = 'etkilesim_turu';
  static const columnStatus = 'form_status';
  static const columnCoordinatorId = 'coordinator_id';

  SQFLiteHelper._privateConstructor();

  static final SQFLiteHelper instance = SQFLiteHelper._privateConstructor();
  static Database? _database;

  Future<Database> get getDatabase async {
    return _database ?? await _initDatabase();
  }

  Future<Database> _initDatabase() async {
    String path = join(await getDatabasesPath(), _databaseName);
    return await openDatabase(path,
        version: _databaseVersion, onCreate: _onCreate);
  }

  Future _onCreate(Database db, int version) async {
    await db.execute('''  
                CREATE TABLE "institute" (
                  "institute_id"	INTEGER,
                  "institute_name"	TEXT NOT NULL
                )
  
    ''');
    await db.execute('''
                CREATE TABLE "course" (
                  "course_id"	INTEGER,
                  "course_name"	TEXT,
                  PRIMARY KEY("course_id" AUTOINCREMENT)
                )
    ''');
    await db.execute('''
      CREATE TABLE "speciality" (
                  "speciality_id"	INTEGER,
                  "description"	TEXT NOT NULL,
                  "course_id"	INTEGER,
                  PRIMARY KEY("speciality_id" AUTOINCREMENT),
                  FOREIGN KEY("course_id") REFERENCES "course"("course_id")
                )
    ''');
    await db.execute('''
      CREATE TABLE "diagnosis" (
                  "diagnosis_id"	INTEGER,
                  "diagnosis_name"	TEXT,
                  "speciality_id"	INTEGER,
                  PRIMARY KEY("diagnosis_id" AUTOINCREMENT),
                  FOREIGN KEY("speciality_id") REFERENCES "speciality"("speciality_id")
                );
    ''');
    await db.execute('''
     
                CREATE TABLE  "attending" (
                  "attending_id"	INTEGER,
                  "speciality_id"	INTEGER,
                  "institute_id"	INTEGER,
                  "attending_name"	TEXT,
                  "phone_no"	INTEGER,
                  PRIMARY KEY("attending_id" AUTOINCREMENT),
                  FOREIGN KEY("speciality_id") REFERENCES "speciality"("speciality_id")
                );
    ''');
    await db.execute('''
       
                
                CREATE TABLE "student" (
                  "student_id"	INTEGER,
                  "student_name"	INTEGER,
                  "oasis_id"	INTEGER,
                  "course_id"	INTEGER,
                  PRIMARY KEY("student_id" AUTOINCREMENT),
                  FOREIGN KEY("course_id") REFERENCES "course"("course_id")
                );
    ''');
    await db.execute('''
        CREATE TABLE "coordinator" (
                  "coordinator_id"	INTEGER,
                  "coordinator_name"	TEXT,
                  "oasis_id"	INTEGER,
                  PRIMARY KEY("coordinator_id" AUTOINCREMENT)
                );
    ''');
    await db.execute('''
        CREATE TABLE  "patient_log_tbl" (
                  "id"	INTEGER,
                  "institute_id"	INTEGER,
                  "speciality_id"	INTEGER COLLATE BINARY,
                  "course_id"	INTEGER,
                  "attending_id"	INTEGER,
                  "kayit_no"	TEXT,
                  "sikayet"	TEXT,
                  "cinsiyet"	INTEGER,
                  "etkilesim_turu"	TEXT,
                  "kapsam"	TEXT,
                  "ortam"	TEXT,
                  "yas"	INTEGER,
                  "ayirici_tani"	TEXT,
                  "kesin_tani"	TEXT,
                  "tedavi_yontemi"	TEXT,
                  "tarih" datetime DEFAULT CURRENT_TIMESTAMP,
                  "form_status"	TEXT,
                  "coordinator_id"	INTEGER,
                  FOREIGN KEY("coordinator_id") REFERENCES "coordinator"("coordinator_id"),
                  PRIMARY KEY("id" AUTOINCREMENT),
                  FOREIGN KEY("speciality_id") REFERENCES "speciality"("speciality_id"),
                  FOREIGN KEY("institute_id") REFERENCES "institute"("institute_id"),
                  FOREIGN KEY("course_id") REFERENCES "course"("course_id"),
                  FOREIGN KEY("attending_id") REFERENCES "attending"("attending_id")
                )
    ''');
  }

  Future<bool> insertPatientLog(PatientLog form) async {
    Database db = await instance.getDatabase;
    int res = await db.insert(_tablePatientLog, form.toMap());

    if (res == 0) {
      return false;
    } else {
      return true;
    }
  }

  Future<List<PatientLog>> getForms() async {
    Database db = await instance.getDatabase;
    List<Map<String, dynamic>> forms =
        await db.query(_tablePatientLog, orderBy: 'id DESC');
    Institute? institute;
    AttendingPhysician? attendingPhysician;
    Speciality? speciality;
    Course? course;
    Coordinator coordinator;
    List<PatientLog> listLogs = [];
    List<PatientLogDto> dtoList =
        forms.map((e) => PatientLogDto.fromMap(e)).toList();
    for (PatientLogDto dto in dtoList) {
      if (dto.attendingPhysician != null) {
        attendingPhysician = await getAttending(dto.attendingPhysician!);
      }
      if (dto.speciality != null) {
        speciality = await getSpeciality(dto.speciality!);
      }
      if (dto.course != null) {
        course = await getCourse(dto.course!);
      }
      if (dto.institute != null) {
        institute = await getInstitute(dto.institute!);
      }

      PatientLog log = PatientLog();
      log.setId(dto.id);
      log.setInstute(institute);
      log.setCourse(course);
      log.setSpeciality(speciality);
      log.setAttendingPhysician(attendingPhysician);
      log.setAyiriciTani(dto.ayiriciTani);
      log.setCinsiyet(dto.cinsiyet);
      log.setEtkilesimTuru(dto.etkilesimTuru);
      log.setKapsam(dto.kapsam);
      log.setKayitNo(dto.kayitNo);
      log.setSikayet(dto.sikayet);
      log.setStatus("waiting");
      log.setYas(dto.yas.toString());
      log.setCreatedAt(dto.tarih);
      log.setKesinTani(dto.kesinTani);
      log.setTedaviYontemi(dto.tedaviYontemi);
      listLogs.add(log);
      log.setKayitNo(log.kayitNo);
      print(log.toString());
    }

    /*  Institute? institute;
    AttendingPhysician? attendingPhysician;
    Speciality? speciality;
    Course? course;
    List<Map> mapList = [];
    List<PatientLog> list = forms.map((myMap) {
      Map objects = {
        'id': myMap['id'],
        'course_id': myMap['course_id'],
        'attending_id': myMap['attending_id'],
        'institute_id': myMap['institute_id'],
        'speciality_id': myMap['speciality_id']
      };

      mapList.add(objects);

      return PatientLog.fromMap(
          myMap, institute, course, attendingPhysician, speciality);
    }).toList();

    List<Dto> dtos = [];
    for (Map map in mapList) {
      dtos.add(Dto(map['id'], map['course_id'], map['attending_id'],
          map['speciality_id'], map['institute_id']));
    }

    for (Dto dto in dtos) {
      Course course = await getCourse(dto.courseId);
      Institute institute = await getInstitute(dto.instituteId);
      Speciality speciality = await getSpeciality(dto.specialityId);
      AttendingPhysician attending = await getAttending(dto.attendingId);
      for (int i = 0; i < list.length; i++) {

        if (dto.id == list[i].id) {
          list[i].setSpeciality(speciality);
          list[i].setCourse(course);
          list[i].setInstute(institute);
          list[i].setAttendingPhysician(attending);
        }
      }
    }

*/

    return listLogs;
  }


  Future<bool> insertSpecialities(Speciality speciality) async {
    Database db = await instance.getDatabase;
    int res = await db.insert(_tableSpeciality, speciality.toMap(),
        conflictAlgorithm: ConflictAlgorithm.ignore);
    if (res == 0) {
      return false;
    } else {
      return true;
    }
  }

  Future<Speciality> getSpeciality(int id) async {
    Database db = await instance.getDatabase;
    var res = await db.query(
      _tableSpeciality,
      where: 'speciality_id =$id',
    );
    List<Speciality> speciality =
        res.map((e) => Speciality.fromMap(e)).toList();
    return speciality[0];
  }

  Future<bool> insertCourse(Course course) async {
    Database db = await instance.getDatabase;
    int res = await db.insert(_tableCourse, course.toMap(),
        conflictAlgorithm: ConflictAlgorithm.ignore);
    if (res == 0) {
      return false;
    } else {
      return true;
    }
  }

  Future<Course> getCourse(int id) async {
    Database db = await instance.getDatabase;
    var res = await db.query(
      _tableCourse,
      where: 'course_id =$id',
    );
    List<Course> course = res.map((e) => Course.fromMap(e)).toList();
    return course[0];
  }

  Future<bool> insertInstitute(Institute institute) async {
    Database db = await instance.getDatabase;
    int res = await db.insert(_tableInstitute, institute.toMap(),
        conflictAlgorithm: ConflictAlgorithm.ignore);
    if (res == 0) {
      return false;
    } else {
      return true;
    }
  }

  Future<Institute> getInstitute(int id) async {
    Database db = await instance.getDatabase;
    var res = await db.query(
      _tableInstitute,
      where: 'institute_id =$id',
    );
    List<Institute> institute = res.map((e) => Institute.fromMap(e)).toList();
    return institute[0];
  }

  Future<bool> insertAttending(AttendingPhysician attending) async {
    Database db = await instance.getDatabase;
    int res = await db.insert(_tableAttending, attending.toMap(),
        conflictAlgorithm: ConflictAlgorithm.ignore);
    if (res == 0) {
      return false;
    } else {
      return true;
    }
  }

  Future<AttendingPhysician> getAttending(int id) async {
    Database db = await instance.getDatabase;
    var res = await db.query(
      _tableAttending,
      where: 'attending_id =$id',
    );
    List<AttendingPhysician> attending =
        res.map((e) => AttendingPhysician.fromMap(e)).toList();
    return attending[0];
  }

  Future<int> update(PatientLog form) async {
    Database db = await instance.getDatabase;
    int id = form.toMap()['id'];
    return await db.update(_tablePatientLog, form.toMap(),
        where: '$columnId =?', whereArgs: [id]);
  }

  Future<int> remove(int? id) async {
    Database db = await instance.getDatabase;
    return await db
        .delete(_tablePatientLog, where: '$columnId = ?', whereArgs: [id]);
  }

  Future<int> insertTibbi(ProcedureLog form) async {
    Database db = await instance.getDatabase;

    return await db.insert(_tablePatientLog, form.toMap());
  }

  Future<List<ProcedureLog>> getTibbiForms() async {
    Database db = await instance.getDatabase;
    var forms = await db.query(_tablePatientLog, orderBy: 'id DESC');
    List<ProcedureLog> formList = forms.isNotEmpty
        ? forms.map((e) => ProcedureLog.fromJson(e)).toList()
        : [];

    return formList;
  }

  Future<int> updateTibbi(ProcedureLog form) async {
    Database db = await instance.getDatabase;
    int id = form.toMap()['id'];
    return await db.update(_tablePatientLog, form.toMap(),
        where: '$columnId =?', whereArgs: [id]);
  }

  Future<int> removeTibbi(int? id) async {
    Database db = await instance.getDatabase;
    return await db
        .delete(_tablePatientLog, where: '$columnId = ?', whereArgs: [id]);
  }
}
