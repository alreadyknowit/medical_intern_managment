import 'package:internship_managing_system/attending_physician.dart';

class FormData {
  String kayitNo;
  String stajTuru;
  AttendingPhysician klinikEgitici;
  int yas;
  String cinsiyet;
  String sikayet;
  String ayiriciTani;
  String kesinTani;
  String tedaviYontemi;
  String etkilesimTuru;
  String kapsam;
  String gerceklestigiOrtam;
  //DateTime tarih;

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
      required this.yas});
}
