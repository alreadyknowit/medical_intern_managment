class ProcedureLogDto {
  int? id;
  int? course;
  int? speciality;
  int? attendingPhysician;
  int? student;
  int? coordinator;
  int? institute;
  String? kayitNo;
  String? tibbiUygulama;
  String? etkilesimTuru;
  String? gerceklestigiOrtam;
  String? status;
  String? tarih;

  ProcedureLogDto({
    kayitNo,
    status,
    tarih,
    id,
    institute,
    course,
    speciality,
    attendingPhysician,
    tibbiUygulama,
    etkilesimTuru,
    gerceklestigiOrtam,
  });

  ProcedureLogDto.fromMap(Map<String, dynamic> myMap)
      : id = myMap['id'],
        kayitNo = myMap['kayit_no'],
        institute = myMap['institute_id'],
        speciality = myMap['speciality_id'],
        course = myMap['course_id'],
        attendingPhysician = myMap['attending_id'],
        gerceklestigiOrtam = myMap['ortam'],
        etkilesimTuru = myMap['etkilesim_turu'],
        tibbiUygulama = myMap['tibbi_uygulama'],
        student = myMap['student'],
        coordinator = myMap['coordinator'],
        tarih = myMap['tarih'];

  @override
  String toString() {
    return 'ProcedureLogDto{id: $id, course: $course, speciality: $speciality, attendingPhysician: $attendingPhysician, student: $student, coordinator: $coordinator, institute: $institute, kayitNo: $kayitNo, tibbiUygulama $tibbiUygulama, etkilesimTuru: $etkilesimTuru, gerceklestigiOrtam: $gerceklestigiOrtam, status: $status}';
  }
}
