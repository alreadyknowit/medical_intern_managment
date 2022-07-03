import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:internship_managing_system/model/ProcedureLog.dart';
import 'package:internship_managing_system/student/services/SQFLiteHelper.dart';
import 'package:internship_managing_system/student/services/StudentDatabaseHelper.dart';

import '../../../model/AttendingPhysician.dart';
import '../../../model/Course.dart';
import '../../../model/Institute.dart';
import '../../../model/Speciality.dart';
import '../../../shared/constants.dart';
import '../../../shared/custom_alert.dart';
import '../../../shared/custom_snackbar.dart';
import '../../../shared/custom_spinkit.dart';
import '../../widgets/CustomDropDown.dart';
import '../../widgets/CustomTextField.dart';
import '../../widgets/FilteringDropDown.dart';

class TibbiShowDraft extends StatefulWidget {
  ProcedureLog? procedureLogDraft;
  TibbiShowDraft({this.procedureLogDraft});

  @override
  State<TibbiShowDraft> createState() => _PageState();
}

class _PageState extends State<TibbiShowDraft> {
  final SQFLiteHelper _helper = SQFLiteHelper.instance;
  final StudentDatabaseHelper _dbHelper = StudentDatabaseHelper();
  late bool isDeletable;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
          child: FutureBuilder(
              future: fetchFormContent(), //readJsonData(),
              builder: (context, snapshot) {
                if (snapshot.hasError) {
                  return const Center(
                      child: Text("Oops! Something went wrong."));
                } else if (snapshot.hasData) {
                  var listOfContent = snapshot.data as dynamic;
                  var courses = listOfContent[0];
                  var specialities = listOfContent[1];
                  var institutes = listOfContent[2];
                  var attendings = listOfContent[3];

                  var listOfOrtam = [
                    "Poliklinik",
                    "Servis",
                    "Acil",
                    "Yoğun Bakım",
                    "Ameliyathane",
                    "Dış Kurum"
                  ];
                  var listOfEtkilesimTuru = [
                    "Gözlem",
                    "Yardımla yapma",
                    "Yardımsız yapma",
                    "Sanal olgu",
                  ];

                  Map<String, dynamic> map = {
                    'course': courses,
                    'etkilesim': listOfEtkilesimTuru,
                    'ortam': listOfOrtam,
                    'specialities': specialities,
                    'institutes': institutes,
                    'attendings': attendings,
                  };
                  return isLoading ? spinkit : formWidget(map);
                } else {
                  return Center(
                    child: spinkit,
                  );
                }
              })),
      bottomNavigationBar: SizedBox(
        height: 44,
        width: double.infinity,
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceAround,
          children: [
            submitButton(Icons.send, context, "İLET", formIlet),
            submitButton(Icons.drafts_sharp, context, "GÜNCELLE", formGuncelle),
            submitButton(Icons.drafts_sharp, context, "SİL", formSil),
          ],
        ),
      ),
    );
  }

  Form formWidget(Map<String, dynamic> map) {
    return Form(
      key: _formKey,
      child: SingleChildScrollView(
        child: Column(
          //  shrinkWrap: true,
          children: [
            FilteringDropDown(
                2,
                _procedureLog.setInstute,
                _procedureLog.setCourse,
                _procedureLog.setSpeciality,
                _procedureLog.setAttendingPhysician),
            CustomDropDown(_procedureLog.etkilesimTuru, map['etkilesim'],
                " Etkileşim Türü", _procedureLog.setEtkilesimTuru),
            CustomDropDown(_procedureLog.gerceklestigiOrtam, map['ortam'],
                " Gerçekleştiği Ortam", _procedureLog.setGerceklestigiOrtam),
            const SizedBox(
              height: 20,
            ),
            CustomTextField(_kayitController, 1, "Kayıt No ", 10,
                _procedureLog.setKayitNo, 80),
            CustomTextField(_tibbiUygulamaController, 5, "Tıbbi İşlem Uygulama",
                200, _procedureLog.setTibbiUygulama, 130),
          ],
        ),
      ),
    );
  }

  final ProcedureLog _procedureLog = ProcedureLog();
  late ProcedureLog? args;

  final _formKey = GlobalKey<FormState>();

  final TextEditingController _kayitController = TextEditingController();
  final TextEditingController _tibbiUygulamaController =
      TextEditingController();

  bool isLoading = false;

  Future<List<List<dynamic>>> fetchFormContent() async {
    List<List<dynamic>> res = [];
    List<AttendingPhysician> attendings =
        await _dbHelper.fetchAttendingPhysicians();
    List<Course> courses = await _dbHelper.fetchCourses();
    List<Speciality> speciality = await _dbHelper.fetchSpeciality();
    List<Institute> institute = await _dbHelper.fetchInstitute();

    res.add(courses);
    res.add(speciality);
    res.add(institute);
    res.add(attendings);
    fillContent();

    return res;
  }

  void fillContent() {
    ProcedureLog? draftedLog = widget.procedureLogDraft;
    if (draftedLog != null) {
      //dropdown
      _procedureLog.setId(draftedLog.id);
      _procedureLog.setInstute(draftedLog.institute);
      _procedureLog.setEtkilesimTuru(draftedLog.etkilesimTuru);
      _procedureLog.setCourse(draftedLog.course);
      _procedureLog.setSpeciality(draftedLog.speciality);
      _procedureLog.setCoordinator(draftedLog.coordinator);
      _procedureLog.setAttendingPhysician(draftedLog.attendingPhysician);
      _procedureLog.setStudent(draftedLog.student);
      _procedureLog.setGerceklestigiOrtam(draftedLog.gerceklestigiOrtam);

      //text
      _procedureLog.setTibbiUygulama(draftedLog.tibbiUygulama);
      _tibbiUygulamaController.text = draftedLog.tibbiUygulama ?? "";

      _procedureLog.setKayitNo(draftedLog.kayitNo);
      _kayitController.text = draftedLog.kayitNo ?? "";
    }
  }

  formIlet() async {
    bool res = await _dbHelper.insertTibbiFormToDatabase(_procedureLog);
    res == true
        ? customSnackBar(context, 'Başarıyla gönderildi')
        : errorAlert(context);
  }

  void formGuncelle() async {
    int? id = _procedureLog.id;
    int res = 0;
    if (id != null) {
      res = await _helper.updateTibbi(_procedureLog);
    }
    res != 1
        ? errorAlert(context)
        : customSnackBar(context, 'Başarıyla taslağa kaydedildi');
  }

  formSil() async {
    int res = await _helper.removeTibbi(_procedureLog.id).then((value) {
      Navigator.pop(context);
      return value;
    });
    if (res == 1) {
      setState(() {
        customSnackBar(context, 'Başarıyla silindi');
      });
    }
  }

  ElevatedButton submitButton(IconData icon, BuildContext context, String title,
      Function handleSubmit) {
    return ElevatedButton(
      style: ElevatedButton.styleFrom(
        primary: PRIMARY_BUTTON_COLOR,
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(5.0)),
        minimumSize: const Size(120, double.infinity), //////// HERE
      ),
      onPressed: () => handleSubmit(),
      child: Container(
        margin: const EdgeInsets.symmetric(horizontal: 0),
        child: Text(title),
      ),
    );
  }
}
