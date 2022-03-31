import 'dart:convert';

import 'package:http/http.dart' as http;
import 'package:internship_managing_system/DBURL.dart';
import 'package:internship_managing_system/models/tibbi_form_data.dart';

import '../../models/form_data.dart';

class AttendingDatabaseHelper {
  Future<List<FormData>> fetchFormsFromDatabase(String status) async {
    var url = Uri.parse("${DBURL.url}/attending$status.php");
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
    var url = Uri.parse("${DBURL.url}/attending$status.php");
    var response = await http.post(url);

    if (response.statusCode == 200) {
      List<dynamic> data = jsonDecode(response.body);
      List<TibbiFormData> forms =
          data.map((e) => TibbiFormData.fromJson(e)).toList();

      return forms;
    } else {
      throw Exception('Failed to load data');
    }
  }

  Future<bool> updateFromStatus(FormData formData) async {
    //if bool is true then accept

    var url = Uri.parse("${DBURL.url}/attending/update.php");

    var headers = {'Content-Type': 'application/x-www-form-urlencoded'};
    var request = http.Request('POST', url);
    request.bodyFields = {
      "form_status": formData.getStatus(),
      "id": formData.getID().toString(),
    };
    request.headers.addAll(headers);

    http.StreamedResponse response = await request.send();

    if (response.statusCode == 200) {
      print("success");
      print(await response.stream.bytesToString());
      return true;
    } else {
      print("failed");
      print(response.reasonPhrase);
      return false;
    }
  }
}
