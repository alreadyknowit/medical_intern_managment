import 'dart:convert';

import 'package:http/http.dart' as http;
import 'package:internship_managing_system/DBURL.dart';
import 'package:shared_preferences/shared_preferences.dart';

import '../../model/PatientLog.dart';
import '../../model/ProcedureLog.dart';

class AttendingDatabaseHelper {
  Future<List<PatientLog>> fetchFormsFromDatabase(String status) async {
    SharedPreferences preferences = await SharedPreferences.getInstance();
    int id = preferences.getInt('id')!;
    print(id);
   /* preferences.remove('newUser');
    preferences.remove('role');
    preferences.remove('phoneNo');
    preferences.remove('id');
    preferences.remove('name');
    preferences.remove('email');*/
    var url = Uri.parse(
        "${DBURL.url}/patient-logs/attending?status=$status&attendingId=$id");
    var response = await http.get(url, headers: <String, String>{
      'Accept': 'application/json; charset=UTF-8',
    });

    if (response.statusCode == 200) {
      List<dynamic> data = jsonDecode(response.body);
      List<PatientLog> forms = data.map((map) {
        PatientLog p = PatientLog();
        PatientLog res = p.fromJson(map);
        return res;
      }).toList();
      return forms;
    } else {
      throw Exception("HATA!");
    }
  }

  Future<List<ProcedureLog>> fetchTibbiFormsFromDatabase(String status) async {
    SharedPreferences pref =await SharedPreferences.getInstance();
    int id = pref.getInt('id')!;
    var url = Uri.parse("${DBURL.url}/procedures/attending?status=$status&attendingId=$id");
    var response = await http.get(url);

    if (response.statusCode == 200) {
      List<dynamic> data = jsonDecode(response.body);
      List<ProcedureLog> forms =
          data.map((e) {
            ProcedureLog log = ProcedureLog();
            log = log.fromJson(e);
            return log;
          }) .toList();

      return forms;
    } else {
      throw Exception('Failed to load data');
    }

  }

  Future updateProcedureStatus(ProcedureLog procedure) async {
    var url = Uri.parse("${DBURL.url}/procedures/${procedure.id}");
    final response = await http.put(url,
        headers: <String, String>{
          'Content-Type': 'application/json; charset=UTF-8',
        },
        body: jsonEncode({
          "studentId":procedure.student?.id,
          "courseId": procedure.course?.id,
          "attendingId":procedure.attendingPhysician?.id,
          "kayitNo": procedure.kayitNo,
          "specialityId":procedure.speciality?.id,
          "coordinatorId":procedure.coordinator?.id,
          "tibbiUygulama": procedure.tibbiUygulama,
          "etkilesimTuru": procedure.etkilesimTuru,
          "gerceklestigiOrtam": procedure.gerceklestigiOrtam,
          "status": procedure.status
        }));

    if (response.statusCode == 200) {
      return true;
    } else {
      return false;
    }
  }
  Future updateFormStatus(PatientLog patientLog) async {
    var url = Uri.parse("${DBURL.url}/patient-logs/${patientLog.id}");
    final response = await http.put(url,
        headers: <String, String>{
          'Content-Type': 'application/json; charset=UTF-8',
        },
        body: jsonEncode({
          "studentId": patientLog.student?.id,
          "instituteId": patientLog.institute?.id,
          "attendingId": patientLog.attendingPhysician?.id,
          "coordinatorId": patientLog.coordinator?.id,
          "specialityId": patientLog.speciality?.id,
          "courseId": patientLog.course?.id,
          "kayitNo": patientLog.kayitNo,
          "yas": patientLog.yas,
          "cinsiyet": patientLog.cinsiyet,
          "sikayet": patientLog.sikayet,
          "ayiriciTani": patientLog.ayiriciTani,
          "kesinTani": patientLog.kesinTani,
          "tedaviYontemi": patientLog.tedaviYontemi,
          "etkilesimTuru": patientLog.etkilesimTuru,
          "kapsam": patientLog.kapsam,
          "gerceklestigiOrtam": patientLog.gerceklestigiOrtam,
          "status": patientLog.status
        }));

    if (response.statusCode == 200) {
      return true;
    } else {
      return false;
    }
  }
}
