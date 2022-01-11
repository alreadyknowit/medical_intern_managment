

import 'package:flutter/cupertino.dart';


class FormData  with ChangeNotifier{
   String? kayitNo;
   String? stajTuru;
   String? doktor; //TODO: Convert string to AttendingPhysician type object
  // late AttendingPhysician klinikEgitici;
   String? yas; // TODO: Convert to string later
   String? cinsiyet;
   String? sikayet;
   String? ayiriciTani;
   String? kesinTani;
   String? tedaviYontemi;
   String? etkilesimTuru;
   String? kapsam;
   String? gerceklestigiOrtam;
  //DateTime tarih;

    String getKayitNo()=>kayitNo ?? "";
    String getStajTuru()=>stajTuru ?? "Diğer";
    String getDoktor()=>doktor ?? "Diğer";
    String getYas()=>yas ?? "";
    String getCinsiyet()=>cinsiyet ??  "Diğer";
    String getSikayet()=>sikayet ?? "";
    String getAyiriciTani()=>ayiriciTani ?? "";
    String getKesinTani()=>kesinTani ?? "";
    String getTedaviYontemi()=>tedaviYontemi ?? "";
    String getEtkilesimTuru()=>etkilesimTuru ?? "Gözlem";
    String getKapsam()=>kapsam  ?? "Öykü";
    String getOrtam()=>gerceklestigiOrtam ?? "Poliklinik";



FormData({this.kayitNo, this.stajTuru,this.doktor,this.yas,this.cinsiyet,this.sikayet,this.ayiriciTani,this.kesinTani,this.tedaviYontemi,this.etkilesimTuru,this.kapsam,this.gerceklestigiOrtam});
   factory FormData.fromJson(Map<String,dynamic> json){
     return FormData(
      kayitNo: json['kayit_no']
     );
   }
  void setStajTuru(String stajTuru) {
    this.stajTuru = stajTuru;
    notifyListeners();
  }

  void setCinsiyet(String cinsiyet) {
    this.cinsiyet = cinsiyet;
    notifyListeners();
  }

  void setEtkilesimTuru(String etkilesim) {
    etkilesimTuru = etkilesim;
    notifyListeners();
  }

  void setKapsam(String kapsam) {
    this.kapsam = kapsam;
    notifyListeners();
  }

  void setOrtam(String ortam) {
    gerceklestigiOrtam = ortam;
    notifyListeners();
  }

  void setKayitNo(String kayitNo) {
    this.kayitNo = kayitNo;
    notifyListeners();
  }

  void setYas(String yas) {
    this.yas = yas;
    notifyListeners();
  }

  void setSikayet(String sikayet) {
    this.sikayet = sikayet;
    notifyListeners();
  }

  void setAyiriciTani(String ayiriciTani) {
    this.ayiriciTani = ayiriciTani;
    notifyListeners();
  }

  void setKesinTani(String kesinTani) {
    this.kesinTani = kesinTani;
    notifyListeners();
  }

  void setTedaviYontemi(String tedaviYontemi) {
    this.tedaviYontemi = tedaviYontemi;
    notifyListeners();
  }
  void setDoktor(String doktor){
    this.doktor=doktor;
    notifyListeners();

  }
}
