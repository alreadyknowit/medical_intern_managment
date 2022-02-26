import 'package:internship_managing_system/models/form_data.dart';
import 'package:path/path.dart';
import 'package:sqflite/sqflite.dart';

class SQFLiteHelper {
  final _databaseName = 'newDrafts.db';
  final _databaseVersion = 1;
  final _tableName = 'table_drafts';
  static const columnId = 'id';
  static const columnKayitNo = 'kayit_no';
  static const columnSikayet = 'sikayet';
  static const columnStajTuru = 'staj_turu';
  static const columnKlinikEgitici = 'klinik_egitici';
  static const columnCinsiyet = 'cinsiyet';
  static const columnEtkilesimTuru = 'etkilesim_turu';
  static const columnKapsam = 'kapsam';
  static const columnOrtam = 'ortam';
  static const columnYas = 'yas';
  static const columnAyiriciTani = 'ayirici_tani';
  static const columnKesinTani = 'kesin_tani';
  static const columnTedaviYontemi = 'tedavi_yontemi';
  static const columnTarih='tarih';
  static const columnStatus='form_status';

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

  Future _onCreate(Database db, int version) async {
    await db.execute('''
    CREATE TABLE $_tableName (
    $columnId INTEGER PRIMARY KEY AUTOINCREMENT,
    $columnKayitNo TEXT, 
    $columnSikayet TEXT,
    $columnStajTuru TEXT,
    $columnKlinikEgitici TEXT,
    $columnCinsiyet TEXT,
    $columnEtkilesimTuru TEXT,
    $columnKapsam TEXT,
    $columnOrtam TEXT,
    $columnYas TEXT,
    $columnAyiriciTani TEXT,
    $columnKesinTani TEXT,
    $columnTedaviYontemi TEXT,
    $columnTarih TEXT,
    $columnStatus TEXT
    )
    ''');
  }

  Future<int> insert(FormData form) async {
    Database db = await instance.getDatabase;

    return await db.insert(_tableName, form.toMap());
  }

  Future<List<FormData>> getForms() async {
    Database db = await instance.getDatabase;
    var forms = await db.query(_tableName, orderBy: 'id DESC');
    List<FormData> formList =
        forms.isNotEmpty ? forms.map((e) => FormData.fromJson(e)).toList() : [];

    return formList;
  }

  Future<int> update(FormData form) async {
    Database db = await instance.getDatabase;
    int id = form.toMap()['id'];
    return await db.update(_tableName, form.toMap(),
        where: '$columnId =?', whereArgs: [id]);
  }

  Future<int> remove(int? id) async {
    Database db = await instance.getDatabase;
    return await db.delete(_tableName, where: '$columnId = ?', whereArgs: [id]);
  }
}
