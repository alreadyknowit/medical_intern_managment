import 'dart:core';

import 'package:date_format/date_format.dart';
import 'package:internship_managing_system/models/MainForm.dart';

import '../student/services/SQFLiteHelper.dart';

class TibbiFormData extends MainForm {
  int? id;
  String? kayitNo;
  String? stajTuru;
  String? doktor; //TODO: Convert string to AttendingPhysician type object
  String? tibbiEtkilesimTuru;
  String? tibbiOrtam;
  String? disKurum;
  String? tibbiUygulama;
  String? tarih;
  String? status;
  int? getID() => id;
  String getTarih() =>
      tarih ??
      formatDate(
          DateTime.now().toLocal(), [dd, ' ', M, ' ', yyyy, ' ', HH, ':', nn]);
  String getKayitNo() => kayitNo ?? "";
  String getStajTuru() => stajTuru ?? "Diğer";
  String getDoktor() => doktor ?? "Diğer";
  String getTibbiEtkilesimTuru() => tibbiEtkilesimTuru ?? "Gözlem";
  String getTibbiUygulama() => tibbiUygulama ?? "";
  String getDisKurum() => disKurum ?? "";
  String getTibbiOrtam() => tibbiOrtam ?? "";
  String getStatus() => status ?? 'not implemented';
  TibbiFormData(
      {this.status,
      this.tarih,
      this.id,
      this.kayitNo,
      this.stajTuru,
      this.doktor,
      this.tibbiEtkilesimTuru,
      this.disKurum,
      this.tibbiOrtam,
      this.tibbiUygulama});
  factory TibbiFormData.fromJson(Map<String, dynamic> myMap) {
    return TibbiFormData(
      id: checkID(myMap['id']),
      kayitNo: myMap['kayit_no'],
      stajTuru: myMap['staj_turu'],
      doktor: myMap['klinik_egitici'],
      tibbiEtkilesimTuru: myMap['etkilesim_turu'],
      tibbiOrtam: myMap['tibbi_ortam'],
      tibbiUygulama: myMap['tibbi_uygulama'],
      disKurum: myMap['dis_kurum'],
    );
  }

  static checkID(var id) {
    return id is int ? id : int.parse(id);
  }

  factory TibbiFormData.fromMap(Map<String, dynamic> myMap) => TibbiFormData(
        id: myMap['id'],
        kayitNo: myMap['kayit_no'],
        stajTuru: myMap['staj_turu'],
        doktor: myMap['klinik_egitici'],
        tibbiEtkilesimTuru: myMap['etkilesim_turu'],
        tibbiOrtam: myMap['tibbi_ortam'],
        tibbiUygulama: myMap['tibbi_uygulama'],
        disKurum: myMap['dis_kurum'],
      );

  Map<String, dynamic> toMap() {
    return {
      SQFLiteHelper.columnKayitNo: kayitNo,
      SQFLiteHelper.columnId: id,
      SQFLiteHelper.columnStajTuru: stajTuru,
      SQFLiteHelper.columnKlinikEgitici: doktor,
      //SQFLiteHelper.columnTibbiEtkilesimTuru: tibbiEtkilesimTuru,
      SQFLiteHelper.columnOrtam: tibbiOrtam,
      SQFLiteHelper.columnTarih: tarih,
      SQFLiteHelper.columnStatus: status
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

  void setKayitNo(String? kayitNo) {
    this.kayitNo = kayitNo;
    notifyListeners();
  }

  void setTibbiOrtam(String? tibbiOrtam) {
    this.tibbiOrtam = tibbiOrtam;
    notifyListeners();
  }

  void setTibbiEtkilesimTuru(String? tibbiEtkilesimTuru) {
    this.tibbiEtkilesimTuru = tibbiEtkilesimTuru;
    notifyListeners();
  }

  void setDoktor(String? doktor) {
    this.doktor = doktor;
    notifyListeners();
  }

  void setTibbiUygulama(String? tibbiUygulama) {
    this.tibbiUygulama = tibbiUygulama;
    notifyListeners();
  }

  void setDisKurum(String? disKurum) {
    this.disKurum = disKurum;
    notifyListeners();
  }
}
