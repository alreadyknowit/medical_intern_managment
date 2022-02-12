import 'package:internship_managing_system/models/form_data.dart';
import 'package:path/path.dart';
import 'package:sqflite/sqflite.dart';

class SQFLiteHelper {
  final _databaseName = 'drafts.db';
  final _databaseVersion = 1;
  final _tableName = 'drafts_table';
  static const columnId = 'id';
  static const columnKayitNo = 'kayitNo';
  static const columnSikayet = 'sikayet';
  static const columnStajTuru ='stajTuru';
  static const columnKlinikEgitici='klinikEgitici';
  static const columnCinsiyet ='cinsiyet';
  static const columnEtkilesimTuru='etkilesimTuru';
  static const columnKapsam='kapsam';
  static const columnOrtam='ortam';
  static const columnYas='yas';
  static const columnAyiriciTani='ayiriciTani';
  static const columnKesinTani='kesinTani';
  static const columnTedaviYontemi='tedaviYontemi';

  SQFLiteHelper._privateConstructor();
  static final SQFLiteHelper instance = SQFLiteHelper._privateConstructor();
  static Database? _database;

  Future<Database> get getDatabase async {
    return _database ?? await _initDatabase();
  }

  Future<Database> _initDatabase() async {
    String path = join(await getDatabasesPath(), _databaseName);
    print(path);
    return await openDatabase(path,
        version: _databaseVersion, onCreate: _onCreate);
  }
  Future _onCreate(Database db, int version) async {
    print("on create is used "); // this line never executed so, never a db is created.
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
    $columnYas INTEGER,
    $columnAyiriciTani TEXT,
    $columnKesinTani TEXT,
    $columnTedaviYontemi TEXT
    )
    ''');
  }
  Future<int> insert(FormData form) async {
    Database db =  await instance.getDatabase ; //The error occuring here
    print("db is: " + db.toString());
    return await db.insert(_tableName, {
      columnId:form.id,
      columnKayitNo: form.kayitNo,
      columnSikayet: form.sikayet,
      columnStajTuru:form.stajTuru,
      columnKlinikEgitici:form.doktor,
      columnCinsiyet:form.cinsiyet,
      columnEtkilesimTuru:form.etkilesimTuru,
      columnKapsam:form.kapsam,
      columnOrtam:form.gerceklestigiOrtam,
      columnYas:form.yas,
      columnAyiriciTani:form.ayiriciTani,
      columnKesinTani:form.kesinTani,
      columnTedaviYontemi:form.tedaviYontemi
    });
  }

  Future<List<FormData>> getForms() async {
    Database db = await instance.getDatabase;
    var forms =await db.query(_tableName);
    List<FormData> formList = forms.isNotEmpty ? forms.map((e) => FormData.fromMap(e)).toList() : [];
    return formList;

  }
}
