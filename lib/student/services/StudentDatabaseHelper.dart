import 'dart:convert';
import 'package:http/http.dart' as http;
import 'package:internship_managing_system/model/Course.dart';
import 'package:internship_managing_system/model/Institute.dart';
import 'package:internship_managing_system/student/services/SQFLiteHelper.dart';
import 'package:shared_preferences/shared_preferences.dart';
import '../../model/PatientLog.dart';
import '../../DBURL.dart';
import '../../model/AttendingPhysician.dart';
import '../../model/ProcedureLog.dart';
import '../../model/Speciality.dart';

class StudentDatabaseHelper {
  final SQFLiteHelper _helper =SQFLiteHelper.instance;
  //get data from sql
  Future<List<PatientLog>> fetchFormsFromDatabase(String status) async {
    SharedPreferences preferences = await SharedPreferences.getInstance();
    int id = preferences.getInt('id')!;

    var url = Uri.parse("${DBURL.url}/patient-logs?status=$status&studentId=$id");
    var response = await http.get(url,
        headers: <String, String>{
          'Accept': 'application/json; charset=UTF-8',
        }
    );

    if (response.statusCode == 200) {
      List<dynamic> data = jsonDecode(response.body);
      List<PatientLog> forms = data.map((map){
        PatientLog p =  PatientLog();
        PatientLog res = p.fromJson(map);
        return res;
      }).toList();
      return forms;
    } else {
      throw Exception("HATA!");
    }
  }

  Future<List<ProcedureLog>> fetchTibbiFormsFromDatabase(String status) async {
    //TODO: change url
    var url = Uri.parse("${DBURL.url}$status.php");
    var response = await http.post(url);
    if (response.statusCode == 200) {
      List<dynamic> tibbidata = jsonDecode(response.body);
      List<ProcedureLog> tibbiforms =
          tibbidata.map((e) => ProcedureLog.fromJson(e)).toList();
      return tibbiforms;
    } else {
      throw Exception('Failed to load data');
    }
  }

  Future<List<Course>> fetchCourses() async {
    var url = Uri.parse("${DBURL.url}/courses");
    var response = await http.get(url);

    if (response.statusCode == 200) {
      List<dynamic> data = jsonDecode(response.body);
      List<Course> courses = data.map((e) => Course.fromJSON(e)).toList();
      for(Course c in courses){
        await _helper.insertCourse(c);
      }
      return courses;
    } else {
      throw Exception('Failed to load ');
    }
  }

  Future<List<Speciality>> fetchSpeciality() async {
    var url = Uri.parse("${DBURL.url}/specialities?courseId=1");
    var response = await http.get(url);

    if (response.statusCode == 200) {
      List<dynamic> data = jsonDecode(response.body);
      List<Speciality> specialities =
          data.map((e) => Speciality.fromJSON(e)).toList();
     for(Speciality s in specialities){
       await _helper.insertSpecialities(s);
     }
      return specialities;
    } else {
      throw Exception('Failed to load specialities ');
    }
  }

  Future<List<Institute>> fetchInstitute() async {
    var url = Uri.parse("${DBURL.url}/institutes");
    var response = await http.get(url);

    if (response.statusCode == 200) {
      List<dynamic> data = jsonDecode(response.body);
      List<Institute> institutes =
          data.map((e) => Institute.fromJSON(e)).toList();
      for(Institute i in institutes){
        await _helper.insertInstitute(i);
      }
      return institutes;
    } else {
      throw Exception('Failed to load ');
    }
  }

  //get attending physician table
  Future<List<AttendingPhysician>> fetchAttendingPhysicians() async {
    var url = Uri.parse("${DBURL.url}/attending-physicians?specialityId=1");

    var response = await http.get(url, headers: <String, String>{
      'Accept': 'application/json; charset=UTF-8',
    },);
    if (response.statusCode == 200) {
      List<dynamic> data = jsonDecode(response.body);
      List<AttendingPhysician> listAttendings =
          data.map((e) => AttendingPhysician.fromJSON(e)).toList();
      for(AttendingPhysician a in listAttendings){
        await _helper.insertAttending(a);
      }
      return listAttendings;
    } else {
      throw Exception('Failed to load data');
    }
  }

/*  Future insertFormToDatabasee(FormData formData) async {
    final response = await http.get(Uri.parse("${DBURL.url}/insert.php"));
    if(response.statusCode == 200 || response.statusCode ==201)
      return
  }*/

  //add data to sql
  Future insertFormToDatabase(PatientLog patientLog) async {

    SharedPreferences preferences = await SharedPreferences.getInstance();
    int id = preferences.getInt('id')!;
    var url = Uri.parse("${DBURL.url}/patient-logs");
    final response = await http.post(url,
        headers: <String, String>{
          'Content-Type': 'application/json; charset=UTF-8',
        },

        body: jsonEncode({
          "studentId":id ,
          "instituteId": patientLog.institute?.id.toString(),
          "attendingId": patientLog.attendingPhysician?.id.toString(),
          "coordinatorId": "1",
          "specialityId": patientLog.speciality?.id.toString(),
          "courseId": patientLog.course?.id.toString(),
          "kayitNo": patientLog.kayitNo.toString(),
          "yas": patientLog.yas.toString(),
          "cinsiyet": patientLog.cinsiyet.toString(),
          "sikayet": patientLog.sikayet.toString(),
          "ayiriciTani": patientLog.ayiriciTani.toString(),
          "kesinTani": patientLog.kesinTani.toString(),
          "tedaviYontemi": patientLog.tedaviYontemi.toString(),
          "etkilesimTuru": patientLog.etkilesimTuru.toString(),
          "kapsam": patientLog.kapsam.toString(),
          "gerceklestigiOrtam": patientLog.gerceklestigiOrtam.toString(),
          "status": "waiting"
        }));

    if (response.statusCode == 201) {
      return true;
    } else {
      return false;
    }
  }



  Future insertTibbiFormToDatabase(ProcedureLog tibbiFormData) async {
    var res = await http.post(
      Uri.parse(
          'https://medinternshipapp.000webhostapp.com/flutter/tibbi/insert.php'),
      headers: <String, String>{
        'Content-Type': 'application/json; charset=UTF-8',
      },
      body: jsonEncode(<String, String>{
        "studentId": "1",
        "specialityId": tibbiFormData.speciality.toString(),
        "coordinatorId": "1",
        "kayit_no": tibbiFormData.kayitNo.toString(),
        "attendingId": tibbiFormData.attendingPhysician.toString(),
        "etkilesim_turu": tibbiFormData.etkilesimTuru.toString(),
        "tibbi_uygulama": tibbiFormData.tibbiUygulama.toString(),
        "dis_kurum": tibbiFormData.disKurum.toString(),
        "gerceklestigi_ortam": tibbiFormData.gerceklestigiOrtam.toString(),
        "form_status": tibbiFormData.status.toString(),
        "tarih": tibbiFormData.createdAt.toString()
      }),
    );
    return (res.statusCode == 200) ? true : false;
  }

}
