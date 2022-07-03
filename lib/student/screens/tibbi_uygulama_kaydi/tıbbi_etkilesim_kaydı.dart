import 'package:flutter/material.dart';
import 'package:internship_managing_system/model/AttendingPhysician.dart';
import 'package:internship_managing_system/model/ProcedureLog.dart';
import 'package:internship_managing_system/shared/custom_spinkit.dart';
import 'package:internship_managing_system/student/services/SQFLiteHelper.dart';
import 'package:internship_managing_system/student/services/StudentDatabaseHelper.dart';
import 'package:internship_managing_system/student/widgets/FilteringDropDown.dart';

import '../../../model/Course.dart';
import '../../../model/Institute.dart';
import '../../../model/Speciality.dart';
import '../../../shared/custom_alert.dart';
import '../../../shared/custom_snackbar.dart';
import '../../widgets/CustomDropDown.dart';
import '../../widgets/CustomTextField.dart';
import '../../widgets/widgets.dart';

class TibbiUygulama extends StatefulWidget {
  const TibbiUygulama({Key? key}) : super(key: key);
  @override
  State<TibbiUygulama> createState() => _TibbiUyglamaState();
}

class _TibbiUyglamaState extends State<TibbiUygulama> {
  @override
  initState() {
    fetchFormContent();
    super.initState();
  }

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
            submitButton(Icons.drafts_sharp, context, "SAKLA", formSakla),
          ],
        ),
      ),
    );
  }

  @override
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

  void formSakla() async {
    /*Course course = await _helper.getCourse(3);
    Speciality speciality = await _helper.getSpeciality(1);
    AttendingPhysician attendingPhysician = await _helper.getAttending(3);
    Institute institute = await _helper.getInstitute(2);
    _procedureLog.setCourse(course);
    _procedureLog.setAttendingPhysician(attendingPhysician);
    _procedureLog.setInstute(institute);
    _procedureLog.setSpeciality(speciality);*/
    final res = await _helper.insertProcedureLog(_procedureLog);
    res == false
        ? errorAlert(context)
        : customSnackBar(context, 'Başarıyla taslağa kaydedildi');
  }

  formIlet() async {
    bool res = await _dbHelper.insertTibbiFormToDatabase(_procedureLog);
    res == true
        ? customSnackBar(context, 'Başarıyla gönderildi')
        : errorAlert(context);
  }

  String? isNumeric(String? num) {
    if (num == null) {
      return 'Boş bırakılamaz';
    } else if (int.tryParse(num) == null) {
      return 'Hastanın yaşı rakamlardan oluşmalıdır';
    }
  }

  String? isEmpty(String val) {
    String? text;
    setState(() {
      if (val.isEmpty) {
        text = 'Boş bırakılamaz';
      }
    });
    return text;
  }

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

    return res;
  }
}
