import 'package:flutter/cupertino.dart';
import 'package:internship_managing_system/models/attending_physician.dart';

class FormData {
  late String kayitNo;
  late String stajTuru;
  // late AttendingPhysician klinikEgitici;
  late String yas; // TODO: Convert to string later
  late String cinsiyet;
  late String sikayet;
  late String ayiriciTani;
  late String kesinTani;
  late String tedaviYontemi;
  late String etkilesimTuru;
  late String kapsam;
  late String gerceklestigiOrtam;
  //DateTime tarih;

  void setStajTuru(String stajTuru) {
    this.stajTuru = stajTuru;
  }

  void setCinsiyet(String cinsiyet) {
    this.cinsiyet = cinsiyet;
  }

  void setEtkilesimTuru(String etkilesim) {
    etkilesimTuru = etkilesim;
  }

  void setKapsam(String kapsam) {
    this.kapsam = kapsam;
  }

  void setOrtam(String ortam) {
    gerceklestigiOrtam = ortam;
  }

  void setKayitNo(String kayitNo) {
    this.kayitNo = kayitNo;
  }

  void setYas(String yas) {
    this.yas = yas;
  }

  void setSikayet(String sikayet) {
    this.sikayet = sikayet;
  }

  void setAyiriciTani(String ayiriciTani) {
    this.ayiriciTani = ayiriciTani;
  }

  void setKesinTani(String kesinTani) {
    this.kesinTani = kesinTani;
  }

  void setTedaviYontemi(String tedaviYontemi) {
    this.tedaviYontemi = tedaviYontemi;
  }
/*
  FormData(
      {required this.ayiriciTani,
      required this.cinsiyet,
      required this.etkilesimTuru,
      required this.gerceklestigiOrtam,
      required this.kapsam,
      required this.kayitNo,
      required this.kesinTani,
      required this.klinikEgitici,
      required this.sikayet,
      required this.stajTuru,
      required this.tedaviYontemi,
      required this.yas});*/
}
