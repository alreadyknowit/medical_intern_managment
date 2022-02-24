import 'package:internship_managing_system/models/form_data.dart';
import 'package:mysql1/mysql1.dart';

//TODO: close connections
class MySqlHelper {
  final String _host ='10.0.2.2';
  final String _user ='root';
  final String _password = '1234';
  final int _portNo = 3306;
  final String _formTableName = 'form_table';
  final String _db = 'forms';
  final String doktorTableName = 'attending_table';
  final String stajTuruTableName = 'staj_turu_table';

  //attending_table
  final columnDoktorName = 'doktor_ad';
  final columnStajTuruName = 'staj_turu';

  //form_table
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
    late var conn;
    try {
      conn = await MySqlConnection.connect(ConnectionSettings(
          port: _portNo,
          host: _host,
          password: _password,
          db: _db,
          user: _user));

      return conn;
    } catch (e) {
      print(e.hashCode);
      return conn;
    }
  }

  //get form content from db
  Future<List<String>> fetchFormContent(
      String columnName, String tableName) async {
    List<String> resultList = [];
    late MySqlConnection conn;
    try {

      conn = await connectDB();
      var list = await conn.query('select $columnName from $tableName');

      for (var item in list) {
        resultList.add(item[columnName]);
      }
      return resultList;
    } catch (e) {
      print(e);
      return resultList;
    } finally {
      await conn.close();
    }
  }

  //get accepted forms
  Future<List<FormData>> fetchForms(String status, int limit) async {
    List<FormData> formList = [];
    late MySqlConnection conn;
    try {
      conn = await connectDB().then((value) => value);
      var list = await conn.query(
          'select * from $_formTableName where $columnStatus=?  order by id DESC limit $limit',
          [status]);
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

      return formList;
    } catch (e) {
      print(e);
      return formList;
    } finally {
      await conn.close();
    }
  }

//insert new form
  insertData(FormData formData) async {
    late MySqlConnection conn;
    try {
      conn = await connectDB().then((value) => value);
      await conn.query('''insert into $_formTableName($columnKayitNo, 
             $columnSikayet,$columnStajTuru,$columnKlinikEgitici,$columnCinsiyet, 
             $columnEtkilesimTuru, $columnKapsam,$columnOrtam,$columnYas, 
             $columnAyiriciTani, $columnKesinTani,$columnTedaviYontemi,$columnTarih,$columnStatus) 
             values(?,?,?,?,?,?,?,?,?,?,?,?,?,?)''', [
        formData.kayitNo,
        formData.sikayet,
        formData.stajTuru,
        formData.doktor,
        formData.cinsiyet,
        formData.etkilesimTuru,
        formData.kapsam,
        formData.gerceklestigiOrtam,
        formData.yas,
        formData.ayiriciTani,
        formData.kesinTani,
        formData.tedaviYontemi,
        formData.tarih,
        formData.status
      ]);
      return true;
    } catch (e) {
      print(e);
      return false;
    } finally {
      await conn.close();
    }
  }

}
