import 'dart:convert';

import 'package:http/http.dart' as http;
import 'package:internship_managing_system/models/form_data.dart';
class DbService{

Future<FormData> createForm(String kayitNo,String stajTuru,String doktor,String yas,String cinsiyet,String sikayet,String ayirici,String kesin,String tedavi,String ortam,String etkilesim,String kapsam) async {

  final response = await http.post(
    Uri.parse('http://10.0.2.2:3000/form_info'),
    headers: <String, String>{
      'Content-Type': 'application/json; charset=UTF-8',
    },
    body: jsonEncode(<String, String>{
      'kayit_no': kayitNo,
      'staj_turu': stajTuru,
      'doktor': doktor,
      'yas': yas,
      'cinsiyet': cinsiyet,
      'sikayet': sikayet,
      'ayirici':ayirici,
      'kesin': kesin,
      'tedavi': tedavi,
      'ortam': ortam,
      'etkilesim': etkilesim,
      'kapsam': kapsam,
    }),
  );

  if (response.statusCode == 201) {
    // If the server did return a 201 CREATED response,
    // then parse the JSON.
    return FormData.fromJson(jsonDecode(response.body));
  } else {
    // If the server did not return a 201 CREATED response,
    // then throw an exception.
    throw Exception('Failed to create album.');
  }
}
}