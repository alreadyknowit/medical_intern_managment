import 'package:flutter/cupertino.dart';
import 'package:internship_managing_system/models/attending_physician.dart';

class FormData {
   String? _kayitNo;
   String? _stajTuru;
   String? _doktor; //TODO: Convert string to AttendingPhysician type object
  // late AttendingPhysician klinikEgitici;
   String? _yas; // TODO: Convert to string later
   String? _cinsiyet;
   String? _sikayet;
   String? _ayiriciTani;
   String? _kesinTani;
   String? _tedaviYontemi;
   String? _etkilesimTuru;
   String? _kapsam;
   String? _gerceklestigiOrtam;
  //DateTime tarih;

    String getKayitNo()=>_kayitNo!;
    String getStajTuru()=>_stajTuru!;
    String getDoktor()=>_doktor!;
    String getYas()=>_yas!;
    String getCinsiyet()=>_cinsiyet!;
    String getSikayet()=>_sikayet!;
    String getAyiriciTani()=>_ayiriciTani!;
    String getKesinTani()=>_kesinTani!;
    String getTedaviYontemi()=>_tedaviYontemi!;
    String getEtkilesimTuru()=>_etkilesimTuru!;
    String getKapsam()=>_kapsam!;
    String getOrtam()=>_gerceklestigiOrtam!;
  void setStajTuru(String stajTuru) {
    _stajTuru = stajTuru;
  }

  void setCinsiyet(String cinsiyet) {
    _cinsiyet = cinsiyet;
  }

  void setEtkilesimTuru(String etkilesim) {
    _etkilesimTuru = etkilesim;
  }

  void setKapsam(String kapsam) {
    _kapsam = kapsam;
  }

  void setOrtam(String ortam) {
    _gerceklestigiOrtam = ortam;
  }

  void setKayitNo(String kayitNo) {
    _kayitNo = kayitNo;
  }

  void setYas(String yas) {
    _yas = yas;
  }

  void setSikayet(String sikayet) {
    _sikayet = sikayet;
  }

  void setAyiriciTani(String ayiriciTani) {
    _ayiriciTani = ayiriciTani;
  }

  void setKesinTani(String kesinTani) {
    _kesinTani = kesinTani;
  }

  void setTedaviYontemi(String tedaviYontemi) {
    _tedaviYontemi = tedaviYontemi;
  }
  void setDoktor(String doktor){
    _doktor=doktor;

  }
/*
  FormData.fromJson(Map<String,dynamic> jsonFile){

  }
*/
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
