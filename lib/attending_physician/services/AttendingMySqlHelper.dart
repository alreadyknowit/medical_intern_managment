import 'package:internship_managing_system/models/form_data.dart';
import 'package:mysql1/mysql1.dart';

class AttendingMySqlHelper{
  final String _host = '10.0.2.2'; //
  final String _user = 'root';//
  final String _password = '1234';//
  final int _portNo = 3306;
  final String _tableName = 'form_table';
  final String _db = 'forms';//

  final columnId = 'id';
  final columnKayitNo = 'kayit_no';
  final columnSikayet = 'sikayet';
  final columnStajTuru = 'staj_turu';
  final columnKlinikEgitici = 'klinik_egitici';
  final columnCinsiyet = 'cinsiyet';
  final columnEtkilesimTuru = 'etkilesim_turu';
  final columnKapsam = 'kapsam';
  final columnOrtam = 'ortam';
  final columnYas = 'yas';
  final columnAyiriciTani = 'ayirici_tani';
  final columnKesinTani = 'kesin_tani';
  final columnTedaviYontemi = 'tedavi_yontemi';
  final columnTarih = 'tarih';
  final columnStatus = 'status';

  Future<MySqlConnection> connectDB() async {
    var conn = null;
    try {
      conn = await MySqlConnection.connect(ConnectionSettings(
          port: _portNo,
          host: _host,
          password: _password,
          db: _db,
          user: _user));
      return conn;
    } catch (e) {
      print(e);
      return conn;
    }
  }

  //get waiting forms
  Future<List<FormData>> fetchForms(String status) async {
    List<FormData> formList = [];
    try {
      MySqlConnection conn = await connectDB().then((value) => value);
      var list = await conn.query('select * from $_tableName where $columnStatus=?  order by id ASC',[status]);
      for (var form in list) {
        list.isNotEmpty
            ? formList.add(
          FormData(
              id: form[columnId],
              kayitNo: form[columnKayitNo],
              stajTuru: form[columnStajTuru],
              yas: form[columnYas].toString(),
              doktor: form[columnKlinikEgitici],
              cinsiyet: form[columnCinsiyet],
              sikayet: form[columnSikayet].toString(),
              ayiriciTani: form[columnAyiriciTani].toString(),
              kesinTani: form[columnKesinTani].toString(),
              tedaviYontemi: form[columnTedaviYontemi].toString(),
              etkilesimTuru: form[columnEtkilesimTuru],
              kapsam: form[columnKapsam],
              gerceklestigiOrtam: form[columnOrtam],
              tarih: form[columnTarih],
              status: form[columnStatus]),
        )
            : [];
      }
      await conn.close();
      return formList;
    } catch (e) {
      print(e);
      return formList;
    }
  }

  //update
  Future<bool> update(FormData form) async {
    try {
      MySqlConnection conn = await connectDB().then((value) => value);
      await conn.query('update $_tableName set $columnStatus=? where id=?',
          [form.status,form.id]);
      await conn.close();
      return true;
    } catch (e) {
      print(e);
      return false;
    }
  }

}