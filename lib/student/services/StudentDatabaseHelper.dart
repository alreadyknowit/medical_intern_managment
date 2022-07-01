import 'dart:convert';

import 'package:http/http.dart' as http;
import 'package:internship_managing_system/model/Course.dart';
import 'package:internship_managing_system/model/Institute.dart';
import 'package:internship_managing_system/model/PatientLog.dart';
import 'package:internship_managing_system/models/staj_turu_model.dart';

import '../../DBURL.dart';
import '../../model/AttendingPhysician.dart';
import '../../model/ProcedureLog.dart';
import '../../model/Speciality.dart';

// TODO: linkler değişecek
class StudentDatabaseHelper {
  //get data from sql
  Future<List<PatientLog>> fetchFormsFromDatabase(String status) async {
    var url = Uri.parse("${DBURL.url}/patient-logs?status=waiting&studentId=1");
    var response = await http.post(url);
    if (response.statusCode == 200) {
      List<dynamic> data = jsonDecode(response.body);
      List<PatientLog> forms = data.map((e) => PatientLog.fromJson(e)).toList();
      return forms;
    } else {
      throw Exception('Failed to load data');
    }
  }

  Future<List<PatientLog>> getData(String newsType) async {
    // TODO: deneme kodları
    List<PatientLog> list;
    String link =
        "http://medicalinternbackend-env.eba-d7ipqppw.eu-south-1.elasticbeanstalk.com/api/v1/patient-logs?status=waiting&studentId=1";
    var res = await http
        .get(Uri.parse(link), headers: {"Accept": "application/json"});
    print(res.body);
    if (res.statusCode == 200) {
      var data = json.decode(res.body);
      var rest = data["patient-logs"] as List;
      print(rest);
      list = rest.map<PatientLog>((json) => PatientLog.fromJson(json)).toList();
    } else {
      list = [];
      print("la la land");
      print(res.statusCode);
    }
    print("List Size: ${list.length}");
    return list;
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

  //get staj_turu table
  Future<List<StajTuru>> fetchStajTuruTable() async {
    var url = Uri.parse("${DBURL.url}/staj_turu.php");
    var response = await http.post(url);

    if (response.statusCode == 200) {
      List<dynamic> data = jsonDecode(response.body);
      List<StajTuru> content = data.map((e) => StajTuru.fromJSON(e)).toList();
      return content;
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
      List<Speciality> speciality =
          data.map((e) => Speciality.fromJSON(e)).toList();
      return speciality;
    } else {
      throw Exception('Failed to load ');
    }
  }

  Future<List<Institute>> fetchInstitute() async {
    var url = Uri.parse("${DBURL.url}/institutes");
    var response = await http.get(url);

    if (response.statusCode == 200) {
      List<dynamic> data = jsonDecode(response.body);
      List<Institute> institute =
          data.map((e) => Institute.fromJSON(e)).toList();

      return institute;
    } else {
      throw Exception('Failed to load ');
    }
  }

  //get attending physician table
  Future<List<AttendingPhysician>> fetchAttendingPhysicians() async {
    var url = Uri.parse("${DBURL.url}/attending-physicians");
    var response = await http.get(url);
    if (response.statusCode == 200) {
      List<dynamic> data = jsonDecode(response.body);
      List<AttendingPhysician> listAttendings =
          data.map((e) => AttendingPhysician.fromJSON(e)).toList();

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
  /*Future insertFormToDatabase1(PatientLog patientLog) async {
    var url = Uri.parse("${DBURL.url}/patient-logs");

    var headers = {'Content-Type': 'application/json'};
    var request = http.Request('POST', url);

    print(patientLog.kayitNo);
    request.bodyFields = {
      "studentId": "1",
      "kayitNo": patientLog.kayitNo.toString(),
      "yas": patientLog.yas.toString(),
      "specialityId": patientLog.speciality.toString(),
      "coordinatorId": "1",
      "attendingId": patientLog.attendingPhysician.toString(),
      "cinsiyet": patientLog.cinsiyet.toString(),
      "sikayet": patientLog.sikayet.toString(),
      "ayiriciTani": patientLog.ayiriciTani.toString(),
      "kesinTani": patientLog.kesinTani.toString(),
      "tedaviYontemi": patientLog.tedaviYontemi.toString(),
      "etkilesimTuru": patientLog.etkilesimTuru.toString(),
      "kapsam": patientLog.kapsam.toString(),
      "ortam": patientLog.gerceklestigiOrtam.toString(),
      "status": patientLog.status.toString(),
      "tarih": patientLog.createdAt.toString(),
      "courseId": "1",
      "instituteId": "1",
    };
    request.headers.addAll(headers);

    http.StreamedResponse response = await request.send();

    if (response.statusCode == 200) {
      return true;
    } else {
      return false;
    }
  }*/

  Future insertFormToDatabase(PatientLog patientLog) async {
    var url = Uri.parse("${DBURL.url}/patient-logs");

    print("attending");
    print(patientLog.attendingPhysician?.attendingName.toString());
    print("institute");
    print(patientLog.instute?.instituteName.toString());
    print("course");
    print(patientLog.course?.id.toString());
    print("spec");
    print(patientLog.speciality?.id.toString());
    print("ortam");
    print(patientLog.gerceklestigiOrtam);
    print("kapsam");
    print(patientLog.kapsam);
    print("etkileşim türü");
    print(patientLog.etkilesimTuru);
    print("cinsiyet");
    print(patientLog.cinsiyet);
    print("id");
    print(patientLog.kayitNo);
    print("hastanın yaşı");
    print(patientLog.yas);
    print("şikayet");
    print(patientLog.sikayet);
    print("ayırıcı tanı");
    print(patientLog.ayiriciTani);
    print("kesin tanı");
    print(patientLog.kesinTani);
    print("tedav, yöntemi");
    print(patientLog.tedaviYontemi);
    final response = await http.post(url,
        headers: <String, String>{
          'Content-Type': 'application/json; charset=UTF-8',
        },
        body: jsonEncode({
          "studentId": "3",
          "instituteId": patientLog.instute?.id.toString(),
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
          "status": patientLog.status.toString()
        }));

    print(response.statusCode);
    if (response.statusCode == 201) {
      return true;
    } else {
      return false;
    }
  }

// adding tibbi data to sql

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

  /* Future insertTibbiFormToDatabase(TibbiFormData tibbiFormData) async {
    var url = Uri.parse("${DBURL.url}/tibbi/insert.php");

    var headers = {'Content-Type': 'application/x-www-form-urlencoded'};
    var request = http.Request('POST', url);
    request.bodyFields = {
      "kayit_no": tibbiFormData.getKayitNo(),
      "klinik_egitici": tibbiFormData.getDoktor(),
      "etkilesim_turu": tibbiFormData.getTibbiEtkilesimTuru(),
      "tibbi_uygulama": tibbiFormData.getTibbiUygulama(),
      "dis_kurum": tibbiFormData.getDisKurum(),
      "gerceklestigi_ortam": tibbiFormData.getTibbiOrtam(),
      "form_status": tibbiFormData.getStatus(),
      "tarih": tibbiFormData.getTarih(),
    };
    request.headers.addAll(headers);

    http.StreamedResponse response = await request.send();

    if (response.statusCode == 200) {
      print("success");

      return true;
    } else {
      print("failed");
      return false;
    }
  }*/
}
