import 'package:internship_managing_system/model/PatientLog.dart' as prefix;
import 'package:path/path.dart';
import 'package:sqflite/sqflite.dart';

import '../../model/PatientLog.dart ';
import '../../model/ProcedureLog.dart';

class SQFLiteHelper {
  final _databaseName = 'newDrafts.db';
  final _databaseVersion = 1;
  final _tableName = 'table_drafts';
  static const columnId = 'id';
  static const columnInstituteId = 'institute_id';
  static const columnCoursesId = 'courses_id';
  static const columnSpecialitiesId = 'speciality_id';
  static const columnAttendingPhysicianId = 'attendingPhysician_id';
  static const columnKayitNo = 'kayit_no';
  static const columnSikayet = 'sikayet';
  static const columnStajTuru = 'staj_turu';
  static const columnCinsiyet = 'cinsiyet';
  static const columnEtkilesimTuru = 'etkilesim_turu';
  static const columnKapsam = 'kapsam';
  static const columnOrtam = 'ortam';
  static const columnYas = 'yas';
  static const columnAyiriciTani = 'ayirici_tani';
  static const columnKesinTani = 'kesin_tani';
  static const columnTedaviYontemi = 'tedavi_yontemi';
  static const columnTarih = 'tarih';
  static const columnTibbiEtkilesimTuru = 'etkilesim_turu';
  static const columnStatus = 'form_status';
  static const columntibbiOrtam = 'tibbi_ortam';
  static const columndisKurum = 'dıs_kurum';
  static const columntibbiUygulama = 'tibbi_uygulama';

  SQFLiteHelper._privateConstructor();
  static final SQFLiteHelper instance = SQFLiteHelper._privateConstructor();
  static Database? _database;

  Future<Database> get getDatabase async {
    return _database ?? await _initDatabase();
  }

  Future<Database> _initDatabase() async {
    String path = join(await getDatabasesPath(), _databaseName);
    return await openDatabase(path,
        version: _databaseVersion, onCreate: _onCreate);
  }

//TODO: SQL lite ' a speciality id eklenecek
  Future _onCreate(Database db, int version) async {
    await db.execute('''
    CREATE TABLE $_tableName (
    $columnId INTEGER PRIMARY KEY AUTOINCREMENT,
    $columnInstituteId TEXT,
    $columnCoursesId TEXT,
    
    $columnAttendingPhysicianId TEXT,   
    $columnKayitNo TEXT, 
    $columnSikayet TEXT,
    $columnStajTuru TEXT,
    $columnCinsiyet TEXT,
    $columnEtkilesimTuru TEXT,
    $columnKapsam TEXT,
    $columnOrtam TEXT,
    $columnYas TEXT,
    $columnAyiriciTani TEXT,
    $columnKesinTani TEXT,
    $columnTedaviYontemi TEXT,
    $columnTarih TEXT,
    $columnStatus TEXT,
    $columntibbiUygulama TEXT,
    $columndisKurum TEXT,
   
    )
    ''');
  }

  Future<int> insert(prefix.PatientLog form) async {
    Database db = await instance.getDatabase;

    return await db.insert(_tableName, form.toMap());
  }

  Future<List> getForms() async {
    Database db = await instance.getDatabase;
    var forms = await db.query(_tableName, orderBy: 'id DESC');
    List formList = forms.isNotEmpty
        ? forms.map((e) => PatientLog.fromJson(e)).toList()
        : [];

    return formList;
  }

  Future<int> update(PatientLog form) async {
    Database db = await instance.getDatabase;
    int id = form.toMap()['id'];
    return await db.update(_tableName, form.toMap(),
        where: '$columnId =?', whereArgs: [id]);
  }

  Future<int> remove(int? id) async {
    Database db = await instance.getDatabase;
    return await db.delete(_tableName, where: '$columnId = ?', whereArgs: [id]);
  }

  Future<int> insertTibbi(ProcedureLog form) async {
    Database db = await instance.getDatabase;

    return await db.insert(_tableName, form.toMap());
  }

  Future<List<ProcedureLog>> getTibbiForms() async {
    Database db = await instance.getDatabase;
    var forms = await db.query(_tableName, orderBy: 'id DESC');
    List<ProcedureLog> formList = forms.isNotEmpty
        ? forms.map((e) => ProcedureLog.fromJson(e)).toList()
        : [];

    return formList;
  }

  Future<int> updateTibbi(ProcedureLog form) async {
    Database db = await instance.getDatabase;
    int id = form.toMap()['id'];
    return await db.update(_tableName, form.toMap(),
        where: '$columnId =?', whereArgs: [id]);
  }

  Future<int> removeTibbi(int? id) async {
    Database db = await instance.getDatabase;
    return await db.delete(_tableName, where: '$columnId = ?', whereArgs: [id]);
  }
}
