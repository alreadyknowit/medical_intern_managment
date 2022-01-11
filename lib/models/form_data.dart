

import 'package:flutter/cupertino.dart';


class FormData  with ChangeNotifier{
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

    String getKayitNo()=>_kayitNo ?? "";
    String getStajTuru()=>_stajTuru ?? "Diğer";
    String getDoktor()=>_doktor ?? "Diğer";
    String getYas()=>_yas ?? "";
    String getCinsiyet()=>_cinsiyet ??  "Diğer";
    String getSikayet()=>_sikayet ?? "";
    String getAyiriciTani()=>_ayiriciTani ?? "";
    String getKesinTani()=>_kesinTani ?? "";
    String getTedaviYontemi()=>_tedaviYontemi ?? "";
    String getEtkilesimTuru()=>_etkilesimTuru ?? "Gözlem";
    String getKapsam()=>_kapsam  ?? "Öykü";
    String getOrtam()=>_gerceklestigiOrtam ?? "Poliklinik";

  void setStajTuru(String stajTuru) {
    _stajTuru = stajTuru;
    notifyListeners();
  }

  void setCinsiyet(String cinsiyet) {
    _cinsiyet = cinsiyet;
    notifyListeners();
  }

  void setEtkilesimTuru(String etkilesim) {
    _etkilesimTuru = etkilesim;
    notifyListeners();
  }

  void setKapsam(String kapsam) {
    _kapsam = kapsam;
    notifyListeners();
  }

  void setOrtam(String ortam) {
    _gerceklestigiOrtam = ortam;
    notifyListeners();
  }

  void setKayitNo(String kayitNo) {
    _kayitNo = kayitNo;
    notifyListeners();
  }

  void setYas(String yas) {
    _yas = yas;
    notifyListeners();
  }

  void setSikayet(String sikayet) {
    _sikayet = sikayet;
    notifyListeners();
  }

  void setAyiriciTani(String ayiriciTani) {
    _ayiriciTani = ayiriciTani;
    notifyListeners();
  }

  void setKesinTani(String kesinTani) {
    _kesinTani = kesinTani;
    notifyListeners();
  }

  void setTedaviYontemi(String tedaviYontemi) {
    _tedaviYontemi = tedaviYontemi;
    notifyListeners();
  }
  void setDoktor(String doktor){
    _doktor=doktor;
    notifyListeners();

  }
}
