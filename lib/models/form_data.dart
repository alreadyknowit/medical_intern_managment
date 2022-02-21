import 'package:flutter/cupertino.dart';
import 'package:date_format/date_format.dart';

import '../student/services/SQFLiteHelper.dart';

class FormData with ChangeNotifier {
  int? id;
  String? kayitNo;
  String? stajTuru;
  String? doktor; //TODO: Convert string to AttendingPhysician type object
  String? yas; // TODO: Convert to int later
  String? cinsiyet;
  String? sikayet;
  String? ayiriciTani;
  String? kesinTani;
  String? tedaviYontemi;
  String? etkilesimTuru;
  String? kapsam;
  String? gerceklestigiOrtam;

  String? tarih;
  String? status;
  String getTarih() => tarih ?? formatDate(DateTime.now().toLocal(), [dd, ' ', M, ' ', yyyy, ' ', HH, ':', nn]);
  String getKayitNo() => kayitNo ?? "";
  String getStajTuru() => stajTuru ?? "Diğer";
  String getDoktor() => doktor ?? "Diğer";
  String getYas() => yas ?? " ";
  String getCinsiyet() => cinsiyet ?? "Diğer";
  String getSikayet() => sikayet ?? " ";
  String getAyiriciTani() => ayiriciTani ?? " ";
  String getKesinTani() => kesinTani ?? "";
  String getTedaviYontemi() => tedaviYontemi ?? " ";
  String getEtkilesimTuru() => etkilesimTuru ?? "Gözlem";
  String getKapsam() => kapsam ?? "Öykü";
  String getOrtam() => gerceklestigiOrtam ?? "Poliklinik";
  String getStatus() => status ?? 'not implemented';
  FormData(
      {this.status,
      this.tarih,
      this.id,
      this.kayitNo,
      this.stajTuru,
      this.doktor,
      this.yas,
      this.cinsiyet,
      this.sikayet,
      this.ayiriciTani,
      this.kesinTani,
      this.tedaviYontemi,
      this.etkilesimTuru,
      this.kapsam,
      this.gerceklestigiOrtam});
  factory FormData.fromJson(Map<String, dynamic> json) {
    return FormData(kayitNo: json['kayit_no']);
  }

  factory FormData.fromMap(Map<String, dynamic> myMap) => FormData(
        id: myMap['id'],
        kayitNo: myMap['kayitNo'],
        stajTuru: myMap['stajTuru'],
        yas: myMap['yas'],
        doktor: myMap['klinikEgitici'],
        cinsiyet: myMap['cinsiyet'],
        sikayet: myMap['sikayet'],
        ayiriciTani: myMap['ayiriciTani'],
        kesinTani: myMap['kesinTani'],
        tedaviYontemi: myMap['tedaviYontemi'],
        etkilesimTuru: myMap['etkilesimTuru'],
        kapsam: myMap['kapsam'],
        gerceklestigiOrtam: myMap['ortam'],
      );

  Map<String, dynamic> toMap() {
    return {
      SQFLiteHelper.columnKayitNo: kayitNo,
      SQFLiteHelper.columnId: id,
      SQFLiteHelper.columnStajTuru: stajTuru,
      SQFLiteHelper.columnYas: yas,
      SQFLiteHelper.columnKlinikEgitici: doktor,
      SQFLiteHelper.columnCinsiyet: cinsiyet,
      SQFLiteHelper.columnSikayet: sikayet,
      SQFLiteHelper.columnAyiriciTani: ayiriciTani,
      SQFLiteHelper.columnKesinTani: kesinTani,
      SQFLiteHelper.columnTedaviYontemi: tedaviYontemi,
      SQFLiteHelper.columnEtkilesimTuru: etkilesimTuru,
      SQFLiteHelper.columnOrtam: gerceklestigiOrtam,
      SQFLiteHelper.columnKapsam: kapsam,
    };
  }

  void setStatus(String status) {
    this.status = status;
  }

  void setTarih() {
    tarih = formatDate(
        DateTime.now().toLocal(), [dd, ' ', M, ' ', yyyy, ' ', HH, ':', nn]);
  }

  void setStajTuru(String? stajTuru) {
    this.stajTuru = stajTuru;
    notifyListeners();
  }

  void setCinsiyet(String? cinsiyet) {
    this.cinsiyet = cinsiyet;
    notifyListeners();
  }

  void setEtkilesimTuru(String? etkilesim) {
    etkilesimTuru = etkilesim;
    notifyListeners();
  }

  void setKapsam(String? kapsam) {
    this.kapsam = kapsam;
    notifyListeners();
  }

  void setOrtam(String? ortam) {
    gerceklestigiOrtam = ortam;
    notifyListeners();
  }

  void setKayitNo(String? kayitNo) {
    this.kayitNo = kayitNo;
    notifyListeners();
  }

  void setYas(String? yas) {
    this.yas = yas;
    notifyListeners();
  }

  void setSikayet(String? sikayet) {
    this.sikayet = sikayet;
    notifyListeners();
  }

  void setAyiriciTani(String? ayiriciTani) {
    this.ayiriciTani = ayiriciTani;
    notifyListeners();
  }

  void setKesinTani(String? kesinTani) {
    this.kesinTani = kesinTani;
    notifyListeners();
  }

  void setTedaviYontemi(String? tedaviYontemi) {
    this.tedaviYontemi = tedaviYontemi;
    notifyListeners();
  }

  void setDoktor(String? doktor) {
    this.doktor = doktor;
    notifyListeners();
  }
}
