import 'package:flutter/material.dart';
import 'package:internship_managing_system/model/AttendingPhysician.dart';
import 'package:internship_managing_system/model/ProcedureLog.dart';
import 'package:internship_managing_system/shared/custom_spinkit.dart';
import 'package:internship_managing_system/student/arguments/form_args.dart';
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
    tibbiFormArguments =
        ModalRoute.of(context)?.settings.arguments as TibbiFormArguments?;
    if (tibbiFormArguments != null) {
      isDeletable = tibbiFormArguments!.isDeletable ?? true;
      args = tibbiFormArguments?.tibbiFormData;
      _kayitController.text = args!.kayitNo.toString();

      //dropdown
      _valueTibbiOrtam = args!.gerceklestigiOrtam.toString();
      _valueTibbiEtkilesimTuru = args!.etkilesimTuru.toString();
      //

      _doktorController.text = args!.attendingPhysician.toString();
      _tibbiUygulamaController.text = args!.tibbiUygulama.toString();
      _stajTuruController.text = args!.speciality.toString();
      _instituteController.text = args!.instute.toString();
      _courseController.text = args!.course.toString();
    }

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
            tibbiFormArguments != null && isDeletable
                ? submitButton(Icons.delete, context, "SİL", handleDelete)
                : Container(),
            submitButton(Icons.drafts_sharp, context, "SAKLA", formSakla),
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
            CustomTextField(_kayitController, 5, "Tıbbi İşlem Uygulama", 200,
                _procedureLog.setTibbiUygulama, 130),
          ],
        ),
      ),
    );
  }

  final ProcedureLog _procedureLog = ProcedureLog();
  late ProcedureLog? args;
  //late int? index;

  TibbiFormArguments? tibbiFormArguments;
  final _formKey = GlobalKey<FormState>();
  String _valueTibbiEtkilesimTuru = 'Gözlem';
  String _valueTibbiOrtam = 'Poliklinik';

  final TextEditingController _kayitController = TextEditingController();
  final TextEditingController _tibbiUygulamaController =
      TextEditingController();
  final TextEditingController _disKurumController = TextEditingController();
  final TextEditingController _stajTuruController = TextEditingController();
  final TextEditingController _doktorController = TextEditingController();
  final TextEditingController _instituteController = TextEditingController();
  final TextEditingController _courseController = TextEditingController();

  bool isLoading = false;
  /*formSakla() {}
  formIlet() {}
  handleDelete() {}*/

  void formSakla() async {
    Course course = await _helper.getCourse(3);
    Speciality speciality = await _helper.getSpeciality(1);
    AttendingPhysician attendingPhysician = await _helper.getAttending(3);
    Institute institute = await _helper.getInstitute(2);
    _procedureLog.setCourse(course);
    _procedureLog.setAttendingPhysician(attendingPhysician);
    _procedureLog.setInstute(institute);
    _procedureLog.setSpeciality(speciality);
    //final res = await _helper.insertPatientLog(_procedureLog);
    //res==false ? errorAlert(context) : customSnackBar(context, 'Başarıyla taslağa kaydedildi');
  }

  void handleDelete() {
    setState(() {
      _helper.remove(tibbiFormArguments!.tibbiFormData.id);
      Navigator.pop(context);
      customSnackBar(context, 'Başarıyla silindi');
      //  Navigator.pop(context, MaterialPageRoute(builder: (context) => Drafts()));
    });
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
