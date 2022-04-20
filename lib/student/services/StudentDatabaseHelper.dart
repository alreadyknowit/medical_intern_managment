import 'dart:convert';

import 'package:http/http.dart' as http;
import 'package:internship_managing_system/model/AttendingPhysician.dart';
import 'package:internship_managing_system/model/Course.dart';
import 'package:internship_managing_system/model/Institute.dart';
import 'package:internship_managing_system/model/PatientLog.dart';
import 'package:internship_managing_system/models/form_data.dart';
import 'package:internship_managing_system/models/staj_turu_model.dart';

import '../../DBURL.dart';
import '../../model/Speciality.dart';
import '../../models/tibbi_form_data.dart';

class StudentDatabaseHelper {
  //get data from sql
  Future<List<FormData>> fetchFormsFromDatabase(String status) async {
    var url = Uri.parse("${DBURL.url}$status.php");
    var response = await http.post(url);
    if (response.statusCode == 200) {
      List<dynamic> data = jsonDecode(response.body);
      List<FormData> forms = data.map((e) => FormData.fromJson(e)).toList();
      return forms;
    } else {
      throw Exception('Failed to load data');
    }
  }

  Future<List<TibbiFormData>> fetchTibbiFormsFromDatabase(String status) async {
    //TODO: change url
    var url = Uri.parse("${DBURL.url}$status.php");
    var response = await http.post(url);
    if (response.statusCode == 200) {
      List<dynamic> tibbidata = jsonDecode(response.body);
      List<TibbiFormData> tibbiforms =
          tibbidata.map((e) => TibbiFormData.fromJson(e)).toList();
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

  /*

  await Hazırlık 5 dk

    Yürüyüş 10dk

    Kimlik okutma 10sn

    Ders 40dk


   */

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
    var url = Uri.parse("${DBURL.url}/attending-physicians?specialityId=2");
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
  Future insertFormToDatabase1(PatientLog patientLog) async {
    var url = Uri.parse("${DBURL.url}/patient-logs");

    var headers = {'Content-Type': 'application/x-www-form-urlencoded'};
    var request = http.Request('POST', url);

    print(patientLog.kayitNo);
    request.bodyFields = {
      "studentId": "2",
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
  }

  Future insertFormToDatabase(FormData formData) async {
    var url = Uri.parse("${DBURL.url}/insert.php");

    var headers = {'Content-Type': 'application/x-www-form-urlencoded'};
    var request = http.Request('POST', url);

    print(formData.getKayitNo());
    request.bodyFields = {
      "kayit_no": formData.getKayitNo(),
      "staj_turu": formData.getStajTuru(),
      "yas": formData.getYas(),
      "klinik_egitici": formData.getDoktor(),
      "cinsiyet": formData.getCinsiyet(),
      "sikayet": formData.getSikayet(),
      "ayirici_tani": formData.getAyiriciTani(),
      "kesin_tani": formData.getKesinTani(),
      "tedavi_yontemi": formData.getTedaviYontemi(),
      "etkilesim_turu": formData.getEtkilesimTuru(),
      "kapsam": formData.getKapsam(),
      "ortam": formData.getOrtam(),
      "form_status": formData.getStatus(),
      "tarih": formData.getTarih(),
      "staj_kodu": "asdasd",
      "afdsdas": "fsafasfasf"
    };
    request.headers.addAll(headers);

    http.StreamedResponse response = await request.send();

    if (response.statusCode == 200) {
      return true;
    } else {
      return false;
    }
  }

// adding tibbi data to sql

  Future insertTibbiFormToDatabase(TibbiFormData tibbiFormData) async {
    var res = await http.post(
      Uri.parse(
          'https://medinternshipapp.000webhostapp.com/flutter/tibbi/insert.php'),
      headers: <String, String>{
        'Content-Type': 'application/json; charset=UTF-8',
      },
      body: jsonEncode(<String, String>{
        "kayit_no": tibbiFormData.getKayitNo(),
        "klinik_egitici": tibbiFormData.getDoktor(),
        "etkilesim_turu": tibbiFormData.getTibbiEtkilesimTuru(),
        "tibbi_uygulama": tibbiFormData.getTibbiUygulama(),
        "dis_kurum": tibbiFormData.getDisKurum(),
        "gerceklestigi_ortam": tibbiFormData.getTibbiOrtam(),
        "form_status": tibbiFormData.getStatus(),
        "tarih": tibbiFormData.getTarih()
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
