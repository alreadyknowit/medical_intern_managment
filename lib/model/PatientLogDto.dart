class PatientLogDto {
  int?  id;
  int? course;
  int? speciality;
  int? attendingPhysician;
  int? student;
  int? coordinator;
  int? institute;
  String? kayitNo;
  String? yas;
  String? cinsiyet;
  String? sikayet;
  String? ayiriciTani;
  String? kesinTani;
  String? tedaviYontemi;
  String? etkilesimTuru;
  String? kapsam;
  String? gerceklestigiOrtam;
  String? status;
  String? tarih;

  PatientLogDto({
    coordinator,
    institute,
    speciality,
    id,
    kayitNo,
    course,
    attending,
    yas,
    cinsiyet,
    sikayet,
    ayiriciTani,
    kesinTani,
    tedaviYontemi,
    etkilesimTuru,
    kapsam,
    tarih,
    gerceklestigiOrtam,
  });

     PatientLogDto.fromMap(Map<String, dynamic> myMap) :
         id= myMap['id'],
         kayitNo= myMap['kayit_no'],
         institute= myMap['institute_id'],
         speciality= myMap['speciality_id'],
         course= myMap['course_id'],
         attendingPhysician= myMap['attending_id'],
         yas= myMap['yas'] != null && myMap['yas'].toString() != "null" ? myMap['yas'].toString() : "",
         cinsiyet= myMap['cinsiyet'],
         sikayet= myMap['sikayet'],
         ayiriciTani= myMap['ayirici_tani'],
         kesinTani= myMap['kesin_tani'],
         tedaviYontemi= myMap['tedavi_yontemi'],
         etkilesimTuru= myMap['etkilesim_turu'],
         kapsam= myMap['kapsam'],
         gerceklestigiOrtam= myMap['ortam'],
         coordinator=myMap['coordinator'] ,
         student=myMap['student'],
         tarih= myMap['tarih'];



  @override
  String toString() {
    return 'PatientLogDto{id: $id, course: $course, speciality: $speciality, attendingPhysician: $attendingPhysician, student: $student, coordinator: $coordinator, institute: $institute, kayitNo: $kayitNo, yas: $yas, cinsiyet: $cinsiyet, sikayet: $sikayet, ayiriciTani: $ayiriciTani, kesinTani: $kesinTani, tedaviYontemi: $tedaviYontemi, etkilesimTuru: $etkilesimTuru, kapsam: $kapsam, gerceklestigiOrtam: $gerceklestigiOrtam, status: $status}';
  }
}
