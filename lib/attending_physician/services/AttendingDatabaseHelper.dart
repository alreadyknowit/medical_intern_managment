import 'dart:convert';

import 'package:http/http.dart' as http;
import 'package:internship_managing_system/DBURL.dart';
import 'package:internship_managing_system/model/PatientLog.dart' as prefix;

import '../../model/PatientLog.dart';
import '../../model/ProcedureLog.dart';

class AttendingDatabaseHelper {
  Future<List<PatientLog>> fetchFormsFromDatabase(String status) async {
    var url = Uri.parse("${DBURL.url}/attending$status.php");
    var response = await http.post(url);

    if (response.statusCode == 200) {
      List<dynamic> data = jsonDecode(response.body);
      List<PatientLog> forms = [];/*data
          .map((e) => prefix.PatientLog.fromJson(e))
          .cast<PatientLog>()
          .toList();
*/
      return forms;
    } else {
      throw Exception('Failed to load data');
    }
  }

// TODO: linkler değişecek
  Future<List<ProcedureLog>> fetchTibbiFormsFromDatabase(String status) async {
    var url = Uri.parse("${DBURL.url}/attending$status.php");
    var response = await http.post(url);

    if (response.statusCode == 200) {
      List<dynamic> data = jsonDecode(response.body);
      List<ProcedureLog> forms =
          data.map((e) => ProcedureLog.fromJson(e)).toList();

      return forms;
    } else {
      throw Exception('Failed to load data');
    }
  }

  Future<bool> updateFromStatus(PatientLog formData) async {
    //if bool is true then accept

    var url = Uri.parse("${DBURL.url}/attending/update.php");

    var headers = {'Content-Type': 'application/x-www-form-urlencoded'};
    var request = http.Request('POST', url);
    request.bodyFields = {
      "form_status": formData.status.toString(),
      "id": formData.id.toString(),
    };
    request.headers.addAll(headers);

    http.StreamedResponse response = await request.send();

    if (response.statusCode == 200) {
      return true;
    } else {
      return false;
    }
  }
}
