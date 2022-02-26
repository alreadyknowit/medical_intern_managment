import 'dart:convert';
import 'package:http/http.dart' as http;
import 'package:internship_managing_system/models/attending.dart';
import 'package:internship_managing_system/models/form_data.dart';
import 'package:internship_managing_system/models/staj_turu_model.dart';
import '../../DBURL.dart';

class StudentDatabaseHelper {
  //get data from sql
  Future<List<FormData>> fetchFormsFromDatabase(String status) async {
    var url = Uri.parse("${DBURL.url}$status.php");
    var response = await http.post(url);
    if (response.statusCode == 200) {

      List<dynamic> data= jsonDecode(response.body);
      List<FormData> forms=data.map((e) => FormData.fromJson(e)).toList();
      return forms;
    } else {
      throw Exception('Failed to load data');
    }
  }
  //get staj_turu table
  Future<List<StajTuru>> fetchStajTuruTable() async {
    var url = Uri.parse("${DBURL.url}/staj_turu.php");
    var response = await http.post(url);

    if (response.statusCode == 200) {

      List<dynamic> data= jsonDecode(response.body);
      List<StajTuru> content=data.map((e) => StajTuru.fromJSON(e)).toList();
      return content;
    } else {
      throw Exception('Failed to load data');
    }
  }

  //get attending physician table
  Future<List<AttendingPhysicianModel>> fetchAttendingPhysicians() async {
    var url = Uri.parse("${DBURL.url}/attending_list.php");
    var response = await http.post(url);
    if (response.statusCode == 200) {

      List<dynamic> data= jsonDecode(response.body);
   List<AttendingPhysicianModel> listAttendings= data.map((e) => AttendingPhysicianModel.fromJSON(e)).toList();


       return listAttendings;
    } else {
      throw Exception('Failed to load data');
    }
  }

  //add data to sql
  Future insertFormToDatabase(FormData formData) async{
    var url = Uri.parse("${DBURL.url}/insert.php");

    var headers = {
      'Content-Type': 'application/x-www-form-urlencoded'
    };
    var request = http.Request('POST', url);
    request.bodyFields = {
       "kayit_no":formData.getKayitNo(),
       "staj_turu":formData.getStajTuru(),
       "yas":formData.getYas(),
       "klinik_egitici":formData.getDoktor(),
       "cinsiyet":formData.getCinsiyet(),
       "sikayet":formData.getSikayet(),
       "ayirici_tani":formData.getAyiriciTani(),
       "kesin_tani":formData.getKesinTani(),
       "tedavi_yontemi":formData.getTedaviYontemi(),
       "etkilesim_turu":formData.getEtkilesimTuru(),
       "kapsam":formData.getKapsam(),
       "ortam":formData.getOrtam(),
      "form_status":formData.getStatus(),
      "tarih":formData.getTarih(),
    };
    request.headers.addAll(headers);

    http.StreamedResponse response = await request.send();

    if (response.statusCode == 200) {
      print("success");

      return true;
    }
    else {
      print("failed");
    return false;
    }

  }

}
