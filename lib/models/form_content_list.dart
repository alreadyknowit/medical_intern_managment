import 'dart:collection';

class FormContent{


  List<String> cinsiyetItems;
  List<String> stajTuruItems;
  List<String> etkilesimTuruItems;
  List<String> kapsamItems;
  List<String> ortamItems;
  List<String> doktorItems;

  FormContent.fromJson(Map<String, dynamic> jsonFile)
      : cinsiyetItems = [...?jsonFile['cinsiyet']],
        stajTuruItems = [...?jsonFile['stajTuru']],
        etkilesimTuruItems = [...?jsonFile['etkilesimTuru']],
        kapsamItems = [...?jsonFile['kapsam']],
        ortamItems = [...?jsonFile['ortam']],
        doktorItems = [...?jsonFile['doktor']];



/*
  late List<dynamic> cinsiyetItems;
  late List<dynamic> stajTuruItems;
  late List<dynamic> etkilesimTuruItems;
  late List<dynamic> kapsamItems;
  late List<dynamic> ortamItems;
  late List<dynamic> doktorItems;



 FormContent.fromJson(Map<String,dynamic> jsonFile){
    cinsiyetItems=jsonFile['cinsiyet'];
    stajTuruItems=jsonFile['stajTuru'];
    etkilesimTuruItems=jsonFile['etkilesimTuru'];
    kapsamItems=jsonFile['kapsam'];
    ortamItems=jsonFile['ortam'];
    doktorItems=jsonFile['doktor'];
  }*/
}